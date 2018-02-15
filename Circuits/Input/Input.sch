EESchema Schematic File Version 2
LIBS:favorites
LIBS:ac-dc
LIBS:adc-dac
LIBS:Altera
LIBS:analog_devices
LIBS:analog_switches
LIBS:atmel
LIBS:audio
LIBS:Battery_Management
LIBS:bbd
LIBS:Bosch
LIBS:brooktre
LIBS:Connector
LIBS:contrib
LIBS:cypress
LIBS:dc-dc
LIBS:Decawave
LIBS:device
LIBS:digital-audio
LIBS:Diode
LIBS:Display
LIBS:driver_gate
LIBS:dsp
LIBS:DSP_Microchip_DSPIC33
LIBS:elec-unifil
LIBS:ESD_Protection
LIBS:Espressif
LIBS:ftdi
LIBS:gennum
LIBS:Graphic
LIBS:hc11
LIBS:infineon
LIBS:intel
LIBS:interface
LIBS:intersil
LIBS:ir
LIBS:Lattice
LIBS:LED
LIBS:LEM
LIBS:linear
LIBS:Logic_CMOS_4000
LIBS:Logic_CMOS_IEEE
LIBS:logic_programmable
LIBS:Logic_TTL_IEEE
LIBS:maxim
LIBS:MCU_NXP_Kinetis
LIBS:MCU_NXP_LPC
LIBS:MCU_ST_STM32
LIBS:Mechanical
LIBS:memory
LIBS:microchip
LIBS:microcontrollers
LIBS:modules
LIBS:Motor
LIBS:motor_drivers
LIBS:motorola
LIBS:nordicsemi
LIBS:nxp
LIBS:onsemi
LIBS:opto
LIBS:Oscillators
LIBS:philips
LIBS:power
LIBS:Power_Management
LIBS:powerint
LIBS:pspice
LIBS:references
LIBS:regul
LIBS:Relay
LIBS:RF_Bluetooth
LIBS:rfcom
LIBS:RFSolutions
LIBS:Sensor_Current
LIBS:Sensor_Humidity
LIBS:sensors
LIBS:silabs
LIBS:siliconi
LIBS:supertex
LIBS:Switch
LIBS:texas
LIBS:Transformer
LIBS:Transistor
LIBS:triac_thyristor
LIBS:Valve
LIBS:video
LIBS:wiznet
LIBS:Worldsemi
LIBS:Xicor
LIBS:zetex
LIBS:Zilog
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
L SW_Reed SW1
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
L R R1
U 1 1 54360F12
P 5600 4750
F 0 "R1" V 5680 4750 40  0000 C CNN
F 1 "2M" V 5607 4751 40  0000 C CNN
F 2 "Resistors_SMD:R_0603_HandSoldering" V 5530 4750 30  0001 C CNN
F 3 "~" H 5600 4750 30  0000 C CNN
	1    5600 4750
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
F 2 "favorites:PBCS-75" H 4450 2150 60  0001 C CNN
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
L WRITER-VCC P1
U 1 1 54C9BECD
P 9200 4800
F 0 "P1" V 9300 4800 60  0000 C CNN
F 1 "WRITER-VCC" V 9400 4800 60  0000 C CNN
F 2 "favorites:WRITE-7P" H 9150 4750 60  0001 C CNN
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
$Comp
L R R3
U 1 1 587D4FBE
P 8800 1750
F 0 "R3" V 8880 1750 40  0000 C CNN
F 1 "100k" V 8807 1751 40  0000 C CNN
F 2 "Resistors_SMD:R_0603_HandSoldering" V 8730 1750 30  0001 C CNN
F 3 "~" H 8800 1750 30  0000 C CNN
	1    8800 1750
	0    1    1    0   
$EndComp
$Comp
L Conn_01x02 J1
U 1 1 587D57BC
P 9250 2400
F 0 "J1" H 9450 2450 50  0000 L CNN
F 1 "sensor" H 9450 2350 50  0000 L CNN
F 2 "Connect:PINHEAD1-2" H 9450 2500 50  0000 C CNN
F 3 "" H 9250 2400 50  0000 C CNN
	1    9250 2400
	1    0    0    -1  
$EndComp
$Comp
L R R2
U 1 1 5A82DDEB
P 9050 3050
F 0 "R2" V 9130 3050 40  0000 C CNN
F 1 "100k" V 9057 3051 40  0000 C CNN
F 2 "Resistors_SMD:R_0603_HandSoldering" V 8980 3050 30  0001 C CNN
F 3 "~" H 9050 3050 30  0000 C CNN
	1    9050 3050
	1    0    0    -1  
$EndComp
$Comp
L C_Small C1
U 1 1 5A845ABD
P 8350 3600
F 0 "C1" H 8360 3670 50  0000 L CNN
F 1 "1uF" H 8360 3520 50  0000 L CNN
F 2 "Capacitors_SMD:C_0805_HandSoldering" H 8350 3600 50  0001 C CNN
F 3 "" H 8350 3600 50  0001 C CNN
	1    8350 3600
	1    0    0    -1  
$EndComp
Wire Wire Line
	9050 1650 6000 1650
Wire Wire Line
	6000 1650 6000 3150
Connection ~ 5900 1750
Connection ~ 8500 1750
Wire Wire Line
	9050 2500 9050 2900
Wire Wire Line
	8050 2700 9050 2700
Connection ~ 5150 3050
Wire Wire Line
	5150 3050 6550 3050
Connection ~ 4450 1750
Wire Wire Line
	4450 2550 5150 2550
Connection ~ 4450 2550
Wire Wire Line
	4450 2450 4450 2700
Wire Wire Line
	4450 1600 4450 1850
Wire Wire Line
	5900 1750 5900 3250
Wire Wire Line
	4950 5000 8800 5000
Wire Wire Line
	6200 4900 8800 4900
Wire Wire Line
	6300 4700 8800 4700
Wire Wire Line
	6100 5100 8800 5100
Wire Wire Line
	8500 4500 8800 4500
Wire Wire Line
	8500 1750 8500 4500
Wire Wire Line
	4450 1750 8650 1750
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
	8100 3400 8100 5000
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
	8050 3800 8350 3800
Wire Wire Line
	8200 3150 8200 4800
Wire Wire Line
	6100 2200 6100 5100
Wire Wire Line
	5600 3750 5600 3400
Wire Wire Line
	5600 3400 6550 3400
Wire Wire Line
	5900 3250 6550 3250
Wire Wire Line
	6550 2200 6100 2200
Wire Wire Line
	5600 5000 5600 4900
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
	5150 2550 5150 5000
Connection ~ 5150 5000
Wire Wire Line
	6000 3150 6550 3150
Wire Wire Line
	6550 2950 5150 2950
Connection ~ 5150 2950
Wire Wire Line
	5600 4150 5600 4600
Connection ~ 9050 2700
Wire Wire Line
	5600 4500 6800 4500
Wire Wire Line
	6800 4500 6800 4000
Wire Wire Line
	6800 4000 9050 4000
Wire Wire Line
	9050 4000 9050 3200
Connection ~ 5600 4500
Wire Wire Line
	8350 3800 8350 3700
Wire Wire Line
	8350 3500 8350 3400
Wire Wire Line
	8350 3400 8500 3400
Connection ~ 8500 3400
Wire Wire Line
	8950 1750 9050 1750
Connection ~ 9050 1750
Wire Wire Line
	9050 2400 9050 1650
$EndSCHEMATC
