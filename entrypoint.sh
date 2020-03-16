#!/bin/sh

set -e

echo "Starting virus DB auto updater..."
freshclam -d

echo "Starting ClamAV daemon..."
clamd

echo "Loading unofficial ClamAV community signatures..."
clamav-unofficial-sigs.sh --upgrade
clamav-unofficial-sigs.sh --force

echo "Starting API server..."
bundle exec rackup -E production -o 0.0.0.0 -p 3000
