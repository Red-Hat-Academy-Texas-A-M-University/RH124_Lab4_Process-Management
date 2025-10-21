#!/bin/bash
set -e

BASE=/opt/files
GREEN="\033[0;32m"
RED="\033[0;31m"
RESET="\033[0m"

pass() { echo -e "${GREEN}[PASSED]${RESET} $1"; }
fail() { echo -e "${RED}[FAILED]${RESET} $1"; }

if pgrep -u svc -f "DONOTSTOPTHISPROCESS.sh" >/dev/null; then
	pass "DONOTSTOPTHISPROCESS.sh is running"
else
	fail "DONOTSTOPTHISPROCESS.sh is not running"
fi

if pgrep -u svc -f "CameraService.sh" >/dev/null; then
	pass "CameraService.sh is running"
else
	fail "CameraService.sh is not running"
fi
