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
P 5600 3950
F 0 "SW1" H 5600 4050 70  0000 C CNN
F 1 "MKA-10110" H 5600 3850 70  0000 C CNN
F 2 "favorites:MKA-10110" H 5600 3950 60  0001 C CNN
F 3 "~" H 5600 3950 60  0000 C CNN
	1    5600 3950
	0    -1   -1   0   
$EndComp
$Comp
L Device:R R1
U 1 1 54360F12
P 5600 4750
F 0 "R1" V 5680 4750 40  0000 C CNN
F 1 "2M" V 5607 4751 40  0000 C CNN
F 2 "Resistor_SMD:R_0603_1608Metric_Pad0.84x1.00mm_HandSolder" V 5530 4750 30  0001 C CNN
F 3 "~" H 5600 4750 30  0000 C CNN
	1    5600 4750
	1    0    0    -1  
$EndComp
$Comp
L power:GND #PWR01
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
L Device:Battery_Cell BT1
U 1 1 543B60F0
P 4450 2150
F 0 "BT1" H 4350 2300 50  0000 C CNN
F 1 "CR2032" H 4300 2100 50  0000 C CNN
F 2 "favorites:PBCS-75" H 4450 2150 60  0001 C CNN
F 3 "~" H 4450 2150 60  0000 C CNN
	1    4450 2150
	1    0    0    -1  
$EndComp
$Comp
L power:PWR_FLAG #FLG02
U 1 1 5486A030
P 4450 1600
F 0 "#FLG02" H 4450 1695 30  0001 C CNN
F 1 "PWR_FLAG" H 4450 1780 30  0000 C CNN
F 2 "" H 4450 1600 60  0000 C CNN
F 3 "" H 4450 1600 60  0000 C CNN
	1    4450 1600
	1    0    0    -1  
$EndComp
Text Label 9250 4500 0    60   ~ 0
Vcc
Text Label 9250 5100 0    60   ~ 0
CFG
Text Label 9250 4700 0    60   ~ 0
RXD
Text Label 9250 4900 0    60   ~ 0
TXD
Text Label 9250 5000 0    60   ~ 0
GND
$Comp
L favorites:WRITER-VCC P1
U 1 1 54C9BECD
P 9900 4800
F 0 "P1" V 10000 4800 60  0000 C CNN
F 1 "WRITER-VCC" V 10100 4800 60  0000 C CNN
F 2 "favorites:WRITE-7P" H 9850 4750 60  0001 C CNN
F 3 "~" H 9850 4750 60  0000 C CNN
	1    9900 4800
	1    0    0    -1  
$EndComp
NoConn ~ 6550 2100
Text Label 5700 2800 0    60   ~ 0
DI1
NoConn ~ 6550 2300
Text Label 9250 4600 0    60   ~ 0
RST
Text Label 9250 4800 0    60   ~ 0
PRG
$Comp
L power:PWR_FLAG #FLG03
U 1 1 550F8F4A
P 4950 4900
F 0 "#FLG03" H 4950 4995 50  0001 C CNN
F 1 "PWR_FLAG" H 4950 5080 50  0000 C CNN
F 2 "" H 4950 4900 60  0000 C CNN
F 3 "" H 4950 4900 60  0000 C CNN
	1    4950 4900
	1    0    0    -1  
$EndComp
$Comp
L Device:R R3
U 1 1 587D4FBE
P 9500 1750
F 0 "R3" V 9580 1750 40  0000 C CNN
F 1 "100k" V 9507 1751 40  0000 C CNN
F 2 "Resistor_SMD:R_0603_1608Metric_Pad0.84x1.00mm_HandSolder" V 9430 1750 30  0001 C CNN
F 3 "~" H 9500 1750 30  0000 C CNN
	1    9500 1750
	0    1    1    0   
$EndComp
$Comp
L Connector_Generic:Conn_01x02 J1
U 1 1 587D57BC
P 9950 2000
F 0 "J1" H 10150 2050 50  0000 L CNN
F 1 "sensor" H 10150 1950 50  0000 L CNN
F 2 "Connector_PinHeader_2.54mm:PinHeader_2x01_P2.54mm_Vertical" H 10150 2100 50  0001 C CNN
F 3 "" H 9950 2000 50  0000 C CNN
	1    9950 2000
	1    0    0    -1  
$EndComp
$Comp
L Device:R R2
U 1 1 5A82DDEB
P 9750 3050
F 0 "R2" V 9830 3050 40  0000 C CNN
F 1 "100k" V 9757 3051 40  0000 C CNN
F 2 "Resistor_SMD:R_0603_1608Metric_Pad0.84x1.00mm_HandSolder" V 9680 3050 30  0001 C CNN
F 3 "~" H 9750 3050 30  0000 C CNN
	1    9750 3050
	1    0    0    -1  
$EndComp
Wire Wire Line
	9750 1650 6000 1650
Wire Wire Line
	6000 1650 6000 3400
Connection ~ 9200 1750
Wire Wire Line
	9750 2100 9750 2300
Wire Wire Line
	8350 2300 9750 2300
Connection ~ 5150 3300
Wire Wire Line
	5150 3300 6550 3300
Connection ~ 4450 1750
Wire Wire Line
	4450 2550 5150 2550
Connection ~ 4450 2550
Wire Wire Line
	4450 2250 4450 2550
Wire Wire Line
	4450 1600 4450 1750
