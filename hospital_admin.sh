#!/bin/bash

# Ian : The Architect
initialize_system() {
    for dir in active_logs archived_logs reports
    do
        if [ ! -d "$dir" ]; then
            echo "Creating $dir directory..."
            mkdir "$dir"
        else
            echo "$dir already exists."
        fi
    done
}

