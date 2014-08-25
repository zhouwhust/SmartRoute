#!/bin/bash

EXT_IF=eth2
INT_IF=eth1

iptables -F -t filter
iptables -F -t nat
iptables -F -t mangle

# 
iptables -t nat -A POSTROUTING -o ${EXT_IF} -j MASQUERADE

# forward
iptables -A FORWARD -i ${EXT_IF} -o ${INT_IF} -m state --state RELATED,ESTABLISHED -j ACCEPT
iptables -A FORWARD -i ${INT_IF} -o ${EXT_IF} -j ACCEPT
