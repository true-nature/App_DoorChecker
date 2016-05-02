#!/usr/bin/env python2.7
# -*- mode:python; coding:utf-8 -*-

import time
from datetime import datetime,timedelta
import syslog
import os
import sys
import serial
from logging import getLogger,INFO,DEBUG,Formatter
from logging.handlers import SysLogHandler

SerialDevice = "/dev/ttyUSB0"
MAC_LIST_FILE_NAME = "/usr/local/etc/mac_addr_to_wake"
WAKEUP_INTERVAL_MIN = 5

handler = SysLogHandler(address = '/dev/log', facility=SysLogHandler.LOG_USER)
handler.setFormatter(Formatter("twe2525A-monitor[%(process)d]: %(message)s"))
handler.setLevel(INFO)
logger = getLogger("twe2525A-monitor")
logger.setLevel(DEBUG)
logger.addHandler(handler)

# 
def getMacAddrToWake():
    maclist = []
    if os.path.exists(MAC_LIST_FILE_NAME):
        with open(MAC_LIST_FILE_NAME) as f:
            for line in f:
                mac = line.strip()
                if mac.startswith("#"):
                    continue
                maclist.append(mac)
    return maclist

def TriggerWakeOnLan(macListToWake):
    for mac in macListToWake:
##   Send WakeOnLan packet to a server.
        logger.info("Wake Up " + mac)
        os.system("/usr/bin/wakeonlan " + mac)

if __name__ == '__main__':
    logger.info("Started")
    servers = getMacAddrToWake()
    if len(servers) == 0:
        logger.error("MAC list to wakeup is empty.")
        sys.exit(1)
    if not os.path.exists(SerialDevice):
        logger.error("The TWE-Lite parent device isn't connected.")
        sys.exit(1)
    sertty = serial.Serial(port=SerialDevice, baudrate=115200, timeout=60)
    # initialize last wakeup time
    lastWakeUpTime = datetime.now() - timedelta(seconds=WAKEUP_INTERVAL_MIN)
    while True:
        try:
            rx = sertty.readline().rstrip()
            if rx.startswith("::rc="):
                currentTime = datetime.now()
                if timedelta(seconds=WAKEUP_INTERVAL_MIN) < (currentTime - lastWakeUpTime):
                    lastWakeUpTime = currentTime
                    TriggerWakeOnLan(servers)
        except Exception as e:
            logger.error("twe2525A-monitor.py", exc_info=True)
    
    sertty.close()
