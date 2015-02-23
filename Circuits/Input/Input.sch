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
Date "23 feb 2015"
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
P 4100 5250
F 0 "REED1" H 4100 5350 70  0000 C CNN
F 1 "SPST" H 4100 5150 70  0000 C CNN
F 2 "~" H 4100 5250 60  0000 C CNN
F 3 "~" H 4100 5250 60  0000 C CNN
	1    4100 5250
	0    -1   -1   0   
$EndComp
$Comp
L R R1
U 1 1 54360F12
P 4100 4000
F 0 "R1" V 4180 4000 40  0000 C CNN
F 1 "2M" V 4107 4001 40  0000 C CNN
F 2 "~" V 4030 4000 30  0000 C CNN
F 3 "~" H 4100 4000 30  0000 C CNN
	1    4100 4000
	1    0    0    -1  
$EndComp
$Comp
L VCC #PWR01
U 1 1 543B58B9
P 2200 1400
F 0 "#PWR01" H 2200 1500 30  0001 C CNN
F 1 "VCC" H 2200 1500 30  0000 C CNN
F 2 "" H 2200 1400 60  0000 C CNN
F 3 "" H 2200 1400 60  0000 C CNN
	1    2200 1400
	1    0    0    -1  
$EndComp
$Comp
L GND #PWR02
U 1 1 543B58C8
P 1600 2850
F 0 "#PWR02" H 1600 2850 30  0001 C CNN
F 1 "GND" H 1600 2780 30  0001 C CNN
F 2 "" H 1600 2850 60  0000 C CNN
F 3 "" H 1600 2850 60  0000 C CNN
	1    1600 2850
	1    0    0    -1  
$EndComp
$Comp
L VCC #PWR03
U 1 1 543B59FC
P 4400 1000
F 0 "#PWR03" H 4400 1100 30  0001 C CNN
F 1 "VCC" H 4400 1100 30  0000 C CNN
F 2 "" H 4400 1000 60  0000 C CNN
F 3 "" H 4400 1000 60  0000 C CNN
	1    4400 1000
	1    0    0    -1  
$EndComp
$Comp
L GND #PWR04
U 1 1 543B5A81
P 4100 6200
F 0 "#PWR04" H 4100 6200 30  0001 C CNN
F 1 "GND" H 4100 6130 30  0001 C CNN
F 2 "" H 4100 6200 60  0000 C CNN
F 3 "" H 4100 6200 60  0000 C CNN
	1    4100 6200
	1    0    0    -1  
$EndComp
$Comp
L BATTERY BT1
U 1 1 543B60F0
P 1600 2250
F 0 "BT1" H 1600 2450 50  0000 C CNN
F 1 "CR2032" H 1600 2060 50  0000 C CNN
F 2 "~" H 1600 2250 60  0000 C CNN
F 3 "~" H 1600 2250 60  0000 C CNN
	1    1600 2250
	0    1    1    0   
$EndComp
Wire Wire Line
	4400 1000 4400 3250
Wire Wire Line
	4900 5050 7700 5050
Wire Wire Line
	6600 5450 7700 5450
Wire Wire Line
	4700 5350 7700 5350
Wire Wire Line
	6700 5250 7700 5250
Wire Wire Line
	4800 5150 7700 5150
Wire Wire Line
	2200 1400 2200 2050
Wire Wire Line
	1600 2550 1600 2850
$Comp
L PWR_FLAG #FLG05
U 1 1 54869ED2
P 1350 2700
F 0 "#FLG05" H 1350 2795 30  0001 C CNN
F 1 "PWR_FLAG" H 1350 2880 30  0000 C CNN
F 2 "" H 1350 2700 60  0000 C CNN
F 3 "" H 1350 2700 60  0000 C CNN
	1    1350 2700
	1    0    0    -1  
$EndComp
Wire Wire Line
	1350 2750 1600 2750
Connection ~ 1600 2750
$Comp
L PWR_FLAG #FLG06
U 1 1 5486A030
P 2450 1500
F 0 "#FLG06" H 2450 1595 30  0001 C CNN
F 1 "PWR_FLAG" H 2450 1680 30  0000 C CNN
F 2 "" H 2450 1500 60  0000 C CNN
F 3 "" H 2450 1500 60  0000 C CNN
	1    2450 1500
	1    0    0    -1  
$EndComp
Wire Wire Line
	2450 1500 2200 1500
Wire Wire Line
	2200 2550 2200 2450
Wire Wire Line
	1600 2550 3400 2550
Wire Wire Line
	4600 5550 7700 5550
Wire Wire Line
	7700 4950 7300 4950
Wire Wire Line
	7300 4950 7300 1750
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
Text Label 4100 4550 1    60   ~ 0
DOOR
Wire Wire Line
	1600 1750 1600 1950
Connection ~ 2200 1500
Wire Wire Line
	2150 1750 3400 1750
Connection ~ 2200 1750
Wire Wire Line
	1600 1750 1650 1750
Text Label 1600 1850 1    60   ~ 0
DC3V
$Comp
L R R2
U 1 1 54BCF561
P 1900 1750
F 0 "R2" V 1980 1750 40  0000 C CNN
F 1 "75" V 1907 1751 40  0000 C CNN
F 2 "~" V 1830 1750 30  0000 C CNN
F 3 "~" H 1900 1750 30  0000 C CNN
	1    1900 1750
	0    -1   -1   0   
