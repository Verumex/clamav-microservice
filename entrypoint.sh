#!/bin/sh

# TODO: Re-enable this 'break on first error' line. The virus signature mirrors
# sometimes return non-existent signature files due to... well.. it's free and
# probably misconfigured somehow.
# set -e

echo "Starting virus DB auto updater..."
freshclam -d

echo "Starting ClamAV daemon..."
clamd

echo "Loading unofficial ClamAV community signatures..."
clamav-unofficial-sigs.sh --upgrade
clamav-unofficial-sigs.sh --force

echo "Starting API server..."
bundle exec rackup -E production -o 0.0.0.0 -p 3000
