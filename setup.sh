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
sudo pkill -KILL -u svc || true
sleep 1

# --- Create users and groups ---
sudo userdel -r svc &>/dev/null && \
setup "Deleting user 'svc'"
sudo useradd svc && \
setup "Creating user 'svc'"

# --- Create files and directories ---
printf "#!/bin/bash\nsleep 100000000000" | sudo tee $BASE/DONOTSTOPTHISPROCESS.sh >/dev/null && \
setup "Created important script in $BASE/DONOTSTOPTHISPROCESS.sh"
printf "#!/bin/bash\nsleep 100000000000" | sudo tee $BASE/CameraService.sh >/dev/null && \
setup "Created important script in $BASE/CameraService.sh"
sudo chmod +x $BASE/DONOTSTOPTHISPROCESS.sh && \
setup "Changed permissions of $BASE/DONOTSTOPTHISPROCESS.sh"
sudo chmod +x $BASE/CameraService.sh && \
setup "Changed permissions of $BASE/CameraService.sh"

# --- Running Processes ----
sudo runuser -u svc -- setsid -f "$BASE/DONOTSTOPTHISPROCESS.sh" </dev/null >/dev/null 2>&1
sleep 1
sudo pkill -u svc -f -STOP DONOTSTOPTHISPROCESS.sh && \
setup "Started and stopped $BASE/DONOTSTOPTHISPROCESS.sh as 'svc'"
