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
P 5900 1000
F 0 "#PWR03" H 5900 1100 30  0001 C CNN
F 1 "VCC" H 5900 1100 30  0000 C CNN
F 2 "" H 5900 1000 60  0000 C CNN
F 3 "" H 5900 1000 60  0000 C CNN
	1    5900 1000
	1    0    0    -1  
$EndComp
$Comp
L BATTERY BT1
U 1 1 543B60F0
P 1600 2250
F 0 "BT1" H 1600 2450 50  0000 C CNN
F 1 "CR2032" H 1600 2060 50  0000 C CNN
F 2 "favorites:PBCS-75" H 1600 2250 60  0000 C CNN
F 3 "~" H 1600 2250 60  0000 C CNN
	1    1600 2250
	0    1    1    0   
$EndComp
Wire Wire Line
	5900 1000 5900 3250
Wire Wire Line
	5400 5000 8800 5000
Wire Wire Line
	6200 4900 8800 4900
Wire Wire Line
	6300 4700 8800 4700
Wire Wire Line
	2200 1400 2200 2100
Wire Wire Line
	1600 2550 1600 2850
$Comp
L PWR_FLAG #FLG04
U 1 1 5486A030
P 2450 1500
F 0 "#FLG04" H 2450 1595 30  0001 C CNN
F 1 "PWR_FLAG" H 2450 1680 30  0000 C CNN
F 2 "" H 2450 1500 60  0000 C CNN
F 3 "" H 2450 1500 60  0000 C CNN
	1    2450 1500
	1    0    0    -1  
$EndComp
Wire Wire Line
	2450 1500 2200 1500
Wire Wire Line
	2200 2550 2200 2400
Wire Wire Line
	1600 2550 3400 2550
Wire Wire Line
	6100 5100 8800 5100
Wire Wire Line
	8800 4500 8400 4500
Wire Wire Line
	8400 4500 8400 1750
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
Wire Wire Line
	1600 1750 1600 1950
Connection ~ 2200 1500
Wire Wire Line
	2050 1750 3400 1750
Connection ~ 2200 1750
Wire Wire Line
	1600 1750 1750 1750
Text Label 1600 1850 1    60   ~ 0
DC3V
$Comp
L R R2
U 1 1 54BCF561
P 1900 1750
F 0 "R2" V 1980 1750 40  0000 C CNN
F 1 "1k" V 1907 1751 40  0000 C CNN
F 2 "Resistors_SMD:R_0603_HandSoldering" V 1830 1750 30  0000 C CNN
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
F 2 "Capacitors_SMD:C_1210_HandSoldering" H 2200 2250 60  0000 C CNN
F 3 "~" H 2200 2250 60  0000 C CNN
	1    2200 2250
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
L CP1 C2
U 1 1 54EAB9CB
P 2500 2250
F 0 "C2" H 2550 2350 50  0000 L CNN
F 1 "100u" H 2550 2150 50  0000 L CNN
F 2 "Capacitors_SMD:C_1210_HandSoldering" H 2500 2250 60  0000 C CNN
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
F 2 "Capacitors_SMD:C_1210_HandSoldering" H 2800 2250 60  0000 C CNN
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
F 2 "Capacitors_SMD:C_1210_HandSoldering" H 3100 2250 60  0000 C CNN
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
F 2 "Capacitors_SMD:C_1210_HandSoldering" H 3400 2250 60  0000 C CNN
F 3 "~" H 3400 2250 60  0000 C CNN
	1    3400 2250
	1    0    0    -1  
$EndComp
Wire Wire Line
	3400 1750 3400 2100
Wire Wire Line
	3400 2550 3400 2400
Connection ~ 2200 2550
Wire Wire Line
	2500 2400 2500 2550
Connection ~ 2500 2550
Wire Wire Line
	2800 2400 2800 2550
Connection ~ 2800 2550
Wire Wire Line
	3100 2400 3100 2550
Connection ~ 3100 2550
Wire Wire Line
	3100 2100 3100 1750
Connection ~ 3100 1750
Wire Wire Line
	2800 2100 2800 1750
Connection ~ 2800 1750
Wire Wire Line
	2500 1750 2500 2100
Connection ~ 2500 1750
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
Wire Wire Line
	8400 1750 3800 1750
Wire Wire Line
	8050 2100 8100 2100
Wire Wire Line
	8100 2100 8100 1750
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
	8050 3400 8100 3400
Wire Wire Line
	8100 3400 8100 5000
Wire Wire Line
	8100 3500 8050 3500
Connection ~ 8100 3500
Wire Wire Line
	8050 3600 8100 3600
Connection ~ 8100 3600
Wire Wire Line
	8050 3700 8100 3700
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
NoConn ~ 6550 2100
NoConn ~ 6550 2800
Wire Wire Line
	5900 3250 6550 3250
Connection ~ 5900 1750
Wire Wire Line
	6550 2950 5900 2950
Connection ~ 5900 2950
Wire Wire Line
	6550 3050 5900 3050
