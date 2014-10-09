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
LIBS:twe-lite
LIBS:relays
LIBS:Input-cache
EELAYER 27 0
EELAYER END
$Descr A4 11693 8268
encoding utf-8
Sheet 1 1
Title ""
Date "9 oct 2014"
Rev ""
Comp ""
Comment1 ""
Comment2 ""
Comment3 ""
Comment4 ""
$EndDescr
$Comp
L BATTERY BT1
U 1 1 54360838
P 3950 1400
F 0 "BT1" H 3950 1600 50  0000 C CNN
F 1 "BATTERY" H 3950 1210 50  0000 C CNN
F 2 "~" H 3950 1400 60  0000 C CNN
F 3 "~" H 3950 1400 60  0000 C CNN
	1    3950 1400
	-1   0    0    1   
$EndComp
$Comp
L C 0.22F1
U 1 1 54360EC8
P 3900 1950
F 0 "0.22F1" H 3900 2050 40  0000 L CNN
F 1 "C" H 3906 1865 40  0000 L CNN
F 2 "~" H 3938 1800 30  0000 C CNN
F 3 "~" H 3900 1950 60  0000 C CNN
	1    3900 1950
	0    -1   -1   0   
$EndComp
Wire Wire Line
	4100 1950 5400 1950
Wire Wire Line
	3650 1400 3300 1400
Wire Wire Line
	3700 1950 3300 1950
$Comp
L SPST REED1
U 1 1 54360F03
P 3900 4950
F 0 "REED1" H 3900 5050 70  0000 C CNN
F 1 "SPST" H 3900 4850 70  0000 C CNN
F 2 "~" H 3900 4950 60  0000 C CNN
F 3 "~" H 3900 4950 60  0000 C CNN
	1    3900 4950
	1    0    0    -1  
$EndComp
$Comp
L R 1M1
U 1 1 54360F12
P 3300 4300
F 0 "1M1" V 3380 4300 40  0000 C CNN
F 1 "R" V 3307 4301 40  0000 C CNN
F 2 "~" V 3230 4300 30  0000 C CNN
F 3 "~" H 3300 4300 30  0000 C CNN
	1    3300 4300
	-1   0    0    1   
$EndComp
Wire Wire Line
	3300 4550 3300 4950
Wire Wire Line
	3300 4950 3400 4950
Wire Wire Line
	4650 4450 4650 4950
Wire Wire Line
	4650 4950 4400 4950
$Comp
L CONN_5 P2
U 1 1 54360F7C
P 6400 5550
F 0 "P2" V 6350 5550 50  0000 C CNN
F 1 "CONN_5" V 6450 5550 50  0000 C CNN
F 2 "~" H 6400 5550 60  0000 C CNN
F 3 "~" H 6400 5550 60  0000 C CNN
	1    6400 5550
	1    0    0    -1  
$EndComp
Wire Wire Line
	5450 3450 5750 3450
Wire Wire Line
	5750 3450 5750 5350
Wire Wire Line
	5750 5350 6000 5350
Wire Wire Line
	5450 3550 5600 3550
Wire Wire Line
	5600 3550 5600 5750
Wire Wire Line
	5600 5750 6000 5750
Wire Wire Line
	4150 4450 4150 4550
Wire Wire Line
	4150 4550 5450 4550
Wire Wire Line
	5450 4550 5450 5450
Wire Wire Line
	5450 5450 6000 5450
Wire Wire Line
	3550 3850 3100 3850
Wire Wire Line
	3100 3850 3100 5650
Wire Wire Line
	3100 5650 6000 5650
Wire Wire Line
	3550 3250 2900 3250
Wire Wire Line
	2900 3250 2900 5550
Wire Wire Line
	2900 5550 6000 5550
Wire Wire Line
	4250 1400 4550 1400
$Comp
L CONN_2 P1
U 1 1 5436105C
P 5750 2050
F 0 "P1" V 5700 2050 40  0000 C CNN
F 1 "CONN_2" V 5800 2050 40  0000 C CNN
F 2 "~" H 5750 2050 60  0000 C CNN
F 3 "~" H 5750 2050 60  0000 C CNN
	1    5750 2050
	1    0    0    -1  
$EndComp
Wire Wire Line
	4650 2550 4650 2150
Wire Wire Line
	4650 2150 5400 2150
Connection ~ 3300 1950
Wire Wire Line
	4550 1400 4550 2550
Connection ~ 4550 1950
Wire Wire Line
	3300 3550 3550 3550
Wire Wire Line
	3300 1400 3300 4050
NoConn ~ 4150 2550
NoConn ~ 4250 2550
NoConn ~ 4350 2550
NoConn ~ 4450 2550
NoConn ~ 4750 2550
NoConn ~ 5450 3150
NoConn ~ 5450 3250
NoConn ~ 5450 3350
NoConn ~ 5450 3650
NoConn ~ 5450 3750
NoConn ~ 5450 3850
NoConn ~ 4850 4450
NoConn ~ 4750 4450
NoConn ~ 4250 4450
NoConn ~ 4350 4450
NoConn ~ 4550 4450
NoConn ~ 4450 4450
$Comp
L LITE_LITE U1
U 1 1 54360EB9
P 4450 3550
F 0 "U1" H 4450 3550 60  0001 C CNN
F 1 "LITE_LITE" H 4450 3550 60  0001 C CNN
F 2 "" H 4450 3550 60  0000 C CNN
F 3 "" H 4450 3550 60  0000 C CNN
	1    4450 3550
	1    0    0    -1  
$EndComp
NoConn ~ 3550 3750
NoConn ~ 3550 3650
NoConn ~ 3550 3450
NoConn ~ 3550 3350
NoConn ~ 3550 3150
Connection ~ 3300 3550
NoConn ~ 4850 2550
$EndSCHEMATC
