EESchema Schematic File Version 2
LIBS:TWE-Lite
LIBS:power
LIBS:device
LIBS:transistors
LIBS:conn
LIBS:linear
LIBS:regul
LIBS:74xx
LIBS:cmos4000
LIBS:adc-dac
LIBS:memory
LIBS:xilinx
LIBS:special
LIBS:microcontrollers
LIBS:dsp
LIBS:microchip
LIBS:analog_switches
LIBS:motorola
LIBS:texas
LIBS:intel
LIBS:audio
LIBS:interface
LIBS:digital-audio
LIBS:philips
LIBS:display
LIBS:cypress
LIBS:siliconi
LIBS:opto
LIBS:atmel
LIBS:contrib
LIBS:valves
LIBS:relays
EELAYER 27 0
EELAYER END
$Descr A4 11693 8268
encoding utf-8
Sheet 1 1
Title "DoorChecker EndPoint_Input"
Date "21 jan 2015"
Rev ""
Comp "true-nature"
Comment1 ""
Comment2 ""
Comment3 ""
Comment4 ""
$EndDescr
$Comp
L SPST REED1
U 1 1 54360F03
P 6450 5950
F 0 "REED1" H 6450 6050 70  0000 C CNN
F 1 "SPST" H 6450 5850 70  0000 C CNN
F 2 "~" H 6450 5950 60  0000 C CNN
F 3 "~" H 6450 5950 60  0000 C CNN
	1    6450 5950
	1    0    0    -1  
$EndComp
$Comp
L R R1
U 1 1 54360F12
P 5250 5000
F 0 "R1" V 5330 5000 40  0000 C CNN
F 1 "2M" V 5257 5001 40  0000 C CNN
F 2 "~" V 5180 5000 30  0000 C CNN
F 3 "~" H 5250 5000 30  0000 C CNN
	1    5250 5000
	0    1    1    0   
$EndComp
$Comp
L LITE_LITE U1
U 2 1 5436A16D
P 5800 3600
F 0 "U1" H 5800 3600 60  0001 C CNN
F 1 "TWE-Lite_SMD" H 5800 3600 60  0001 C CNN
F 2 "" H 5800 3600 60  0000 C CNN
F 3 "" H 5800 3600 60  0000 C CNN
	2    5800 3600
	1    0    0    -1  
$EndComp
NoConn ~ 5500 2500
NoConn ~ 5600 2500
NoConn ~ 5700 2500
NoConn ~ 5800 2500
NoConn ~ 6100 2500
NoConn ~ 6200 2500
NoConn ~ 6900 3200
NoConn ~ 6900 3300
NoConn ~ 6900 3400
NoConn ~ 6900 3700
NoConn ~ 6900 3800
NoConn ~ 4800 3200
NoConn ~ 4800 3400
NoConn ~ 4800 3500
NoConn ~ 4800 3700
NoConn ~ 4800 3800
NoConn ~ 5600 4600
NoConn ~ 5700 4600
NoConn ~ 5800 4600
NoConn ~ 6100 4600
NoConn ~ 6200 4600
NoConn ~ 6900 3900
$Comp
L VCC #PWR01
U 1 1 543B58B9
P 3400 1750
F 0 "#PWR01" H 3400 1850 30  0001 C CNN
F 1 "VCC" H 3400 1850 30  0000 C CNN
F 2 "" H 3400 1750 60  0000 C CNN
F 3 "" H 3400 1750 60  0000 C CNN
	1    3400 1750
	1    0    0    -1  
$EndComp
$Comp
L GND #PWR02
U 1 1 543B58C8
P 2800 3200
F 0 "#PWR02" H 2800 3200 30  0001 C CNN
F 1 "GND" H 2800 3130 30  0001 C CNN
F 2 "" H 2800 3200 60  0000 C CNN
F 3 "" H 2800 3200 60  0000 C CNN
	1    2800 3200
	1    0    0    -1  
$EndComp
$Comp
L VCC #PWR03
U 1 1 543B59FC
P 4650 1350
F 0 "#PWR03" H 4650 1450 30  0001 C CNN
F 1 "VCC" H 4650 1450 30  0000 C CNN
F 2 "" H 4650 1350 60  0000 C CNN
F 3 "" H 4650 1350 60  0000 C CNN
	1    4650 1350
	1    0    0    -1  
$EndComp
NoConn ~ 6000 4600
$Comp
L GND #PWR04
U 1 1 543B5A81
P 7000 6200
F 0 "#PWR04" H 7000 6200 30  0001 C CNN
F 1 "GND" H 7000 6130 30  0001 C CNN
F 2 "" H 7000 6200 60  0000 C CNN
F 3 "" H 7000 6200 60  0000 C CNN
	1    7000 6200
	1    0    0    -1  
$EndComp
$Comp
L BATTERY BT1
U 1 1 543B60F0
P 2800 2600
F 0 "BT1" H 2800 2800 50  0000 C CNN
F 1 "CR2032" H 2800 2410 50  0000 C CNN
F 2 "~" H 2800 2600 60  0000 C CNN
F 3 "~" H 2800 2600 60  0000 C CNN
	1    2800 2600
	0    1    1    0   
