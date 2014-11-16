#!/usr/bin/env python2.7
# -*- mode:python; coding:utf-8 -*-

import time
from datetime import datetime,timedelta
import syslog
import sys
import os
import serial
import struct
import binascii
import glob
import platform
import argparse

def decodeVolt(batt):
    volt = 0
    if batt <= 170:
        volt = 1950 + 5 * batt
    else:
        volt = 2800 + 10 * (batt - 170)
    return volt

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

def showParsm(filename, param):
    f = open(filename, "r")
    rx = f.readline()
    f.close()
    parsed = parseTWELite(rx)
    if param in parsed:
        print(parsed[param])
    else:
        print ('-2')

if __name__ == '__main__':
    parser = argparse.ArgumentParser(description="Show some values collected by TWE-Lite.")
    parser.add_argument('-d', '--directory', nargs='?', default='/var/run/twe', help='Directory of stattus cache.')
    parser.add_argument('params', nargs=2)
    args = parser.parse_args()
    for p in args.params:
        if ':' in p:
            (name, param) = p.split(':', 2)
            filename = args.directory + os.sep + name
            if os.path.exists(filename):
                showParsm(filename, param)
            else:
                print ('-1')
        else:
            print ('-0')

    print("\n" + platform.system())
    sys.exit(0)
