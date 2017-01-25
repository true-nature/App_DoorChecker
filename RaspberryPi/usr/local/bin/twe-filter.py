#!/usr/bin/env python2.7
# -*- mode:python; coding:utf-8 -*-

import time
import sys
from datetime import datetime,timedelta
import syslog
import os
import struct
import binascii
import glob
import pprint
from logging import getLogger,INFO,DEBUG,Formatter
from logging.handlers import SysLogHandler
from email.Header import decode_header
from email.Parser import Parser
import smtplib
import email
from email.mime.text import MIMEText

OutDir = "/var/run/twe"
RainMarker = OutDir + "/RainMarker"

handler = SysLogHandler(address = '/dev/log', facility=SysLogHandler.LOG_USER)
handler.setFormatter(Formatter("twe-filter[%(process)d]: %(message)s"))
handler.setLevel(INFO)
logger = getLogger("twe-filter")
logger.setLevel(DEBUG)
logger.addHandler(handler)

def decodeVolt(batt):
    volt = 0
    if batt <= 170:
        volt = 1950 + 5 * batt
    else:
        volt = 2800 + 10 * (batt - 170)
    return volt

def notifyStats(weather, voltage, results, toAddr):
    fromAddr="twe@localhost"
    if 'MAIL_FROM' in os.environ:
        fromAddr = os.environ['MAIL_FROM']
    closed = ",".join(sorted([chr(0x40 + v["id"]) for v in results if v["pkt"] == 254 and v["button"] == 1]))
    opened = ",".join(sorted([chr(0x40 + v["id"]) for v in results if v["pkt"] == 254 and v["button"] == 0]))
    text = "\n".join([weather, voltage, "", " Opened: " + opened, " Closed: " + closed])
    msg = MIMEText(text)
    msg['Subject'] = weather
    msg['From'] = fromAddr
    msg['To'] = toAddr
    recipients = toAddr.split(',')
    s = smtplib.SMTP()
    s.connect()
    s.sendmail(fromAddr, recipients, msg.as_string())
    s.close()

def collectDoorStatus():
    results = {}
    file_list = glob.glob(OutDir + "/8*")
    for f in file_list:
        if f.endswith(".parsed"):
            continue
        raw = open(f, "r")
        rx = raw.readline()
        parsed = parseTWELite(rx)
        if "from" in parsed:
            src = parsed["from"]
            results[src] = parsed
    return results

def checkRain(parsed, results, rcpt):
    adc2 = int(parsed["adc2"])
    volt = int(parsed["volt"])
    ratio = float(adc2) / volt
    subject = "The weather"
    weather = ""
    if ratio < 0.5:
        # It's rain
        weather = "It's rain."
    else:
        weather = "It's NOT rain."
    voltage = " adc2:{0:d}mV, volt:{1:d}mV".format(adc2, volt)
    notifyStats(weather, voltage, results, rcpt)

def reportStats(results, rcpt):
    for parsed in results:
        if parsed["pkt"] == 0x10:
            checkRain(parsed, results, rcpt)
            break
        

# Decode output of vSerOutput_Uart().
def parseTWELite(raw):
    if raw[0] != ":":
        return {}
    data = binascii.unhexlify(raw[1:])
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

def main():
    raw = sys.stdin.readlines()
    msg = email.message_from_string(''.join(raw))
    (name, fromAdddr) = email.utils.getaddresses(msg.get_all('From',''))[0]
    recipients="twe@localhost"
    if 'RCPT_TO' in os.environ:
        recipients = os.environ['RCPT_TO']
    if fromAdddr in recipients.split(','):
        ioResults = collectDoorStatus()
        reportStats(ioResults.values(), fromAdddr)
    else:
        logger.warn("Unknown recipeint %s.", fromAdddr)
    return
    
if __name__ == '__main__':
    if not os.path.exists(OutDir):
        sys.exit(0)
    try:
        main()
    except Exception as e:
        logger.error('twe-filter.py', exc_info=True)