Connection ~ 5900 3050
Wire Wire Line
	6550 3150 5900 3150
Connection ~ 5900 3150
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
$Comp
L TCM809RVNB U2
U 1 1 54F40815
P 4600 2200
F 0 "U2" H 4650 2400 60  0000 C CNN
F 1 "TCM809RVNB" H 4650 2500 60  0000 C CNN
F 2 "Transistors_SMD:sc70" H 4600 2200 60  0000 C CNN
F 3 "~" H 4600 2200 60  0000 C CNN
	1    4600 2200
	1    0    0    -1  
$EndComp
$Comp
L R R3
U 1 1 54F408D3
P 3800 2150
F 0 "R3" V 3880 2150 40  0000 C CNN
F 1 "10M" V 3807 2151 40  0000 C CNN
F 2 "Resistors_SMD:R_0603_HandSoldering" V 3730 2150 30  0000 C CNN
F 3 "~" H 3800 2150 30  0000 C CNN
	1    3800 2150
	1    0    0    -1  
$EndComp
Wire Wire Line
	3800 1750 3800 2000
Wire Wire Line
	4250 2150 4250 1750
Connection ~ 4250 1750
Wire Wire Line
	4600 2500 4600 3400
Wire Wire Line
	8050 2500 8300 2500
Wire Wire Line
	8300 2500 8300 4000
Wire Wire Line
	8300 4000 5250 4000
Text Label 5800 4000 0    60   ~ 0
DO1
Text Label 4600 3050 1    60   ~ 0
QGND
Wire Wire Line
	6550 2200 6100 2200
NoConn ~ 6550 2300
$Comp
L 2N7002DW U3
U 1 1 550F37E6
P 4950 3250
F 0 "U3" H 4950 3550 40  0000 R CNN
F 1 "2N7002DW" H 5100 2950 40  0000 R CNN
F 2 "Housings_SOT-23_SOT-143_TSOT-6:SC-70-6_Handsoldering" H 4950 2900 39  0001 C CNN
F 3 "" H 5700 2400 60  0000 C CNN
	1    4950 3250
	1    0    0    -1  
$EndComp
$Comp
L R R4
U 1 1 550F3995
P 4000 2150
F 0 "R4" V 4080 2150 40  0000 C CNN
F 1 "10M" V 4007 2151 40  0000 C CNN
F 2 "Resistors_SMD:R_0603_HandSoldering" V 3930 2150 30  0000 C CNN
F 3 "~" H 4000 2150 30  0000 C CNN
	1    4000 2150
	1    0    0    -1  
$EndComp
Wire Wire Line
	4000 2000 4000 1750
Connection ~ 4000 1750
Wire Wire Line
	4600 3400 4750 3400
Wire Wire Line
	4750 3250 4700 3250
Wire Wire Line
	4700 3250 4700 2650
Wire Wire Line
	4000 2650 4950 2650
Wire Wire Line
	4950 2650 4950 2150
Wire Wire Line
	5150 3400 5150 3600
Wire Wire Line
	5150 3600 4450 3600
Wire Wire Line
	4450 3100 4450 3750
Wire Wire Line
	4450 3100 4750 3100
Wire Wire Line
	4000 2300 4000 2650
Connection ~ 4700 2650
Wire Wire Line
	5150 3250 5250 3250
Wire Wire Line
	5250 4000 5250 2750
Wire Wire Line
	5250 2750 3800 2750
Wire Wire Line
	3800 2750 3800 2300
Connection ~ 5250 3250
Wire Wire Line
	5600 4950 5600 5000
Text Label 8550 4600 0    60   ~ 0
RST
Wire Wire Line
	6400 4600 8800 4600
Wire Wire Line
	8200 4800 8800 4800
Text Label 8550 4800 0    60   ~ 0
PRG
Connection ~ 5600 5000
Wire Wire Line
	5400 3100 5400 5000
Wire Wire Line
	5150 3100 5500 3100
$Comp
L GND #PWR05
U 1 1 550F83A2
P 4450 3750
F 0 "#PWR05" H 4450 3750 30  0001 C CNN
F 1 "GND" H 4450 3680 30  0001 C CNN
F 2 "" H 4450 3750 60  0000 C CNN
F 3 "" H 4450 3750 60  0000 C CNN
	1    4450 3750
	1    0    0    -1  
$EndComp
Connection ~ 4450 3600
$Comp
L PWR_FLAG #FLG06
U 1 1 550F8F4A
P 5500 3100
F 0 "#FLG06" H 5500 3195 50  0001 C CNN
F 1 "PWR_FLAG" H 5500 3280 50  0000 C CNN
F 2 "" H 5500 3100 60  0000 C CNN
F 3 "" H 5500 3100 60  0000 C CNN
	1    5500 3100
	1    0    0    -1  
$EndComp
Connection ~ 5400 3100
Text Label 4950 2550 1    60   ~ 0
RESET#
Connection ~ 8100 5000
Connection ~ 8100 3800
$EndSCHEMATC
