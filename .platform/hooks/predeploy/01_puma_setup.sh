#!/bin/bash
# Create the socket directory
mkdir -p /var/run/puma
chmod 777 /var/run/puma

# Create log directories
mkdir -p /var/log/puma
chmod 777 /var/log/puma