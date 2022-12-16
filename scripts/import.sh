#!/bin/bash

# set cwd to project root
cd "${0%/*}/.."

# activate virtualenv
source .venv/bin/activate

ts () {
  echo "$(date "+%Y-%m-%d %H:%M:%S") | "
}

echo "$(ts) Importing babyfeedtimer..."
python scripts/import_babyfeedtimer.py
echo "$(ts) Importing snoo daily..."
python scripts/import_snoo_daily.py
echo "$(ts) Importing snoo sessions..."
python scripts/import_snoo_sessions.py
echo "$(ts) Finished import."
