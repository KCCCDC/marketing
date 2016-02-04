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

xda_relay1 = XDAClient(OPCServerAddress=relay1,ReturnErrorText=True)
xda_relay2 = XDAClient(OPCServerAddress=relay2,ReturnErrorText=True)
xda_gen1 = XDAClient(OPCServerAddress=gen1,ReturnErrorText=True)
xda_gen2 = XDAClient(OPCServerAddress=gen2,ReturnErrorText=True)


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

