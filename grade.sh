#!/bin/bash
set -e

BASE=/opt/files
GREEN="\033[0;32m"
RED="\033[0;31m"
RESET="\033[0m"

pass() { echo -e "${GREEN}[PASSED]${RESET} $1"; }
fail() { echo -e "${RED}[FAILED]${RESET} $1"; }

DONOT_PIDS=$(pgrep -u svc -f "DONOTSTOPTHISPROCESS.sh" || true)
if [ -n "$DONOT_PIDS" ] && ! ps -o stat= -p $DONOT_PIDS | grep -q T; then
	pass "DONOTSTOPTHISPROCESS.sh is running"
elif [ -n "$DONOT_PIDS" ]; then
	fail "DONOTSTOPTHISPROCESS.sh is still stopped"
else
	fail "DONOTSTOPTHISPROCESS.sh is not running"
fi

if pgrep -u svc -f "CameraService.sh" >/dev/null; then
	pass "CameraService.sh is running"
else
	fail "CameraService.sh is not running"
fi
