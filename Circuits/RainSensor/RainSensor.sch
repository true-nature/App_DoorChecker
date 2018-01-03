EESchema Schematic File Version 2
LIBS:power
LIBS:device
LIBS:switches
LIBS:relays
LIBS:motors
LIBS:transistors
LIBS:conn
LIBS:linear
LIBS:regul
LIBS:74xx
LIBS:cmos4000
LIBS:adc-dac
LIBS:memory
LIBS:xilinx
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
LIBS:TWE-Lite
LIBS:favorites
LIBS:Input-cache
EELAYER 25 0
EELAYER END
$Descr A4 11693 8268
encoding utf-8
Sheet 1 1
Title "DoorChecker EndPoint_Input"
Date "8 mar 2015"
Rev ""
Comp "true-nature"
Comment1 ""
Comment2 ""
Comment3 ""
Comment4 ""
$EndDescr
$Comp
L SPST SW?
U 1 1 5A4B9196
P 5600 4450
F 0 "SW?" H 5600 4550 70  0000 C CNN
F 1 "MKA-10110" H 5600 4350 70  0000 C CNN
F 2 "favorites:MKA-10110" H 5600 4450 60  0000 C CNN
F 3 "~" H 5600 4450 60  0000 C CNN
	1    5600 4450
	0    -1   -1   0   
$EndComp
$Comp
L R R?
U 1 1 5A4B9197
P 5600 3700
F 0 "R?" V 5680 3700 40  0000 C CNN
F 1 "2M" V 5607 3701 40  0000 C CNN
F 2 "Resistors_SMD:R_0603_HandSoldering" V 5530 3700 30  0000 C CNN
F 3 "~" H 5600 3700 30  0000 C CNN
	1    5600 3700
	1    0    0    -1  
$EndComp
$Comp
L GND #PWR?
U 1 1 5A4B9198
P 4450 2700
F 0 "#PWR?" H 4450 2700 30  0001 C CNN
F 1 "GND" H 4450 2630 30  0001 C CNN
F 2 "" H 4450 2700 60  0000 C CNN
F 3 "" H 4450 2700 60  0000 C CNN
	1    4450 2700
	1    0    0    -1  
$EndComp
$Comp
L BATTERY BT?
U 1 1 5A4B9199
P 4450 2150
F 0 "BT?" H 4450 2350 50  0000 C CNN
F 1 "CR2032" H 4450 1960 50  0000 C CNN
F 2 "favorites:PBCS-75" H 4450 2150 60  0000 C CNN
F 3 "~" H 4450 2150 60  0000 C CNN
	1    4450 2150
	0    1    1    0   
$EndComp
$Comp
L PWR_FLAG #FLG?
U 1 1 5A4B919A
P 4450 1600
F 0 "#FLG?" H 4450 1695 30  0001 C CNN
F 1 "PWR_FLAG" H 4450 1780 30  0000 C CNN
F 2 "" H 4450 1600 60  0000 C CNN
F 3 "" H 4450 1600 60  0000 C CNN
	1    4450 1600
	1    0    0    -1  
$EndComp
Text Label 8550 4500 0    60   ~ 0
Vcc
Text Label 8550 5100 0    60   ~ 0
CFG
Text Label 8550 4700 0    60   ~ 0
RXD
Text Label 8550 4900 0    60   ~ 0
TXD
Text Label 8550 5000 0    60   ~ 0
GND
$Comp
L WRITER-VCC P?
U 1 1 5A4B919B
P 9200 4800
F 0 "P?" V 9300 4800 60  0000 C CNN
F 1 "WRITER-VCC" V 9400 4800 60  0000 C CNN
F 2 "favorites:WRITE-7P" H 9150 4750 60  0000 C CNN
F 3 "~" H 9150 4750 60  0000 C CNN
	1    9200 4800
	1    0    0    -1  
$EndComp
$Comp
L TWE_LITE_SMD U?
U 1 1 5A4B919C
P 7300 2750
F 0 "U?" H 7300 2650 50  0000 C CNN
F 1 "TWE_LITE_SMD" H 7300 3550 50  0000 C CNN
F 2 "favorites:TWE-001L-NC7" H 7050 1500 50  0001 C CNN
F 3 "DOCUMENTATION" H 7650 1500 50  0001 C CNN
	1    7300 2750
	1    0    0    -1  
$EndComp
NoConn ~ 6550 2100
NoConn ~ 6550 2800
NoConn ~ 6550 3500
NoConn ~ 6550 3600
NoConn ~ 6550 3700
NoConn ~ 8050 3250
NoConn ~ 8050 3050
NoConn ~ 8050 2950
NoConn ~ 8050 2800
NoConn ~ 8050 2600
NoConn ~ 8050 2350
NoConn ~ 8050 2250
Text Label 5700 3400 0    60   ~ 0
DI1
NoConn ~ 6550 2300
Text Label 8550 4600 0    60   ~ 0
RST
Text Label 8550 4800 0    60   ~ 0
PRG
$Comp
L PWR_FLAG #FLG?
U 1 1 5A4B919D
P 4950 4900
F 0 "#FLG?" H 4950 4995 50  0001 C CNN
F 1 "PWR_FLAG" H 4950 5080 50  0000 C CNN
F 2 "" H 4950 4900 60  0000 C CNN
F 3 "" H 4950 4900 60  0000 C CNN
	1    4950 4900
	1    0    0    -1  
