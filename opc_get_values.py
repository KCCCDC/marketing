#!/usr/bin/env python
from PyOPC.OPCContainers import *
from PyOPC.XDAClient import XDAClient
from config import paths

def print_options((ilist,options)):
    print ilist; print options; print
    
relay1=paths['relay1']
relay2=paths['relay2']
gen1=paths['gen1']
gen2=paths['gen2']
pump0=paths['pump0']

xda_relay1 = XDAClient(OPCServerAddress=relay1,ReturnErrorText=True)
xda_relay2 = XDAClient(OPCServerAddress=relay2,ReturnErrorText=True)
xda_gen1 = XDAClient(OPCServerAddress=gen1,ReturnErrorText=True)
xda_gen2 = XDAClient(OPCServerAddress=gen2,ReturnErrorText=True)
xda_water = XDAClient(OPCServerAddress=water,ReturnErrorText=True)


print xda_relay1.Read([ItemContainer(ItemName='relay1_breaker')])[0][0].Value
print xda_relay1.Read([ItemContainer(ItemName='relay1_load')])[0][0].Value
print xda_relay1.Read([ItemContainer(ItemName='relay1_flow')])[0][0].Value
print xda_relay2.Read([ItemContainer(ItemName='relay2_breaker')])[0][0].Value
print xda_relay2.Read([ItemContainer(ItemName='relay2_load')])[0][0].Value
print xda_relay2.Read([ItemContainer(ItemName='relay2_flow')])[0][0].Value

print xda_gen1.Read([ItemContainer(ItemName='gen1_breaker')])[0][0].Value
print xda_gen1.Read([ItemContainer(ItemName='gen1_generation')])[0][0].Value
print xda_gen2.Read([ItemContainer(ItemName='gen2_breaker')])[0][0].Value
print xda_gen2.Read([ItemContainer(ItemName='gen2_generation')])[0][0].Value

print xda_pump0.Read([ItemContainer(ItemName='PS0_PUMP_0')])[0][0].Value
print xda_pump0.Read([ItemContainer(ItemName='PS0_PUMP_1')])[0][0].Value
print xda_pump0.Read([ItemContainer(ItemName='PS0_VALVE_0')])[0][0].Value
print xda_pump0.Read([ItemContainer(ItemName='PS0_VALVE_1')])[0][0].Value

print xda_pump1.Read([ItemContainer(ItemName='PS1_PUMP_0')])[0][0].Value
print xda_pump1.Read([ItemContainer(ItemName='PS1_PUMP_1')])[0][0].Value
print xda_pump1.Read([ItemContainer(ItemName='PS1_VALVE_0')])[0][0].Value
print xda_pump1.Read([ItemContainer(ItemName='PS1_VALVE_1')])[0][0].Value

print xda_pump2.Read([ItemContainer(ItemName='PS2_PUMP_0')])[0][0].Value
print xda_pump2.Read([ItemContainer(ItemName='PS2_PUMP_1')])[0][0].Value
print xda_pump2.Read([ItemContainer(ItemName='PS2_VALVE_0')])[0][0].Value
print xda_pump2.Read([ItemContainer(ItemName='PS2_VALVE_1')])[0][0].Value

print xda_pump3.Read([ItemContainer(ItemName='PS3_PUMP_0')])[0][0].Value
print xda_pump3.Read([ItemContainer(ItemName='PS3_PUMP_1')])[0][0].Value
print xda_pump3.Read([ItemContainer(ItemName='PS3_VALVE_0')])[0][0].Value
print xda_pump3.Read([ItemContainer(ItemName='PS3_VALVE_1')])[0][0].Value

print xda_pump4.Read([ItemContainer(ItemName='PS4_PUMP_0')])[0][0].Value
print xda_pump4.Read([ItemContainer(ItemName='PS4_PUMP_1')])[0][0].Value
print xda_pump4.Read([ItemContainer(ItemName='PS4_VALVE_0')])[0][0].Value
print xda_pump4.Read([ItemContainer(ItemName='PS4_VALVE_1')])[0][0].Value

print xda_pump5.Read([ItemContainer(ItemName='PS5_PUMP_0')])[0][0].Value
print xda_pump5.Read([ItemContainer(ItemName='PS5_PUMP_1')])[0][0].Value
print xda_pump5.Read([ItemContainer(ItemName='PS5_VALVE_0')])[0][0].Value
print xda_pump5.Read([ItemContainer(ItemName='PS5_VALVE_1')])[0][0].Value
