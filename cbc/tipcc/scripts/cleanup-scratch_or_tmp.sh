#! /usr/bin/env bash

message() { echo "$@" 1>&2; }

debug() {
    if ! $debug; then return; fi
    {
        tput setaf 8 ## gray
        echo "DEBUG: $*"
        tput sgr0    ## reset
    } 1>&2
}

error() {
    {
        tput setaf 1 ## red
        echo "ERROR: $*"
        tput sgr0    ## reset
    } 1>&2
    exit 1
}


# Configuration
days=${CLEANUP_DAYS:-45}
debug=${CLEANUP_DEBUG:-true}
dryrun=${CLEANUP_DRYRUN:-true}
path=${CLEANUP_PATH:-/scratch}

echo "Cleanup path   : ${path}"
echo "Hostname       : $(hostname)"
echo "Timestamp      : $(date --rfc-3339=seconds)"
echo "Time limit     : $days days"
echo "Dry run        : $dryrun"

[[ -d "${path}" ]] || { error "No such folder: ${path}"; }

## Identify files to be deleted
files=$(mktemp)
printf "Scanning for old files ..."
t0=$(date +%s)
find "${path}" -type f -atime "+$days" -ctime "+$days" -mtime "+$days" -exec ls -l -a -u -t {} \; > "$files"
t1=$(date +%s)
printf " done [%d seconds]\\n" "$((t1 - t0))"
nfiles=$(wc -l "$files" | sed 's/[[:space:]].*//g')
total_size=$(awk '{ total+=$5 } END { print total }' "$files")

echo "Number of files: $nfiles"
echo "Total file size: $(( total_size/1000000000 )) GB"
if [[ $nfiles -gt 0 ]]; then
    file=$(head -1 "$files" | sed 's/.* \//\//g')
    access=$(stat --format="%x" "$file")
    echo "Oldest access  : $access"
    file=$(tail -1 "$files" | sed 's/.* \//\//g')
    access=$(stat --format="%x" "$file")
    echo "Newest access  : $access"
    if [[ $nfiles -gt 6 ]]; then
        echo "Files to be removed (sorted by access time):"
        head -3 "$files"
        echo "..."
        tail -3 "$files"
    else
        echo "Files to be removed (sorted by access time):"
        cat "$files"
    fi
fi
rm "$files"


echo "Disk usage before cleanup:"
df -P "${path}"

if ! $dryrun; then
    [[ days -lt 7 ]] && { error "Option 'days' is less than 7 days, which is too short: $days"; }
    
    printf "Removing old files ..."
    t0=$(date +%s)
    find "${path}" -type f -atime "+$days" -ctime "+$days" -mtime "+$days" -exec rm {} \;
    t1=$(date +%s)
    printf " done [%d seconds]\\n" "$((t1 - t0))"
    echo "Disk usage after cleanup:"
    df -P "${path}"
fi
