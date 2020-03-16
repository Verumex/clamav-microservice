#!/bin/sh

set -e

freshclam -d
clamd
clamav-unofficial-sigs.sh --upgrade && clamav-unofficial-sigs.sh --force

sh
