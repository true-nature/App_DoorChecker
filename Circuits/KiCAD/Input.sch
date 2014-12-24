EESchema Schematic File Version 2
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
LIBS:TWELite
LIBS:Input-cache
EELAYER 27 0
EELAYER END
$Descr A4 11693 8268
encoding utf-8
Sheet 1 1
Title "DoorChecker EndPoint_Input"
Date "24 dec 2014"
Rev ""
Comp "true-nature"
Comment1 ""
Comment2 ""
Comment3 ""
Comment4 ""
$EndDescr
$Comp
L C C1
U 1 1 54360EC8
P 3350 2600
F 0 "C1" H 3350 2700 40  0000 L CNN
F 1 "0.22" H 3356 2515 40  0000 L CNN
F 2 "~" H 3388 2450 30  0000 C CNN
F 3 "~" H 3350 2600 60  0000 C CNN
	1    3350 2600
	-1   0    0    1   
$EndComp
$Comp
L SPST REED1
U 1 1 54360F03
P 5250 5000
F 0 "REED1" H 5250 5100 70  0000 C CNN
F 1 "SPST" H 5250 4900 70  0000 C CNN
F 2 "~" H 5250 5000 60  0000 C CNN
F 3 "~" H 5250 5000 60  0000 C CNN
	1    5250 5000
	1    0    0    -1  
$EndComp
$Comp
L R R1
U 1 1 54360F12
P 4650 4350
F 0 "R1" V 4730 4350 40  0000 C CNN
F 1 "2M" V 4657 4351 40  0000 C CNN
F 2 "~" V 4580 4350 30  0000 C CNN
F 3 "~" H 4650 4350 30  0000 C CNN
	1    4650 4350
	-1   0    0    1   
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
P 2800 2000
F 0 "#PWR01" H 2800 2100 30  0001 C CNN
F 1 "VCC" H 2800 2100 30  0000 C CNN
F 2 "" H 2800 2000 60  0000 C CNN
F 3 "" H 2800 2000 60  0000 C CNN
	1    2800 2000
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
P 7000 6050
F 0 "#PWR04" H 7000 6050 30  0001 C CNN
F 1 "GND" H 7000 5980 30  0001 C CNN
F 2 "" H 7000 6050 60  0000 C CNN
F 3 "" H 7000 6050 60  0000 C CNN
	1    7000 6050
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
	4650 4600 4650 5000
Wire Wire Line
	4650 5000 4750 5000
Wire Wire Line
	6900 3500 7100 3500
Wire Wire Line
	7100 3500 7100 5400
Wire Wire Line
	7100 5400 7350 5400
Wire Wire Line
	6900 3600 7000 3600
Wire Wire Line
	7000 2350 7000 6050
Wire Wire Line
	7000 5800 7350 5800
Wire Wire Line
	5500 4700 5500 4600
Wire Wire Line
	4800 3900 4450 3900
Wire Wire Line
	4450 3900 4450 5700
Wire Wire Line
	4450 5700 7350 5700
Wire Wire Line
	4800 3300 4250 3300
Wire Wire Line
	4250 3300 4250 5600
Wire Wire Line
	4250 5600 7350 5600
Wire Wire Line
	4650 3600 4800 3600
Wire Wire Line
	4650 1350 4650 4100
Connection ~ 4650 3600
Wire Wire Line
	6800 5500 7350 5500
Wire Wire Line
	5500 4700 6800 4700
Wire Wire Line
	6800 4700 6800 5500
Wire Wire Line
	2800 2000 2800 2300
Wire Wire Line
	2800 2900 2800 3200
Wire Wire Line
	5900 4600 5900 5000
Wire Wire Line
	5900 5000 5750 5000
Connection ~ 7000 5800
Wire Wire Line
	7000 2350 5900 2350
Connection ~ 7000 3600
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
P 3050 2100
F 0 "#FLG06" H 3050 2195 30  0001 C CNN
F 1 "PWR_FLAG" H 3050 2280 30  0000 C CNN
F 2 "" H 3050 2100 60  0000 C CNN
F 3 "" H 3050 2100 60  0000 C CNN
	1    3050 2100
	1    0    0    -1  
$EndComp
Wire Wire Line
	3050 2100 2800 2100
Connection ~ 2800 2100
Wire Wire Line
	3350 2400 3350 2250
Wire Wire Line
	3350 2250 2800 2250
Connection ~ 2800 2250
Wire Wire Line
	3350 2800 3350 2900
Wire Wire Line
	3350 2900 2800 2900
$Comp
L CONN_7 WRITER1
U 1 1 5486A17C
P 7700 5600
F 0 "WRITER1" V 7670 5600 60  0000 C CNN
F 1 "CONN_7" V 7770 5600 60  0000 C CNN
F 2 "~" H 7700 5600 60  0000 C CNN
F 3 "~" H 7700 5600 60  0000 C CNN
	1    7700 5600
	1    0    0    -1  
$EndComp
Wire Wire Line
	5900 2350 5900 2500
Wire Wire Line
	6000 2500 6000 2200
Wire Wire Line
	6000 2200 7200 2200
Wire Wire Line
	7200 2200 7200 5900
Wire Wire Line
	7200 5900 7350 5900
Wire Wire Line
	7350 5300 7300 5300
Wire Wire Line
	7300 5300 7300 2100
Wire Wire Line
	7300 2100 4650 2100
Connection ~ 4650 2100
Text Label 7300 5300 0    60   ~ 0
Vcc
Text Notes 6100 2200 0    60   ~ 0
CFG
Text Notes 4650 1850 0    60   ~ 0
Vcc
$EndSCHEMATC
