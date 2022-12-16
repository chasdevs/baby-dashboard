#!/bin/bash

set -ex

# set cwd to project root
cd "${0%/*}/.."

# start entr process in background
CMD="ls data/babyfeedtimer/BabyFeedTimer_logs.csv | entr -np bash -c 'echo \"Detected file change.\"; bash scripts/import.sh'"
nohup bash -c "${CMD}" 1> output/nohup.out 2> output/nohup.err &

echo $! > output/nohup_pid.txt
