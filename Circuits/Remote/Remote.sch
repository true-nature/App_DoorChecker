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
LIBS:Remote-cache
EELAYER 27 0
EELAYER END
$Descr A4 11693 8268
encoding utf-8
Sheet 1 1
Title ""
Date "21 jan 2015"
Rev ""
Comp ""
Comment1 ""
Comment2 ""
Comment3 ""
Comment4 ""
$EndDescr
$Comp
L TWE_LITE_DIP U1
U 1 1 54BF5D85
P 3150 3700
F 0 "U1" H 3150 3600 50  0000 C CNN
F 1 "TWE_LITE_DIP" H 3150 4500 50  0000 C CNN
F 2 "MODULE" H 2900 2800 50  0001 C CNN
F 3 "DOCUMENTATION" H 3500 2800 50  0001 C CNN
	1    3150 3700
	1    0    0    -1  
$EndComp
$Comp
L ATP3011-PU U?
U 1 1 54BF6333
P 7700 3650
F 0 "U?" H 7700 3550 50  0000 C CNN
F 1 "ATP3011-PU" H 7700 4450 50  0000 C CNN
F 2 "MODULE" H 7450 2750 50  0001 C CNN
F 3 "DOCUMENTATION" H 8050 2750 50  0001 C CNN
	1    7700 3650
	1    0    0    -1  
$EndComp
$Comp
L VCC #PWR?
U 1 1 54BF6362
P 1700 1400
F 0 "#PWR?" H 1700 1500 30  0001 C CNN
F 1 "VCC" H 1700 1500 30  0000 C CNN
F 2 "~" H 1700 1400 60  0000 C CNN
F 3 "~" H 1700 1400 60  0000 C CNN
	1    1700 1400
	1    0    0    -1  
$EndComp
$Comp
L VCC #PWR?
U 1 1 54BF6371
P 4000 1400
F 0 "#PWR?" H 4000 1500 30  0001 C CNN
F 1 "VCC" H 4000 1500 30  0000 C CNN
F 2 "~" H 4000 1400 60  0000 C CNN
F 3 "~" H 4000 1400 60  0000 C CNN
	1    4000 1400
	1    0    0    -1  
$EndComp
$Comp
L VCC #PWR?
U 1 1 54BF6380
P 10500 1050
F 0 "#PWR?" H 10500 1150 30  0001 C CNN
F 1 "VCC" H 10500 1150 30  0000 C CNN
F 2 "~" H 10500 1050 60  0000 C CNN
F 3 "~" H 10500 1050 60  0000 C CNN
	1    10500 1050
	1    0    0    -1  
$EndComp
$Comp
L R R5
U 1 1 54BF6399
P 1400 2300
F 0 "R5" V 1480 2300 40  0000 C CNN
F 1 "680" V 1407 2301 40  0000 C CNN
F 2 "~" V 1330 2300 30  0000 C CNN
F 3 "~" H 1400 2300 30  0000 C CNN
	1    1400 2300
	1    0    0    -1  
$EndComp
$Comp
L R R6
U 1 1 54BF63A8
P 1700 2300
F 0 "R6" V 1780 2300 40  0000 C CNN
F 1 "680" V 1707 2301 40  0000 C CNN
F 2 "~" V 1630 2300 30  0000 C CNN
F 3 "~" H 1700 2300 30  0000 C CNN
	1    1700 2300
	1    0    0    -1  
$EndComp
$Comp
L R R4
U 1 1 54BF63B7
P 1050 2300
F 0 "R4" V 1130 2300 40  0000 C CNN
F 1 "680" V 1057 2301 40  0000 C CNN
F 2 "~" V 980 2300 30  0000 C CNN
F 3 "~" H 1050 2300 30  0000 C CNN
	1    1050 2300
	1    0    0    -1  
$EndComp
$Comp
L LED LD1
U 1 1 54BF63DA
P 1050 2800
F 0 "LD1" H 1050 2900 50  0000 C CNN
F 1 "DOOR" H 1050 2700 50  0000 C CNN
F 2 "~" H 1050 2800 60  0000 C CNN
F 3 "~" H 1050 2800 60  0000 C CNN
	1    1050 2800
	0    1    1    0   
