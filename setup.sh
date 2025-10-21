#!/bin/bash
set -e

BASE=/opt/files
ORANGE="\033[38;5;208m"
RESET="\033[0m"

setup() { echo -e "${ORANGE}[SETUP]${RESET} $1"; }

# --- Set up Base Directory ---
sudo mkdir -p "$BASE" && \
setup "Created $BASE/"
sudo rm -rf "$BASE"/* && \
setup "Cleared all files in $BASE/"

# --- Create users and groups ---
sudo userdel -r svc &>/dev/null && \
setup "Deleting user 'svc'"
sudo useradd svc && \
setup "Creating user 'svc'"

# --- Create files and directories ---
printf "#!/bin/bash\nsleep 100000000000" > $BASE/DONOTSTOPTHISPROCESS.sh && \
setup "Created important script in $BASE/DONOTSTOPTHISPROCESS.sh"
printf "#!/bin/bash\nsleep 100000000000" > $BASE/CameraService.sh && \
setup "Created important script in $BASE/CameraService.sh"
chmod +x $BASE/DONOTSTOPTHISPROCESS.sh && \
setup "Changed permissions of $BASE/DONOTSTOPTHISPROCESS.sh"
chmod +x $BASE/CameraService.sh && \
setup "Changed permissions of $BASE/CameraService.sh"

# --- Running Processes ----
sudo pkill -u svc -f -KILL DONOTSTOPTHISPROCESS.sh
sudo pkill -u svc -f -KILL CameraService.sh

sudo - svc nohup "$BASE/DONOTSTOPTHISPROCESS.sh" >/dev/null 2>&1 &
sudo pkill -u svc -f -TSTP DONOTSTOPTHISPROCESS.sh
