#!/bin/bash

# Ian : The Archivist
archive_logs() {
    timestamp=$(date +"%Y%m%d_%H%M")
    for file in active_logs/*.log
    do
        base=$(basename "$file" .log)
        mv "$file" "archived_logs/${base}_${timestamp}.log"
        touch "active_logs/${base}.log"
    done
    echo "Logs archived successfully at $timestamp"
}
