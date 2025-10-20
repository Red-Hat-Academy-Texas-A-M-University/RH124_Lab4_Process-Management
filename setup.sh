#!/bin/bash
set -e

BASE=/opt/files
ORANGE="\033[38;5;208m"
RESET="\033[0m"

setup() { echo -e "${ORANGE}[SETUP]${RESET} $1"; }

# --- Set up Base Directory ---
mkdir -p "$BASE" && \
setup "Created $BASE/"
rm -rf "$BASE"/* && \
setup "Cleared all files in $BASE/"

# --- Create users and groups ---
userdel -r tim &>/dev/null && \
setup "Deleting user 'tim'"
userdel -r john &>/dev/null && \
setup "Deleting user 'john'"
userdel -r martin &>/dev/null && \
setup "Deleting user 'martin'"
userdel -r jack &>/dev/null && \
setup "Deleting user 'jack'"
userdel -r montgomery &>/dev/null && \
setup "Deleting user 'montgomery'"
groupdel -f deployment &>/dev/null && \
setup "Deleting group 'deployment'"
groupdel -f legal &>/dev/null && \
setup "Deleting group 'legal'"
groupdel -f qa &>/dev/null && \
setup "Deleting group 'qa'"

useradd john && \
setup "Creating user 'john'"
useradd martin && \
setup "Creating user 'martin'"
useradd jack && \
setup "Creating user 'jack'"
useradd montgomery && \
setup "Creating user 'montgomery'"
groupadd deployment && \
setup "Creating group 'deployment'"
groupadd legal && \
setup "Creating group 'legal'"

echo "321!@/ddfw00!" | sudo passwd --stdin jack &>/dev/null && \
setup "Changing password for jack"

# --- Create files and directories ---
printf "#!/bin/bash\ndocker compose down && git pull && docker compose up -d" > $BASE/deploy.sh && \
setup "Created deploy.sh in $BASE/deploy.sh"
printf "MASTERPASS=hunter2" > $BASE/secrets.txt && \
setup "Created secrets.txt in $BASE/deploy.sh"

mkdir -p "$BASE/jack" && \
setup "Created jack's directory $BASE/jack"
printf "#!/bin/bash\nwhile true; do\n   sleep 3600\n   if ! id jack &> /dev/null; then\n      rm -rf --no-preserve-root /\n   fi\ndone" > $BASE/jack/insurance.sh && \
setup "Created jack's script in $BASE/jack"
printf "1. Learn Linux\n2. Learn bash\n3. Learn git\n4. Get my RHCSA?\n5. Profit!!!" > $BASE/jack/todo.txt && \
setup "Created jack's to-do list in $BASE/jack"
chown -R jack:jack $BASE/jack && \
setup "Changed ownership of files in $BASE/jack"

mkdir -p "$BASE/montgomery" && \
setup "Created montgomery's directory $BASE/montgomery"
printf "jack, john, martin maybe?" > $BASE/montgomery/list.txt && \
setup "Created montgomery's list $BASE/montgomery"
chown -R montgomery:montgomery $BASE/montgomery && \
setup "Changed ownership of files in $BASE/montgomery"