Wire Wire Line
	5900 1750 5900 3500
Wire Wire Line
	4950 5000 5150 5000
Wire Wire Line
	9200 4500 9500 4500
Wire Wire Line
	4450 1750 5900 1750
Wire Wire Line
	6550 2500 6300 2500
Wire Wire Line
	6300 2500 6300 4600
Wire Wire Line
	8350 2700 8900 2700
Wire Wire Line
	6100 2200 6100 5100
Wire Wire Line
	5600 3750 5600 2800
Wire Wire Line
	5600 2800 6550 2800
Wire Wire Line
	5900 3500 6550 3500
Wire Wire Line
	6550 2200 6100 2200
Wire Wire Line
	5600 5000 5600 4900
Wire Wire Line
	6300 4600 9500 4600
Wire Wire Line
	8900 4800 9500 4800
Wire Wire Line
	4950 4900 4950 5000
Wire Wire Line
	5150 2550 5150 3200
Connection ~ 5150 5000
Wire Wire Line
	6550 3200 5150 3200
Connection ~ 5150 3200
Wire Wire Line
	5600 4150 5600 4500
Connection ~ 9750 2300
Wire Wire Line
	5600 4500 6800 4500
Wire Wire Line
	6800 4500 6800 4000
Wire Wire Line
	6800 4000 9750 4000
Wire Wire Line
	9750 4000 9750 3200
Connection ~ 5600 4500
Wire Wire Line
	9650 1750 9750 1750
Connection ~ 9750 1750
Wire Wire Line
	9750 2000 9750 1750
Wire Wire Line
	9200 1750 9350 1750
Wire Wire Line
	5150 3300 5150 5000
Wire Wire Line
	4450 1750 4450 1950
Wire Wire Line
	4450 2550 4450 2700
Wire Wire Line
	5150 5000 5600 5000
Wire Wire Line
	5150 3200 5150 3300
Wire Wire Line
	9750 2300 9750 2900
Wire Wire Line
	5600 4500 5600 4600
Wire Wire Line
	9750 1750 9750 1650
Wire Wire Line
	6100 5100 9500 5100
Wire Wire Line
	7350 3800 7350 3900
Connection ~ 5900 1750
Wire Wire Line
	5900 1750 7450 1750
NoConn ~ 8350 2100
NoConn ~ 8350 2200
NoConn ~ 8350 2400
NoConn ~ 8350 3200
NoConn ~ 8350 3300
Wire Wire Line
	7350 5000 9500 5000
Wire Wire Line
	8900 2700 8900 4800
$Comp
L Device:C_Small C1
U 1 1 5A845ABD
P 7900 4350
F 0 "C1" H 7910 4420 50  0000 L CNN
F 1 "1uF" H 7910 4270 50  0000 L CNN
F 2 "Capacitor_SMD:C_0603_1608Metric_Pad0.84x1.00mm_HandSolder" H 7900 4350 50  0001 C CNN
F 3 "" H 7900 4350 50  0001 C CNN
	1    7900 4350
	0    1    1    0   
$EndComp
Wire Wire Line
	8350 3100 8500 3100
Wire Wire Line
	8500 3100 8500 4900
Wire Wire Line
	8500 4900 9500 4900
Wire Wire Line
	8350 3000 8600 3000
Wire Wire Line
	8600 3000 8600 4700
Wire Wire Line
	8600 4700 9500 4700
NoConn ~ 8350 2500
NoConn ~ 8350 2600
NoConn ~ 8350 2800
NoConn ~ 6550 2600
Wire Wire Line
	6550 3400 6000 3400
NoConn ~ 6550 2900
NoConn ~ 6550 3000
NoConn ~ 6550 3100
Wire Wire Line
	7450 1800 7450 1750
Connection ~ 7450 1750
Wire Wire Line
	7450 1750 9200 1750
Wire Wire Line
	7750 3800 7750 3900
Wire Wire Line
	7750 3900 7650 3900
Connection ~ 7350 3900
Wire Wire Line
	7350 3900 7350 4350
Wire Wire Line
	7450 3800 7450 3900
Connection ~ 7450 3900
Wire Wire Line
	7450 3900 7350 3900
Wire Wire Line
	7550 3800 7550 3900
Connection ~ 7550 3900
Wire Wire Line
	7550 3900 7450 3900
Wire Wire Line
	7650 3800 7650 3900
Connection ~ 7650 3900
Wire Wire Line
	7650 3900 7550 3900
Wire Wire Line
	7800 4350 7350 4350
Connection ~ 7350 4350
Wire Wire Line
	7350 4350 7350 5000
Wire Wire Line
	9200 4350 9200 4500
Wire Wire Line
	9200 1750 9200 4350
Connection ~ 9200 4350
Wire Wire Line
	8000 4350 9200 4350
$Comp
L RF_ZigBee:TWELITE_SMD U1
U 1 1 5A9FFEF1
P 7450 2800
F 0 "U1" H 7450 2850 50  0000 C CNN
F 1 "TWELITE_SMD" H 7500 2700 50  0000 C CNN
F 2 "RF_Module:TWELITE_SMD" H 7450 1700 50  0001 C CNN
F 3 "https://www.mono-wireless.com/jp/products/TWE-LITE/MW-PDS-TWELITE-JP.pdf" H 8200 1800 50  0001 C CNN
	1    7450 2800
	1    0    0    -1  
$EndComp
$EndSCHEMATC
