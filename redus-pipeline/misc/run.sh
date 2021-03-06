#!/bin/bash

# Function for starting multiple commands
function start {
        echo "$1 $2"
        eval "$1 $2"
        status=$?
        if [ $status -ne 0 ]; then
		echo "Failed to start $1 ($2): $status"
                exit $status
        fi
}

# Function to check and re-run if necessary
function checkrun {
        s1=`ps aux | grep -- "$1" | grep -v -E  "grep|\[*\]" | wc -l`
        if [ $s1 -eq 0 ]; then
                echo "$1 has already exited, re-run."
                start "$1" "$2"
        fi
}

# Init log files
for d in  ~/workspace/projects/*/ ; do
	mkdir -p $d/logs
	touch $d/logs/redus.log
	touch $d/logs/assessment.log
done

LOGS=$(find  ~/workspace/projects/ -type d -mindepth 1 -maxdepth 1 -not -path '*/\.*' -exec echo {}"/logs/*" +)

# Get proxy path
UUID_FILE=~/workspace/projects/id.conf
PROXY_PATH=""
if test -f "${UUID_FILE}"; then
	PROXY_PATH="/id/$(cat ${UUID_FILE})/p"
fi

sed -i "s/%PROXY_PATH%/${PROXY_PATH//\//\\\/}/g" /etc/nginx/conf.d/allrevproxy.conf

# Declare the arrays
declare -a arrcmds=("nginx" "filebrowser" "ttyd" "screen" "frontail")
declare -a arrpars=("" "-b ${PROXY_PATH}/workspace -c /etc/filebrowser.json &" "-p 8002 /bin/bash &" "-dmS primary" "--disable-usage-stats --url-path ${PROXY_PATH}/logs -p 8003 ${LOGS} ~/workspace/projects/*.Rerr ~/workspace/projects/*.Rout &")

# Loop and run the commands

for (( i = 0; i < ${#arrcmds[@]} ; i++ )); do
        start "${arrcmds[$i]}" "${arrpars[$i]}"
done

# Naive check runs in every minute
while sleep 60; do
        # Loop and check the commands
        for (( i = 0; i < ${#arrcmds[@]}; i++ )); do
                checkrun "${arrcmds[$i]}" "${arrpars[$i]}"
        done
done

