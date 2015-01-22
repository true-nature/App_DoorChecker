EESchema Schematic File Version 2
LIBS:TWE-Lite
LIBS:StepUpDIP3.3V
LIBS:HT82V739
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
Date "22 jan 2015"
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
	1700 1400 1700 1750
Wire Wire Line
	1700 1750 1700 2050
Wire Wire Line
	1050 2050 1050 1750
Wire Wire Line
	1050 1750 1400 1750
Wire Wire Line
	1400 1750 1700 1750
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
	4000 3050 3900 3050
Wire Wire Line
	4000 1400 4000 1500
Wire Wire Line
	4000 1500 4000 3050
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
$Comp
L R R1
U 1 1 54BF65A8
P 4200 1850
F 0 "R1" V 4280 1850 40  0000 C CNN
F 1 "10k" V 4207 1851 40  0000 C CNN
F 2 "~" V 4130 1850 30  0000 C CNN
F 3 "~" H 4200 1850 30  0000 C CNN
	1    4200 1850
	1    0    0    -1  
$EndComp
$Comp
L R R2
U 1 1 54BF65B7
P 4500 1850
F 0 "R2" V 4580 1850 40  0000 C CNN
F 1 "10k" V 4507 1851 40  0000 C CNN
F 2 "~" V 4430 1850 30  0000 C CNN
F 3 "~" H 4500 1850 30  0000 C CNN
	1    4500 1850
	1    0    0    -1  
$EndComp
Wire Wire Line
	4000 1500 4200 1500
Wire Wire Line
	4200 1500 4500 1500
Wire Wire Line
	4500 1500 4800 1500
Connection ~ 4000 1500
Wire Wire Line
	4200 1600 4200 1500
Wire Wire Line
	4500 1500 4500 1600
$Comp
L FET_N Q1
U 1 1 54BFA29A
P 4850 5200
F 0 "Q1" H 4753 5450 70  0000 C CNN
F 1 "2SK4017" H 4703 4953 60  0000 C CNN
F 2 "~" H 4850 5200 60  0000 C CNN
F 3 "~" H 4850 5200 60  0000 C CNN
	1    4850 5200
	1    0    0    -1  
$EndComp
$Comp
L GND #PWR?
U 1 1 54BFA2E3
P 4000 5750
F 0 "#PWR?" H 4000 5750 30  0001 C CNN
F 1 "GND" H 4000 5680 30  0001 C CNN
F 2 "~" H 4000 5750 60  0000 C CNN
F 3 "~" H 4000 5750 60  0000 C CNN
	1    4000 5750
	1    0    0    -1  
$EndComp
Wire Wire Line
	4000 5100 4000 5750
$Comp
L R R7
U 1 1 54BFA335
P 3050 5200
F 0 "R7" V 3130 5200 40  0000 C CNN
F 1 "1k" V 3057 5201 40  0000 C CNN
F 2 "~" V 2980 5200 30  0000 C CNN
F 3 "~" H 3050 5200 30  0000 C CNN
	1    3050 5200
	0    -1   -1   0   
$EndComp
Wire Wire Line
	2400 3850 2100 3850
Wire Wire Line
	2100 3850 2100 5200
Wire Wire Line
	2100 5200 2800 5200
$Comp
L R R?
U 1 1 54BFA36E
P 4400 5550
F 0 "R?" V 4480 5550 40  0000 C CNN
F 1 "R" V 4407 5551 40  0000 C CNN
F 2 "~" V 4330 5550 30  0000 C CNN
F 3 "~" H 4400 5550 30  0000 C CNN
	1    4400 5550
	1    0    0    -1  
$EndComp
Wire Wire Line
	3300 5200 4400 5200
Wire Wire Line
	4400 5200 4550 5200
Wire Wire Line
	4400 5300 4400 5200
Connection ~ 4400 5200
$Comp
L GND #PWR?
U 1 1 54C0E81F
P 4400 6000
F 0 "#PWR?" H 4400 6000 30  0001 C CNN
F 1 "GND" H 4400 5930 30  0001 C CNN
F 2 "" H 4400 6000 60  0000 C CNN
F 3 "" H 4400 6000 60  0000 C CNN
	1    4400 6000
	1    0    0    -1  
$EndComp
Wire Wire Line
	4400 5800 4400 6000
$Comp
L STEPUPDIP3.3V U?
U 1 1 54C0EA34
P 5600 4100
F 0 "U?" H 5600 4000 50  0000 C CNN
F 1 "STEPUPDIP3.3V" H 5600 4400 50  0000 C CNN
F 2 "MODULE" H 5300 3700 50  0001 C CNN
F 3 "DOCUMENTATION" H 6000 3700 50  0001 C CNN
	1    5600 4100
	1    0    0    -1  
$EndComp
Wire Wire Line
	6150 4050 6250 4050
Wire Wire Line
	6250 4050 6250 4150
Wire Wire Line
	6250 4150 6250 4500
Wire Wire Line
	6150 4150 6250 4150
Connection ~ 6250 4150
Wire Wire Line
	6150 3600 6150 3950
Wire Wire Line
	4800 3600 6150 3600
Wire Wire Line
	4950 4150 5050 4150
Wire Wire Line
	4950 3450 4950 3500
Wire Wire Line
	4950 3500 4950 4150
Wire Wire Line
	6150 4250 6350 4250
Wire Wire Line
	6350 4250 6350 3500
Wire Wire Line
	6350 3500 4950 3500
Connection ~ 4950 3500
Wire Wire Line
	5050 4050 5000 4050
Wire Wire Line
	5000 4050 5000 4500
Wire Wire Line
	5000 4500 5000 4850
Wire Wire Line
	6250 4500 5450 4500
Wire Wire Line
	5450 4500 5000 4500
NoConn ~ 5050 4250
Connection ~ 4500 1500
Connection ~ 4200 1500
Wire Wire Line
	4800 3950 5050 3950
Wire Wire Line
	4800 1500 4800 3600
Wire Wire Line
	4800 3600 4800 3950
Connection ~ 4800 3600
Connection ~ 5000 4500
$EndSCHEMATC
