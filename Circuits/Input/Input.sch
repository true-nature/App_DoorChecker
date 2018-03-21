EESchema Schematic File Version 4
LIBS:Input-cache
EELAYER 26 0
EELAYER END
$Descr A4 11693 8268
encoding utf-8
Sheet 1 1
Title "DoorChecker EndPoint_Input"
Date "2018-03-09"
Rev ""
Comp "https://github.com/true-nature"
Comment1 ""
Comment2 ""
Comment3 ""
Comment4 ""
$EndDescr
$Comp
L Switch:SW_Reed SW1
U 1 1 54360F03
P 2400 3600
F 0 "SW1" H 2400 3700 70  0000 C CNN
F 1 "MKA-10110" H 2400 3500 70  0000 C CNN
F 2 "favorites:MKA-10110" H 2400 3600 60  0001 C CNN
F 3 "~" H 2400 3600 60  0000 C CNN
	1    2400 3600
	0    -1   -1   0   
$EndComp
$Comp
L Device:R R1
U 1 1 54360F12
P 2400 4400
F 0 "R1" V 2480 4400 40  0000 C CNN
F 1 "2M" V 2407 4401 40  0000 C CNN
F 2 "Resistor_SMD:R_0603_1608Metric_Pad0.84x1.00mm_HandSolder" V 2330 4400 30  0001 C CNN
F 3 "~" H 2400 4400 30  0000 C CNN
	1    2400 4400
	1    0    0    -1  
$EndComp
$Comp
L power:GND #PWR01
U 1 1 543B58C8
P 1250 2350
F 0 "#PWR01" H 1250 2350 30  0001 C CNN
F 1 "GND" H 1250 2280 30  0001 C CNN
F 2 "" H 1250 2350 60  0000 C CNN
F 3 "" H 1250 2350 60  0000 C CNN
	1    1250 2350
	1    0    0    -1  
$EndComp
$Comp
L Device:Battery_Cell BT1
U 1 1 543B60F0
P 1250 1800
F 0 "BT1" H 1150 1950 50  0000 C CNN
F 1 "CR2032" H 1100 1750 50  0000 C CNN
F 2 "favorites:PBCS-75" H 1250 1800 60  0001 C CNN
F 3 "~" H 1250 1800 60  0000 C CNN
	1    1250 1800
	1    0    0    -1  
$EndComp
Text Label 6050 4550 0    60   ~ 0
Vcc
Text Label 6050 5150 0    60   ~ 0
CFG
Text Label 6050 4750 0    60   ~ 0
RXD
Text Label 6050 4950 0    60   ~ 0
TXD
Text Label 6050 5050 0    60   ~ 0
GND
$Comp
L favorites:WRITER-VCC P1
U 1 1 54C9BECD
P 6700 4850
F 0 "P1" V 6800 4850 60  0000 C CNN
F 1 "WRITER-VCC" V 6900 4850 60  0000 C CNN
F 2 "favorites:WRITE-7P" H 6650 4800 60  0001 C CNN
F 3 "~" H 6650 4800 60  0000 C CNN
	1    6700 4850
	1    0    0    -1  
$EndComp
NoConn ~ 3450 1750
Text Label 2500 2450 0    60   ~ 0
DI1
NoConn ~ 3450 1950
Text Label 6050 4650 0    60   ~ 0
RST
Text Label 6050 4850 0    60   ~ 0
PRG
$Comp
L Device:R R3
U 1 1 587D4FBE
P 6300 1400
F 0 "R3" V 6380 1400 40  0000 C CNN
F 1 "100k" V 6307 1401 40  0000 C CNN
F 2 "Resistor_SMD:R_0603_1608Metric_Pad0.84x1.00mm_HandSolder" V 6230 1400 30  0001 C CNN
F 3 "~" H 6300 1400 30  0000 C CNN
	1    6300 1400
	0    1    1    0   
$EndComp
$Comp
L Connector_Generic:Conn_01x02 J1
U 1 1 587D57BC
P 6750 1650
F 0 "J1" H 6950 1700 50  0000 L CNN
F 1 "sensor" H 6950 1600 50  0000 L CNN
F 2 "Connector_PinHeader_2.54mm:PinHeader_2x01_P2.54mm_Vertical" H 6950 1750 50  0001 C CNN
F 3 "" H 6750 1650 50  0000 C CNN
	1    6750 1650
	1    0    0    -1  
$EndComp
$Comp
L Device:R R2
U 1 1 5A82DDEB
P 6550 2700
F 0 "R2" V 6630 2700 40  0000 C CNN
F 1 "100k" V 6557 2701 40  0000 C CNN
F 2 "Resistor_SMD:R_0603_1608Metric_Pad0.84x1.00mm_HandSolder" V 6480 2700 30  0001 C CNN
F 3 "~" H 6550 2700 30  0000 C CNN
	1    6550 2700
	1    0    0    -1  
$EndComp
Connection ~ 6000 1400
Wire Wire Line
	6550 1750 6550 1950
Wire Wire Line
	5050 1950 6550 1950
Wire Wire Line
	1250 2200 1950 2200
Connection ~ 1250 2200
Wire Wire Line
	1250 1900 1250 2200
Wire Wire Line
	6000 4550 6300 4550
Wire Wire Line
	3450 2150 3100 2150
Wire Wire Line
	3100 2150 3100 4650
Wire Wire Line
	5050 2350 5700 2350
Wire Wire Line
	2900 1850 2900 5150
Wire Wire Line
	2400 3400 2400 2450
Wire Wire Line
	2400 2450 3450 2450
Wire Wire Line
	3450 1850 2900 1850
Wire Wire Line
	2400 4650 2400 4550
