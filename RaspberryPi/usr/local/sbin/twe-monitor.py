#!/usr/bin/env python2.7
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
import logging
import smtplib
from email.mime.text import MIMEText

SerialDevice = "/dev/ttyUSB0"
OutDir = "/var/run/twe"
RainMarker = OutDir + "/RainMarker"

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

def notifyRain():
    fromAddr="twe@localhost"
    toAddr="twe@localhost"
    if 'MAIL_FROM' in os.environ:
        fromAddr = os.environ['MAIL_FROM']
    if 'RCPT_TO' in os.environ:
        toAddr = os.environ['RCPT_TO']
    msg = MIMEText("The weather is rain.")
    msg['Subject'] = "It's rain."
    msg['From'] = fromAddr
    msg['To'] = toAddr
    s = smtplib.SMTP()
    s.connect()
    s.sendmail(fromAddr, [toAddr], msg.as_string())
    s.close()
                
def checkRain(weather):
    hasMarker = os.path.exists(RainMarker)
    if weather < 1200 and not hasMarker:
        # It's rain
        touch(RainMarker)
        notifyRain()
    elif weather > 2000 and hasMarker:
        # remove rain report
        os.remove(RainMarker)

# Decode output of vSerOutput_Uart().
def parseTWELite(raw):
    if raw[0] != ":":
        return {}
    data = binascii.unhexlify(raw[1:])
    pkt = raw[25:27]
    result = None

    if pkt == '10':
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
            "PC2" : parsed[10]
        }
        checkRain(result["adc2"])
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
            "button" : parsed[10]
        }
    return result

def expireOldFile():
    file_list = glob.glob(OutDir + "/8*")
    for f in file_list:
        mtime = os.stat(f).st_mtime
        if (datetime.now() - datetime.fromtimestamp(mtime)) > timedelta(minutes=5):
            os.unlink(f)

if __name__ == '__main__':
    if not os.path.exists(OutDir):
        os.mkdir(OutDir, 0775)
        
    sertty = serial.Serial(SerialDevice, 115200)
    while True:
        try:
            rx = sertty.readline().rstrip()
            parsed = parseTWELite(rx)
            if "from" in parsed:
                src = parsed["from"]
                raw = open(OutDir + "/_" + src, "w")
                raw.write(rx)
                raw.close()
                os.rename(OutDir + "/_" + src, OutDir + "/" + src)
                raw = open(OutDir + "/" + src + ".parsed", "w")
                raw.write(pprint.pformat(parsed))
                raw.close()
                expireOldFile()
        except Exception as e:
            logging.error('twe-monitor.py', exc_info=True)
    
    sertty.close()