$EndComp
NoConn ~ 8050 2500
$Comp
L R R?
U 1 1 5A4B919E
P 8900 1950
F 0 "R?" V 8980 1950 40  0000 C CNN
F 1 "100k" V 8907 1951 40  0000 C CNN
F 2 "Resistors_SMD:R_0603_HandSoldering" V 8830 1950 30  0000 C CNN
F 3 "~" H 8900 1950 30  0000 C CNN
	1    8900 1950
	1    0    0    -1  
$EndComp
Connection ~ 8900 2200
Wire Wire Line
	8900 2200 9150 2200
Wire Wire Line
	9150 2200 9150 1650
Wire Wire Line
	9150 1650 6000 1650
Wire Wire Line
	6000 1650 6000 3150
Connection ~ 5900 1750
Connection ~ 8400 1750
Wire Wire Line
	8900 1750 8900 1800
Wire Wire Line
	8900 2100 8900 2200
Wire Wire Line
	8900 2200 8900 2250
Wire Wire Line
	8900 2700 8900 2550
Wire Wire Line
	8050 2700 8900 2700
Connection ~ 5150 3050
Wire Wire Line
	5150 3050 6550 3050
Connection ~ 4450 1750
Wire Wire Line
	4450 2550 5150 2550
Connection ~ 4450 2550
Wire Wire Line
	4450 2450 4450 2550
Wire Wire Line
	4450 2550 4450 2700
Wire Wire Line
	4450 1600 4450 1750
Wire Wire Line
	4450 1750 4450 1850
Wire Wire Line
	5900 1750 5900 3250
Wire Wire Line
	4950 5000 5150 5000
Wire Wire Line
	5150 5000 5600 5000
Wire Wire Line
	5600 5000 8100 5000
Wire Wire Line
	8100 5000 8800 5000
Wire Wire Line
	6200 4900 8800 4900
Wire Wire Line
	6300 4700 8800 4700
Wire Wire Line
	6100 5100 8800 5100
Wire Wire Line
	8400 4500 8800 4500
Wire Wire Line
	8400 1750 8400 4500
Wire Wire Line
	4450 1750 5900 1750
Wire Wire Line
	5900 1750 8100 1750
Wire Wire Line
	8100 1750 8400 1750
Wire Wire Line
	8400 1750 8900 1750
Wire Wire Line
	8100 2100 8050 2100
Wire Wire Line
	8100 1750 8100 2100
Connection ~ 8100 1750
Wire Wire Line
	6400 2700 6550 2700
Wire Wire Line
	6400 2700 6400 4600
Wire Wire Line
	6550 2450 6300 2450
Wire Wire Line
	6300 2450 6300 4700
Wire Wire Line
	6550 2550 6200 2550
Wire Wire Line
	6200 2550 6200 4900
Wire Wire Line
	8050 3150 8200 3150
Wire Wire Line
	8100 3400 8050 3400
Wire Wire Line
	8100 3400 8100 3500
Wire Wire Line
	8100 3500 8100 3600
Wire Wire Line
	8100 3600 8100 3700
Wire Wire Line
	8100 3700 8100 3800
Wire Wire Line
	8100 3800 8100 5000
Wire Wire Line
	8100 3500 8050 3500
Connection ~ 8100 3500
Wire Wire Line
	8100 3600 8050 3600
Connection ~ 8100 3600
Wire Wire Line
	8100 3700 8050 3700
Connection ~ 8100 3700
Wire Wire Line
	8100 3800 8050 3800
Wire Wire Line
	8200 3150 8200 4800
Wire Wire Line
	6100 2200 6100 5100
Wire Wire Line
	5600 3950 5600 3850
Wire Wire Line
	5600 3550 5600 3400
Wire Wire Line
	5600 3400 6550 3400
Wire Wire Line
	5900 3250 6550 3250
Wire Wire Line
	6550 2200 6100 2200
Wire Wire Line
	5600 5000 5600 4950
Wire Wire Line
	6400 4600 8800 4600
Wire Wire Line
	8200 4800 8800 4800
Connection ~ 5600 5000
Connection ~ 8100 5000
Connection ~ 8100 3800
Wire Wire Line
	4950 4900 4950 5000
Wire Wire Line
	5150 2550 5150 2950
Wire Wire Line
	5150 2950 5150 3050
Wire Wire Line
	5150 3050 5150 5000
Connection ~ 5150 5000
Wire Wire Line
	6000 3150 6550 3150
Wire Wire Line
	6550 2950 5150 2950
Connection ~ 5150 2950
$Comp
L R_Variable R?
U 1 1 5A4B9363
P 8900 2400
F 0 "R?" V 9000 2300 50  0000 L CNN
F 1 "R_Variable" V 8800 2350 50  0000 L CNN
F 2 "" V 8830 2400 50  0001 C CNN
F 3 "" H 8900 2400 50  0001 C CNN
	1    8900 2400
	1    0    0    -1  
$EndComp
$EndSCHEMATC
