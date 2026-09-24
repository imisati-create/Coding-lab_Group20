#!/bin/bash
# Hospital Admin Script

# iAN(The Architect)
initialize_system() {
    echo "Initializing system environment..."

    if [ ! -d "active_logs" ]; then
        echo "Creating active_logs directory..."
        mkdir active_logs
    else
        echo "active_logs directory already exists."
    fi

    if [ ! -d "archived_logs" ]; then
        echo "Creating archived_logs directory..."
        mkdir archived_logs
    else
        echo "archived_logs directory already exists."
    fi

    if [ ! -d "reports" ]; then
        echo "Creating reports directory..."
        mkdir reports
    else
        echo "reports directory already exists."
    fi

    echo "Initialization complete."
}

# BENJAMIN (The Security Lead)
secure_data(){
chmod 700 active_logs
ls -l
}

initialize_system
secure_data
echo "System Environment Secured - $(date)"