$EndComp
$Comp
L LED LD2
U 1 1 54BF6402
P 1400 2800
F 0 "LD2" H 1400 2900 50  0000 C CNN
F 1 "COMM" H 1400 2700 50  0000 C CNN
F 2 "~" H 1400 2800 60  0000 C CNN
F 3 "~" H 1400 2800 60  0000 C CNN
	1    1400 2800
	0    1    1    0   
$EndComp
$Comp
L LED LD3
U 1 1 54BF642A
P 1700 2800
F 0 "LD3" H 1700 2900 50  0000 C CNN
F 1 "BATT" H 1700 2700 50  0000 C CNN
F 2 "~" H 1700 2800 60  0000 C CNN
F 3 "~" H 1700 2800 60  0000 C CNN
	1    1700 2800
	0    1    1    0   
$EndComp
Wire Wire Line
	1700 1400 1700 2050
Wire Wire Line
	1050 2050 1050 1750
Wire Wire Line
	1050 1750 1700 1750
Connection ~ 1700 1750
Wire Wire Line
	1400 2050 1400 1750
Connection ~ 1400 1750
Wire Wire Line
	1700 3000 1700 3350
Wire Wire Line
	1700 3350 2400 3350
Wire Wire Line
	1400 3000 1400 3550
Wire Wire Line
	1400 3550 2400 3550
Wire Wire Line
	1050 3000 1050 4050
Wire Wire Line
	1050 4050 2400 4050
Wire Wire Line
	3900 3050 4000 3050
Wire Wire Line
	4000 3050 4000 1400
$Comp
L SW_PUSH SW1
U 1 1 54BF652D
P 4000 4800
F 0 "SW1" H 4150 4910 50  0000 C CNN
F 1 "WakeUp" H 4000 4720 50  0000 C CNN
F 2 "~" H 4000 4800 60  0000 C CNN
F 3 "~" H 4000 4800 60  0000 C CNN
	1    4000 4800
	0    1    1    0   
$EndComp
$Comp
L GND #PWR?
U 1 1 54BF655A
P 2300 5400
F 0 "#PWR?" H 2300 5400 30  0001 C CNN
F 1 "GND" H 2300 5330 30  0001 C CNN
F 2 "~" H 2300 5400 60  0000 C CNN
F 3 "~" H 2300 5400 60  0000 C CNN
	1    2300 5400
	1    0    0    -1  
$EndComp
Wire Wire Line
	2400 4350 2300 4350
Wire Wire Line
	2300 4350 2300 5400
Wire Wire Line
	3900 4350 4000 4350
Wire Wire Line
	4000 4350 4000 4500
Wire Wire Line
	4000 5100 4000 5200
Wire Wire Line
	4000 5200 2300 5200
Connection ~ 2300 5200
$Comp
L R R?
U 1 1 54BF65A8
P 4350 1850
F 0 "R?" V 4430 1850 40  0000 C CNN
F 1 "R" V 4357 1851 40  0000 C CNN
F 2 "~" V 4280 1850 30  0000 C CNN
F 3 "~" H 4350 1850 30  0000 C CNN
	1    4350 1850
	1    0    0    -1  
$EndComp
$Comp
L R R?
U 1 1 54BF65B7
P 4650 1850
F 0 "R?" V 4730 1850 40  0000 C CNN
F 1 "R" V 4657 1851 40  0000 C CNN
F 2 "~" V 4580 1850 30  0000 C CNN
F 3 "~" H 4650 1850 30  0000 C CNN
	1    4650 1850
	1    0    0    -1  
$EndComp
Wire Wire Line
	4900 1500 4000 1500
Connection ~ 4000 1500
Wire Wire Line
	4350 1600 4350 1500
Connection ~ 4350 1500
Wire Wire Line
	4650 1600 4650 1500
Connection ~ 4650 1500
$EndSCHEMATC