Wire Wire Line
	3100 4650 6300 4650
Wire Wire Line
	5700 4850 6300 4850
Wire Wire Line
	1950 2200 1950 2850
Wire Wire Line
	3450 2850 1950 2850
Connection ~ 1950 2850
Wire Wire Line
	2400 3800 2400 4000
Connection ~ 6550 1950
Wire Wire Line
	6550 4000 6550 2850
Connection ~ 2400 4000
Wire Wire Line
	6450 1400 6550 1400
Wire Wire Line
	6550 1650 6550 1400
Wire Wire Line
	6000 1400 6150 1400
Wire Wire Line
	1250 1400 1250 1600
Wire Wire Line
	1250 2200 1250 2350
Wire Wire Line
	1950 4650 2400 4650
Wire Wire Line
	6550 1950 6550 2550
Wire Wire Line
	2400 4000 2400 4250
Wire Wire Line
	2900 5150 6300 5150
Wire Wire Line
	4150 3450 4150 3550
NoConn ~ 5050 1750
NoConn ~ 5050 1850
NoConn ~ 5050 2050
NoConn ~ 5050 2850
NoConn ~ 5050 2950
Wire Wire Line
	4150 5050 6300 5050
Wire Wire Line
	5700 2350 5700 4850
$Comp
L Device:C_Small C1
U 1 1 5A845ABD
P 5050 3550
F 0 "C1" H 5060 3620 50  0000 L CNN
F 1 "1uF" H 5060 3470 50  0000 L CNN
F 2 "Capacitor_SMD:C_0603_1608Metric_Pad0.84x1.00mm_HandSolder" H 5050 3550 50  0001 C CNN
F 3 "" H 5050 3550 50  0001 C CNN
	1    5050 3550
	0    1    1    0   
$EndComp
Wire Wire Line
	5050 2750 5300 2750
Wire Wire Line
	5300 2750 5300 4950
Wire Wire Line
	5300 4950 6300 4950
Wire Wire Line
	5050 2650 5400 2650
Wire Wire Line
	5400 2650 5400 4750
Wire Wire Line
	5400 4750 6300 4750
NoConn ~ 5050 2150
NoConn ~ 5050 2250
NoConn ~ 5050 2450
NoConn ~ 3450 2250
NoConn ~ 3450 2550
NoConn ~ 3450 2650
NoConn ~ 3450 2750
Wire Wire Line
	4250 1450 4250 1400
Connection ~ 4250 1400
Wire Wire Line
	4250 1400 6000 1400
Wire Wire Line
	4550 3450 4550 3550
Wire Wire Line
	4550 3550 4450 3550
Connection ~ 4150 3550
Wire Wire Line
	4250 3450 4250 3550
Connection ~ 4250 3550
Wire Wire Line
	4250 3550 4150 3550
Wire Wire Line
	4350 3450 4350 3550
Connection ~ 4350 3550
Wire Wire Line
	4350 3550 4250 3550
Wire Wire Line
	4450 3450 4450 3550
Connection ~ 4450 3550
Wire Wire Line
	4450 3550 4350 3550
Wire Wire Line
	4950 3550 4550 3550
Wire Wire Line
	4150 3550 4150 5050
Wire Wire Line
	6000 3550 6000 4550
Wire Wire Line
	6000 1400 6000 3550
Connection ~ 6000 3550
Wire Wire Line
	5150 3550 6000 3550
$Comp
L RF_ZigBee:TWELITE U1
U 1 1 5A9FFEF1
P 4250 2450
F 0 "U1" H 3800 3300 50  0000 C CNN
F 1 "TWELITE_SMD" H 4550 3300 50  0000 C CNN
F 2 "RF_Module:TWELITE_SMD" H 4250 1350 50  0001 C CNN
F 3 "https://www.mono-wireless.com/jp/products/TWE-LITE/MW-PDS-TWELITE-JP.pdf" H 5000 1450 50  0001 C CNN
	1    4250 2450
	1    0    0    -1  
$EndComp
Text Notes 2550 5500 0    100  ~ 0
R1 and R2 are exclusive.
Wire Wire Line
	2400 4000 6550 4000
Connection ~ 4550 3550
Connection ~ 1250 1400
Wire Wire Line
	1250 1250 1250 1400
$Comp
L power:PWR_FLAG #FLG02
U 1 1 5486A030
P 1250 1250
F 0 "#FLG02" H 1250 1345 30  0001 C CNN
F 1 "PWR_FLAG" H 1250 1430 30  0000 C CNN
F 2 "" H 1250 1250 60  0000 C CNN
F 3 "" H 1250 1250 60  0000 C CNN
	1    1250 1250
	1    0    0    -1  
$EndComp
$Comp
L power:PWR_FLAG #FLG0101
U 1 1 5AAF2C2D
P 1750 4550
F 0 "#FLG0101" H 1750 4645 30  0001 C CNN
F 1 "PWR_FLAG" H 1750 4730 30  0000 C CNN
F 2 "" H 1750 4550 60  0000 C CNN
F 3 "" H 1750 4550 60  0000 C CNN
	1    1750 4550
	1    0    0    -1  
$EndComp
Wire Wire Line
	1750 4550 1750 4650
Wire Wire Line
	1750 4650 1950 4650
Connection ~ 1950 4650
Wire Wire Line
	1950 2850 1950 3050
Wire Wire Line
	3450 3050 1950 3050
Connection ~ 1950 3050
Wire Wire Line
	1950 3050 1950 4650
Wire Wire Line
	1250 1400 4250 1400
NoConn ~ 3450 2950
NoConn ~ 3450 3150
$EndSCHEMATC
