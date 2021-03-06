#!/usr/bin/env python3
# -*- mode:python; coding:utf-8 -*-

import time
from datetime import datetime,timedelta
import syslog
import os
import serial
import struct
import binascii
import glob
import pprint
from logging import getLogger,INFO,DEBUG,Formatter
from logging.handlers import SysLogHandler
import smtplib
from email.mime.text import MIMEText

SerialDevice = "/dev/ttyUSB0"
OutDir = "/var/run/twe"
RainMarker = OutDir + "/RainMarker"

handler = SysLogHandler(address = '/dev/log', facility=SysLogHandler.LOG_USER)
handler.setFormatter(Formatter("twe-monitor[%(process)d]: %(message)s"))
handler.setLevel(INFO)
logger = getLogger("twe-monitor")
logger.setLevel(DEBUG)
logger.addHandler(handler)

def decodeVolt(batt):
    volt = 0
    if batt <= 170:
        volt = 1950 + 5 * batt
    else:
        volt = 2800 + 10 * (batt - 170)
    return volt

def touch(fname, times=None):
    with open(fname, 'a'):
                os.utime(fname, times)

def notifyRain(results):
    fromAddr="twe@localhost"
    toAddr="twe@localhost"
    if 'MAIL_FROM' in os.environ:
        fromAddr = os.environ['MAIL_FROM']
    if 'RCPT_TO' in os.environ:
        toAddr = os.environ['RCPT_TO']
    closed = ",".join(sorted([chr(0x40 + v["id"]) for v in results if v["pkt"] == 254 and v["button"] == 1]))
    opened = ",".join(sorted([chr(0x40 + v["id"]) for v in results if v["pkt"] == 254 and v["button"] == 0]))
    text = "\n".join(["The weather is rain.", "", " Opened: " + opened, " Closed: " + closed])
    msg = MIMEText(text)
    msg['Subject'] = "It's rain."
    msg['From'] = fromAddr
    msg['To'] = toAddr
    recipients = toAddr.split(',')
    s = smtplib.SMTP()
    s.connect()
    s.sendmail(fromAddr, recipients, msg.as_string())
    s.close()

def collectDoorStatus():
    file_list = glob.glob(OutDir + "/8*.parsed")
    for f in file_list:
        mtime = os.stat(f).st_mtime
        if (datetime.now() - datetime.fromtimestamp(mtime)) > timedelta(minutes=5):
            os.unlink(f)

def checkRain(weather, volt, rainRatioLow, rainRatioHigh, results):
    hasMarker = os.path.exists(RainMarker)
    ratio = float(weather) / volt
    if ratio < rainRatioLow and not hasMarker:
        # It's rain
        logger.info("It starts raining. adc2:%d, volt:%d", weather, volt)
        touch(RainMarker)
        notifyRain(results)
    elif ratio > rainRatioHigh and hasMarker:
        mtime = datetime.fromtimestamp(os.stat(RainMarker).st_mtime)
        if datetime.now() - mtime > timedelta(hours=1):
            # remove rain report
            logger.info("It ends raining. adc2:%d, volt:%d", weather, volt)
            os.remove(RainMarker)

# Decode output of vSerOutput_Uart().
def parseTWELite(raw):
    if raw[0] != ":":
        return {}
    data = None
    try:
        data = binascii.unhexlify(raw[1:])
    except TypeError as e:
        logger.error('twe-monitor.py', exc_info=True)

    if data is None:
        return {}

    pkt = raw[25:27]
    result = None

    if pkt == '10':
        logger.debug("Received %s", raw)
        # relay,LQI,FRAME,src,u8id,u8pkt,batt,adc1,adc2,PC1,PC2,CRC
        ss10 = struct.Struct(">IBHIBBBHHHHB")
        parsed = ss10.unpack(data)

        volt = decodeVolt(parsed[6])

        result = {
            "relay" : "{0:08X}".format(parsed[0]),
            "lqi" : parsed[1],
            "frame" : parsed[2],
            "from" : "{0:08X}".format(parsed[3]),
            "id": parsed[4],
            "pkt": parsed[5],
            "volt": volt,
            "vc2" : 2 * parsed[7],
            "adc2" : parsed[8],
            "PC1" : parsed[9],
            "PC2" : parsed[10],
            "updated" : datetime.now()
        }
    elif pkt == 'FE':
        # relay,LQI,FRAME,src,u8id,u8pkt,batt,adc1,adc2,param,DIbitmap,CRC
        ssFE = struct.Struct(">IBHIBBBHHBBB")
        parsed = ssFE.unpack(data)

        volt = decodeVolt(parsed[6])

        result = {
            "relay" : "{0:08X}".format(parsed[0]),
            "lqi" : parsed[1],
            "frame" : parsed[2],
            "from" : "{0:08X}".format(parsed[3]),
            "id": parsed[4],
            "pkt": parsed[5],
            "volt": volt,
            "vc2" : 2 * parsed[7],
            "adc2" : parsed[8],
            "param" : parsed[9],
            "button" : parsed[10],
            "updated" : datetime.now()
        }
    return result

def expireOldFile():
    file_list = glob.glob(OutDir + "/8*")
    for f in file_list:
        mtime = os.stat(f).st_mtime
        if (datetime.now() - datetime.fromtimestamp(mtime)) > timedelta(minutes=5):
            os.unlink(f)

if __name__ == '__main__':
    logger.info("Started")
    if not os.path.exists(OutDir):
        os.mkdir(OutDir)
        os.chmod(OutDir, 0o775)
    ioResults = {}
    sertty = serial.Serial(port=SerialDevice, baudrate=115200, timeout=60)
    rainSensorId=256
    if 'RAIN_SENSOR_ID' in os.environ:
        rainSensorId=int(os.environ['RAIN_SENSOR_ID'])
    rainRatioLow=0.4
    rainRatioHigh=0.7
    if 'RAIN_RATIO_LOW' in os.environ:
        rainRatioLow=float(os.environ['RAIN_RATIO_LOW'])
    if 'RAIN_RATIO_HIGH' in os.environ:
        rainRatioHigh=float(os.environ['RAIN_RATIO_HIGH'])
    logger.info("rainSensorId %d, rainRatioLow %f, rainRatioHigh %f", rainSensorId, rainRatioLow, rainRatioHigh)
    while True:
        try:
            rx = sertty.readline().decode('utf-8').rstrip()
            parsed = parseTWELite(rx)
            if "from" in parsed:
                src = parsed["from"]
                ioResults[src] = parsed
                raw = open(OutDir + "/_" + src, "w")
                raw.write(rx)
                raw.close()
                os.rename(OutDir + "/_" + src, OutDir + "/" + src)
                raw = open(OutDir + "/_" + src + ".raw", "w")
                raw.write("#" + rx + "\n")
                raw.write(pprint.pformat(parsed))
                raw.close()
                os.rename(OutDir + "/_" + src + ".raw", OutDir + "/" + src + ".parsed")
                if parsed["id"] == rainSensorId:
                    checkRain(parsed["adc2"], parsed["volt"], rainRatioLow, rainRatioHigh, ioResults.values())
            toExpire = {}
            for k in ioResults.keys():
                if (datetime.now() - ioResults[k]["updated"]) > timedelta(minutes=5):
                    toExpire[k] = True;
            for k in toExpire.keys():
                del ioResults[k]
        except Exception as e:
            logger.error('twe-monitor.py', exc_info=True)
            break
    
    sertty.close()