$EndComp
Wire Wire Line
	4650 1350 4650 5000
Wire Wire Line
	4650 5000 5000 5000
Wire Wire Line
	6900 3500 7100 3500
Wire Wire Line
	7100 3500 7100 5400
Wire Wire Line
	7100 5400 7700 5400
Wire Wire Line
	6900 3600 7000 3600
Wire Wire Line
	7000 3600 7000 6200
Wire Wire Line
	7000 5800 7700 5800
Wire Wire Line
	5500 4700 5500 4600
Wire Wire Line
	4800 3900 4450 3900
Wire Wire Line
	4450 3900 4450 5700
Wire Wire Line
	4450 5700 7700 5700
Wire Wire Line
	4800 3300 4250 3300
Wire Wire Line
	4250 3300 4250 5600
Wire Wire Line
	4250 5600 7700 5600
Wire Wire Line
	4650 3600 4800 3600
Connection ~ 4650 3600
Wire Wire Line
	6800 5500 7700 5500
Wire Wire Line
	5500 4700 6800 4700
Wire Wire Line
	6800 4700 6800 5500
Wire Wire Line
	3400 1750 3400 2400
Wire Wire Line
	2800 2900 2800 3200
Wire Wire Line
	5900 4600 5900 5950
Wire Wire Line
	5500 5000 5900 5000
Connection ~ 7000 5800
$Comp
L PWR_FLAG #FLG05
U 1 1 54869ED2
P 3000 3100
F 0 "#FLG05" H 3000 3195 30  0001 C CNN
F 1 "PWR_FLAG" H 3000 3280 30  0000 C CNN
F 2 "" H 3000 3100 60  0000 C CNN
F 3 "" H 3000 3100 60  0000 C CNN
	1    3000 3100
	1    0    0    -1  
$EndComp
Wire Wire Line
	3000 3100 2800 3100
Connection ~ 2800 3100
$Comp
L PWR_FLAG #FLG06
U 1 1 5486A030
P 3650 1850
F 0 "#FLG06" H 3650 1945 30  0001 C CNN
F 1 "PWR_FLAG" H 3650 2030 30  0000 C CNN
F 2 "" H 3650 1850 60  0000 C CNN
F 3 "" H 3650 1850 60  0000 C CNN
	1    3650 1850
	1    0    0    -1  
$EndComp
Wire Wire Line
	3650 1850 3400 1850
Wire Wire Line
	3400 2900 3400 2800
Wire Wire Line
	2800 2900 3400 2900
$Comp
L CONN_7 CN1
U 1 1 5486A17C
P 8050 5600
F 0 "CN1" V 8020 5600 60  0000 C CNN
F 1 "WRITER" V 8120 5600 60  0000 C CNN
F 2 "~" H 8050 5600 60  0000 C CNN
F 3 "~" H 8050 5600 60  0000 C CNN
	1    8050 5600
	1    0    0    -1  
$EndComp
Wire Wire Line
	6000 2500 6000 2200
Wire Wire Line
	6000 2200 7200 2200
Wire Wire Line
	7200 2200 7200 5900
Wire Wire Line
	7200 5900 7700 5900
Wire Wire Line
	7700 5300 7300 5300
Wire Wire Line
	7300 5300 7300 2100
Wire Wire Line
	7300 2100 4650 2100
Connection ~ 4650 2100
Text Label 7450 5300 0    60   ~ 0
Vcc
Text Label 7450 5900 0    60   ~ 0
CFG
Text Label 7450 5400 0    60   ~ 0
RST
Text Label 7450 5500 0    60   ~ 0
RX
Text Label 7450 5600 0    60   ~ 0
PRG
Text Label 7450 5700 0    60   ~ 0
TX
Text Label 7450 5800 0    60   ~ 0
GND
Text Label 5800 5000 0    60   ~ 0
DOOR
Wire Wire Line
	2800 2100 2800 2300
Connection ~ 3400 1850
Wire Wire Line
	3350 2100 3400 2100
Connection ~ 3400 2100
Wire Wire Line
	2800 2100 2850 2100
Text Label 2800 2200 1    60   ~ 0
DC3V
$Comp
L R R2
U 1 1 54BCF561
P 3100 2100
F 0 "R2" V 3180 2100 40  0000 C CNN
F 1 "75" V 3107 2101 40  0000 C CNN
F 2 "~" V 3030 2100 30  0000 C CNN
F 3 "~" H 3100 2100 30  0000 C CNN
	1    3100 2100
	0    -1   -1   0   
$EndComp
$Comp
L CP1 C1
U 1 1 54BDE16D
P 3400 2600
F 0 "C1" H 3450 2700 50  0000 L CNN
F 1 "0.22" H 3450 2500 50  0000 L CNN
F 2 "~" H 3400 2600 60  0000 C CNN
F 3 "~" H 3400 2600 60  0000 C CNN
	1    3400 2600
	1    0    0    -1  
$EndComp
Wire Wire Line
	6950 5950 7000 5950
Connection ~ 7000 5950
Wire Wire Line
	5900 5950 5950 5950
Connection ~ 5900 5000
NoConn ~ 5900 2500
$EndSCHEMATC
