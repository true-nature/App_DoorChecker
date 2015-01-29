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
LIBS:Input-cache
EELAYER 27 0
EELAYER END
$Descr A4 11693 8268
encoding utf-8
Sheet 1 1
Title "DoorChecker EndPoint_Input"
Date "29 jan 2015"
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
P 6450 5600
F 0 "REED1" H 6450 5700 70  0000 C CNN
F 1 "SPST" H 6450 5500 70  0000 C CNN
F 2 "~" H 6450 5600 60  0000 C CNN
F 3 "~" H 6450 5600 60  0000 C CNN
	1    6450 5600
	1    0    0    -1  
$EndComp
$Comp
L R R1
U 1 1 54360F12
P 5250 4650
F 0 "R1" V 5330 4650 40  0000 C CNN
F 1 "2M" V 5257 4651 40  0000 C CNN
F 2 "~" V 5180 4650 30  0000 C CNN
F 3 "~" H 5250 4650 30  0000 C CNN
	1    5250 4650
	0    1    1    0   
$EndComp
$Comp
L LITE_LITE U1
U 2 1 5436A16D
P 5800 3250
F 0 "U1" H 5800 3250 60  0001 C CNN
F 1 "TWE-Lite_SMD" H 5800 3250 60  0001 C CNN
F 2 "" H 5800 3250 60  0000 C CNN
F 3 "" H 5800 3250 60  0000 C CNN
	2    5800 3250
	1    0    0    -1  
$EndComp
NoConn ~ 5500 2150
NoConn ~ 5600 2150
NoConn ~ 5700 2150
NoConn ~ 5800 2150
NoConn ~ 6100 2150
NoConn ~ 6200 2150
NoConn ~ 6900 2850
NoConn ~ 6900 2950
NoConn ~ 6900 3050
NoConn ~ 6900 3350
NoConn ~ 6900 3450
NoConn ~ 4800 2850
NoConn ~ 4800 3050
NoConn ~ 4800 3150
NoConn ~ 4800 3350
NoConn ~ 4800 3450
NoConn ~ 5600 4250
NoConn ~ 5700 4250
NoConn ~ 5800 4250
NoConn ~ 6100 4250
NoConn ~ 6200 4250
NoConn ~ 6900 3550
$Comp
L VCC #PWR01
U 1 1 543B58B9
P 3400 1400
F 0 "#PWR01" H 3400 1500 30  0001 C CNN
F 1 "VCC" H 3400 1500 30  0000 C CNN
F 2 "" H 3400 1400 60  0000 C CNN
F 3 "" H 3400 1400 60  0000 C CNN
	1    3400 1400
	1    0    0    -1  
$EndComp
$Comp
L GND #PWR02
U 1 1 543B58C8
P 2800 2850
F 0 "#PWR02" H 2800 2850 30  0001 C CNN
F 1 "GND" H 2800 2780 30  0001 C CNN
F 2 "" H 2800 2850 60  0000 C CNN
F 3 "" H 2800 2850 60  0000 C CNN
	1    2800 2850
	1    0    0    -1  
$EndComp
$Comp
L VCC #PWR03
U 1 1 543B59FC
P 4650 1000
F 0 "#PWR03" H 4650 1100 30  0001 C CNN
F 1 "VCC" H 4650 1100 30  0000 C CNN
F 2 "" H 4650 1000 60  0000 C CNN
F 3 "" H 4650 1000 60  0000 C CNN
	1    4650 1000
	1    0    0    -1  
$EndComp
NoConn ~ 6000 4250
$Comp
L GND #PWR04
U 1 1 543B5A81
P 7000 6400
F 0 "#PWR04" H 7000 6400 30  0001 C CNN
F 1 "GND" H 7000 6330 30  0001 C CNN
F 2 "" H 7000 6400 60  0000 C CNN
F 3 "" H 7000 6400 60  0000 C CNN
	1    7000 6400
	1    0    0    -1  
$EndComp
$Comp
L BATTERY BT1
U 1 1 543B60F0
P 2800 2250
F 0 "BT1" H 2800 2450 50  0000 C CNN
F 1 "CR2032" H 2800 2060 50  0000 C CNN
F 2 "~" H 2800 2250 60  0000 C CNN
F 3 "~" H 2800 2250 60  0000 C CNN
	1    2800 2250
	0    1    1    0   
$EndComp
Wire Wire Line
	4650 1000 4650 4650
Wire Wire Line
	4650 4650 5000 4650
Wire Wire Line
	6900 3150 7100 3150
Wire Wire Line
	7100 3150 7100 5050
Wire Wire Line
	7100 5050 7700 5050
Wire Wire Line
	6900 3250 7000 3250
Wire Wire Line
	7000 3250 7000 6400
Wire Wire Line
	7000 5450 7700 5450
