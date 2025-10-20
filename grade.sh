#!/bin/bash
set -e

BASE=/opt/files
GREEN="\033[0;32m"
RED="\033[0;31m"
RESET="\033[0m"

pass() { echo -e "${GREEN}[PASSED]${RESET} $1"; }
fail() { echo -e "${RED}[FAILED]${RESET} $1"; }

# 1. Check deployment group ownership and permissions of deploy.sh
if [ "$(stat -c %G $BASE/deploy.sh)" = "deployment" ]; then
   pass "$BASE/deploy.sh is owned by the deployment group"
else
   fail "$BASE/deploy.sh is not owned by the deployment group"
fi

if [ "$(stat -c %A $BASE/deploy.sh | cut -c 7)" = "x" ]; then
   pass "$BASE/deploy.sh is executable by the deployment group"
else
   fail "$BASE/deploy.sh should be executable by the deployment group"
fi

# 2. Create the qa group with the appropriate users
if $(grep -q "^qa:" /etc/group); then
   pass "Group 'qa' exists"
else
   fail "Group 'qa' should be created"
fi

if $(id -Gn john | grep -q "qa"); then
   pass "User john is in group 'qa'"
else
   fail "User 'john' should be a part of group 'qa'"
fi

if $(id -Gn martin | grep -q "qa"); then
   pass "User martin is in group 'qa'"
else
   fail "User 'martin' should be a part of group 'qa'"
fi

# 3. Check for the user tim 
if $(id tim &> /dev/null); then
   pass "User tim exists"
else
   fail "User tim needs to be created"
fi

if $(id -Gn tim 2>/dev/null | grep -q "deployment"); then
   pass "User tim is in group 'deployment'"
else
   fail "User tim should be in group 'deployment'"
fi

# 4. Revoke access to user jack and transfer ownership of files
if $(sudo grep -q '^jack:!' /etc/shadow); then
   pass "User jack is locked out"
else
   fail "User jack should have his password locked"
fi

if [ "$(stat -c %U $BASE/jack)" = "tim" ]; then
   pass "$BASE/jack and all its files are now owned by tim"
else
   fail "$BASE/jack and all its files should be owned by tim"
fi

# 5. Change ownership and permissions for /opt/files/montgomery
if [ "$(stat -c %G $BASE/montgomery)" = "legal" ]; then
   pass "$BASE/montgomery/ and all its files are now owned by the 'legal' group"
else
   fail "$BASE/montgomery/ and all its files should be owned by the 'legal' group"
fi

if [ "$(stat -c %A $BASE/montgomery | cut -c 2-10)" = "r--r-----" ]; then
   pass "$BASE/montgomery/ is ONLY be readable by the user and group that owns it"
else
   fail "$BASE/montgomery/ should ONLY be readable by the user and group that owns it"
fi