$EndComp
$Comp
L CP1 C1
U 1 1 54BDE16D
P 2200 2250
F 0 "C1" H 2250 2350 50  0000 L CNN
F 1 "100u" H 2250 2150 50  0000 L CNN
F 2 "~" H 2200 2250 60  0000 C CNN
F 3 "~" H 2200 2250 60  0000 C CNN
	1    2200 2250
	1    0    0    -1  
$EndComp
Wire Wire Line
	4100 6200 4100 5750
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
	1350 2700 1350 2750
$Comp
L CP1 C2
U 1 1 54EAB9CB
P 2500 2250
F 0 "C2" H 2550 2350 50  0000 L CNN
F 1 "100u" H 2550 2150 50  0000 L CNN
F 2 "~" H 2500 2250 60  0000 C CNN
F 3 "~" H 2500 2250 60  0000 C CNN
	1    2500 2250
	1    0    0    -1  
$EndComp
$Comp
L CP1 C3
U 1 1 54EAB9D1
P 2800 2250
F 0 "C3" H 2850 2350 50  0000 L CNN
F 1 "100u" H 2850 2150 50  0000 L CNN
F 2 "~" H 2800 2250 60  0000 C CNN
F 3 "~" H 2800 2250 60  0000 C CNN
	1    2800 2250
	1    0    0    -1  
$EndComp
$Comp
L CP1 C4
U 1 1 54EAB9D7
P 3100 2250
F 0 "C4" H 3150 2350 50  0000 L CNN
F 1 "100u" H 3150 2150 50  0000 L CNN
F 2 "~" H 3100 2250 60  0000 C CNN
F 3 "~" H 3100 2250 60  0000 C CNN
	1    3100 2250
	1    0    0    -1  
$EndComp
$Comp
L CP1 C5
U 1 1 54EAB9DD
P 3400 2250
F 0 "C5" H 3450 2350 50  0000 L CNN
F 1 "100u" H 3450 2150 50  0000 L CNN
F 2 "~" H 3400 2250 60  0000 C CNN
F 3 "~" H 3400 2250 60  0000 C CNN
	1    3400 2250
	1    0    0    -1  
$EndComp
Wire Wire Line
	3400 1750 3400 2050
Wire Wire Line
	3400 2550 3400 2450
Connection ~ 2200 2550
Wire Wire Line
	2500 2450 2500 2550
Connection ~ 2500 2550
Wire Wire Line
	2800 2450 2800 2550
Connection ~ 2800 2550
Wire Wire Line
	3100 2450 3100 2550
Connection ~ 3100 2550
Wire Wire Line
	3100 2050 3100 1750
Connection ~ 3100 1750
Wire Wire Line
	2800 2050 2800 1750
Connection ~ 2800 1750
Wire Wire Line
	2500 1750 2500 2050
Connection ~ 2500 1750
$Comp
L TWE_LITE_SMD U1
U 1 1 54EABB18
P 5800 2750
F 0 "U1" H 5800 2650 50  0000 C CNN
F 1 "TWE_LITE_SMD" H 5800 3550 50  0000 C CNN
F 2 "MODULE" H 5550 1500 50  0001 C CNN
F 3 "DOCUMENTATION" H 6150 1500 50  0001 C CNN
	1    5800 2750
	1    0    0    -1  
$EndComp
Wire Wire Line
	7300 1750 4400 1750
Wire Wire Line
	6550 2100 6600 2100
Wire Wire Line
	6600 2100 6600 1750
Connection ~ 6600 1750
Wire Wire Line
	5050 2700 4900 2700
Wire Wire Line
	4900 2700 4900 5050
Wire Wire Line
	5050 2450 4800 2450
Wire Wire Line
	4800 2450 4800 5150
Wire Wire Line
	5050 2550 4700 2550
Wire Wire Line
	4700 2550 4700 5350
Wire Wire Line
	6550 3150 6700 3150
Wire Wire Line
	6550 3400 6600 3400
Wire Wire Line
	6600 3400 6600 5450
Wire Wire Line
	6600 3500 6550 3500
Connection ~ 6600 3500
Wire Wire Line
	6550 3600 6600 3600
Connection ~ 6600 3600
Wire Wire Line
	6550 3700 6600 3700
Connection ~ 6600 3700
Wire Wire Line
	6550 3800 6600 3800
Connection ~ 6600 3800
Wire Wire Line
	6700 3150 6700 5250
Wire Wire Line
	5050 2300 4600 2300
Wire Wire Line
	4600 2300 4600 5550
Wire Wire Line
	4100 4750 4100 4250
Wire Wire Line
	4100 3750 4100 3400
Wire Wire Line
	4100 3400 5050 3400
NoConn ~ 5050 2100
NoConn ~ 5050 2200
NoConn ~ 5050 2800
Wire Wire Line
	4400 3250 5050 3250
Connection ~ 4400 1750
Wire Wire Line
	5050 2950 4400 2950
Connection ~ 4400 2950
Wire Wire Line
	5050 3050 4400 3050
Connection ~ 4400 3050
Wire Wire Line
	5050 3150 4400 3150
Connection ~ 4400 3150
NoConn ~ 5050 3500
NoConn ~ 5050 3600
NoConn ~ 5050 3700
NoConn ~ 6550 3250
NoConn ~ 6550 3050
NoConn ~ 6550 2950
NoConn ~ 6550 2800
NoConn ~ 6550 2700
NoConn ~ 6550 2600
NoConn ~ 6550 2500
NoConn ~ 6550 2350
NoConn ~ 6550 2250
Text Label 4200 3400 0    60   ~ 0
DI1
$EndSCHEMATC
