#!/bin/bash

while true
do
  echo "Running command at $(date)"
  sudo /etc/init.d/cloudflared start
  sleep 60
done