Wire Wire Line
	5500 4350 5500 4250
Wire Wire Line
	4800 3550 4450 3550
Wire Wire Line
	4450 3550 4450 5350
Wire Wire Line
	4450 5350 7700 5350
Wire Wire Line
	4800 2950 4250 2950
Wire Wire Line
	4250 2950 4250 5250
Wire Wire Line
	4250 5250 7700 5250
Wire Wire Line
	4650 3250 4800 3250
Connection ~ 4650 3250
Wire Wire Line
	6800 5150 7700 5150
Wire Wire Line
	5500 4350 6800 4350
Wire Wire Line
	6800 4350 6800 5150
Wire Wire Line
	3400 1400 3400 2050
Wire Wire Line
	2800 2550 2800 2850
Wire Wire Line
	5900 4250 5900 5600
Wire Wire Line
	5500 4650 5900 4650
Connection ~ 7000 5450
$Comp
L PWR_FLAG #FLG05
U 1 1 54869ED2
P 2550 2700
F 0 "#FLG05" H 2550 2795 30  0001 C CNN
F 1 "PWR_FLAG" H 2550 2880 30  0000 C CNN
F 2 "" H 2550 2700 60  0000 C CNN
F 3 "" H 2550 2700 60  0000 C CNN
	1    2550 2700
	1    0    0    -1  
$EndComp
Wire Wire Line
	2550 2750 2800 2750
Connection ~ 2800 2750
$Comp
L PWR_FLAG #FLG06
U 1 1 5486A030
P 3650 1500
F 0 "#FLG06" H 3650 1595 30  0001 C CNN
F 1 "PWR_FLAG" H 3650 1680 30  0000 C CNN
F 2 "" H 3650 1500 60  0000 C CNN
F 3 "" H 3650 1500 60  0000 C CNN
	1    3650 1500
	1    0    0    -1  
$EndComp
Wire Wire Line
	3650 1500 3400 1500
Wire Wire Line
	3400 2550 3400 2450
Wire Wire Line
	2800 2550 3400 2550
Wire Wire Line
	6000 2150 6000 1850
Wire Wire Line
	6000 1850 7200 1850
Wire Wire Line
	7200 1850 7200 5550
Wire Wire Line
	7200 5550 7700 5550
Wire Wire Line
	7700 4950 7300 4950
Wire Wire Line
	7300 4950 7300 1750
Wire Wire Line
	7300 1750 4650 1750
Connection ~ 4650 1750
Text Label 7450 4950 0    60   ~ 0
Vcc
Text Label 7450 5550 0    60   ~ 0
CFG
Text Label 7450 5050 0    60   ~ 0
RST
Text Label 7450 5150 0    60   ~ 0
RXD
Text Label 7450 5250 0    60   ~ 0
PRG
Text Label 7450 5350 0    60   ~ 0
TXD
Text Label 7450 5450 0    60   ~ 0
GND
Text Label 5800 4650 0    60   ~ 0
DOOR
Wire Wire Line
	2800 1750 2800 1950
Connection ~ 3400 1500
Wire Wire Line
	3350 1750 3400 1750
Connection ~ 3400 1750
Wire Wire Line
	2800 1750 2850 1750
Text Label 2800 1850 1    60   ~ 0
DC3V
$Comp
L R R2
U 1 1 54BCF561
P 3100 1750
F 0 "R2" V 3180 1750 40  0000 C CNN
F 1 "75" V 3107 1751 40  0000 C CNN
F 2 "~" V 3030 1750 30  0000 C CNN
F 3 "~" H 3100 1750 30  0000 C CNN
	1    3100 1750
	0    -1   -1   0   
$EndComp
$Comp
L CP1 C1
U 1 1 54BDE16D
P 3400 2250
F 0 "C1" H 3450 2350 50  0000 L CNN
F 1 "0.22" H 3450 2150 50  0000 L CNN
F 2 "~" H 3400 2250 60  0000 C CNN
F 3 "~" H 3400 2250 60  0000 C CNN
	1    3400 2250
	1    0    0    -1  
$EndComp
Wire Wire Line
	6950 5600 7000 5600
Connection ~ 7000 5600
Wire Wire Line
	5900 5600 5950 5600
Connection ~ 5900 4650
NoConn ~ 5900 2150
$Comp
L WRITER-VCC P1
U 1 1 54C9BECD
P 8100 5250
F 0 "P1" V 8200 5250 60  0000 C CNN
F 1 "WRITER-VCC" V 8300 5250 60  0000 C CNN
F 2 "~" H 8050 5200 60  0000 C CNN
F 3 "~" H 8050 5200 60  0000 C CNN
	1    8100 5250
	1    0    0    -1  
$EndComp
Wire Wire Line
	2550 2700 2550 2750
$EndSCHEMATC
