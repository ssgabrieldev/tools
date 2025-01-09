#!/bin/bash

while true; do
  cat /sys/class/thermal/thermal_zone*/temp
  sleep 1
done
