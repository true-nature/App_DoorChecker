EESchema Schematic File Version 2
LIBS:favorites
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
L SPST SW1
U 1 1 54360F03
P 5600 4450
F 0 "SW1" H 5600 4550 70  0000 C CNN
F 1 "MKA-10110" H 5600 4350 70  0000 C CNN
F 2 "favorites:MKA-10110" H 5600 4450 60  0000 C CNN
F 3 "~" H 5600 4450 60  0000 C CNN
	1    5600 4450
	0    -1   -1   0   
$EndComp
$Comp
L R R1
U 1 1 54360F12
P 5600 3700
F 0 "R1" V 5680 3700 40  0000 C CNN
F 1 "2M" V 5607 3701 40  0000 C CNN
F 2 "Resistors_SMD:R_0603_HandSoldering" V 5530 3700 30  0000 C CNN
F 3 "~" H 5600 3700 30  0000 C CNN
	1    5600 3700
	1    0    0    -1  
$EndComp
$Comp
L GND #PWR01
U 1 1 543B58C8
P 4450 2700
F 0 "#PWR01" H 4450 2700 30  0001 C CNN
F 1 "GND" H 4450 2630 30  0001 C CNN
F 2 "" H 4450 2700 60  0000 C CNN
F 3 "" H 4450 2700 60  0000 C CNN
	1    4450 2700
	1    0    0    -1  
$EndComp
$Comp
L BATTERY BT1
U 1 1 543B60F0
P 4450 2150
F 0 "BT1" H 4450 2350 50  0000 C CNN
F 1 "CR2032" H 4450 1960 50  0000 C CNN
F 2 "favorites:PBCS-75" H 4450 2150 60  0000 C CNN
F 3 "~" H 4450 2150 60  0000 C CNN
	1    4450 2150
	0    1    1    0   
$EndComp
$Comp
L PWR_FLAG #FLG02
U 1 1 5486A030
P 4450 1600
F 0 "#FLG02" H 4450 1695 30  0001 C CNN
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
L CP1 C1
U 1 1 54BDE16D
P 5150 2150
F 0 "C1" H 5200 2250 50  0000 L CNN
F 1 "100u" H 5200 2050 50  0000 L CNN
F 2 "Capacitors_SMD:C_1210_HandSoldering" H 5150 2150 60  0000 C CNN
F 3 "~" H 5150 2150 60  0000 C CNN
	1    5150 2150
	1    0    0    -1  
$EndComp
$Comp
L WRITER-VCC P1
U 1 1 54C9BECD
P 9200 4800
F 0 "P1" V 9300 4800 60  0000 C CNN
F 1 "WRITER-VCC" V 9400 4800 60  0000 C CNN
F 2 "favorites:WRITE-7P" H 9150 4750 60  0000 C CNN
F 3 "~" H 9150 4750 60  0000 C CNN
	1    9200 4800
	1    0    0    -1  
$EndComp
$Comp
L TWE_LITE_SMD U1
U 1 1 54EABB18
P 7300 2750
F 0 "U1" H 7300 2650 50  0000 C CNN
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
NoConn ~ 8050 2700
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
L PWR_FLAG #FLG03
U 1 1 550F8F4A
P 4950 4900
F 0 "#FLG03" H 4950 4995 50  0001 C CNN
F 1 "PWR_FLAG" H 4950 5080 50  0000 C CNN
F 2 "" H 4950 4900 60  0000 C CNN
F 3 "" H 4950 4900 60  0000 C CNN
	1    4950 4900
	1    0    0    -1  
$EndComp
NoConn ~ 8050 2500
Connection ~ 5150 5000
Wire Wire Line
	5150 2300 5150 5000
Wire Wire Line
	4950 4900 4950 5000
Connection ~ 8100 3800
Connection ~ 8100 5000
Connection ~ 5600 5000
Wire Wire Line
	8200 4800 8800 4800
Wire Wire Line
	6400 4600 8800 4600
Wire Wire Line
	5600 5000 5600 4950
Wire Wire Line
	6550 2200 6100 2200
Connection ~ 5900 3150
Wire Wire Line
	5900 3150 6550 3150
Connection ~ 5900 3050
Wire Wire Line
	5900 3050 6550 3050
Connection ~ 5900 2950
Wire Wire Line
	5900 2950 6550 2950
Connection ~ 5900 1750
Wire Wire Line
	5900 3250 6550 3250
Wire Wire Line
	5600 3400 6550 3400
Wire Wire Line
	5600 3550 5600 3400
Wire Wire Line
	5600 3950 5600 3850
Wire Wire Line
	6100 2200 6100 5100
Wire Wire Line
	8200 3150 8200 4800
Wire Wire Line
	8100 3800 8050 3800
Connection ~ 8100 3700
Wire Wire Line
	8100 3700 8050 3700
Connection ~ 8100 3600
Wire Wire Line
	8100 3600 8050 3600
Connection ~ 8100 3500
Wire Wire Line
	8100 3500 8050 3500
Wire Wire Line
	8100 5000 8100 3400
Wire Wire Line
	8100 3400 8050 3400
Wire Wire Line
	8050 3150 8200 3150
Wire Wire Line
	6200 2550 6200 4900
Wire Wire Line
	6550 2550 6200 2550
Wire Wire Line
	6300 2450 6300 4700
Wire Wire Line
	6550 2450 6300 2450
Wire Wire Line
	6400 2700 6400 4600
Wire Wire Line
	6400 2700 6550 2700
Connection ~ 8100 1750
Wire Wire Line
	8100 1750 8100 2100
Wire Wire Line
	8050 2100 8100 2100
Wire Wire Line
	4450 1750 8400 1750
Wire Wire Line
	8400 1750 8400 4500
Wire Wire Line
	8400 4500 8800 4500
Wire Wire Line
	6100 5100 8800 5100
Wire Wire Line
	6300 4700 8800 4700
Wire Wire Line
	6200 4900 8800 4900
Wire Wire Line
	4950 5000 8800 5000
Wire Wire Line
	5900 1750 5900 3250
Wire Wire Line
	4450 1600 4450 1850
Wire Wire Line
	5150 2000 5150 1750
Connection ~ 5150 1750
Wire Wire Line
	4450 2450 4450 2700
Connection ~ 4450 2550
Wire Wire Line
	4450 2550 5150 2550
Connection ~ 5150 2550
Connection ~ 4450 1750
$EndSCHEMATC
