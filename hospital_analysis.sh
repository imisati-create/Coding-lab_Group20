#!/bin/bash
# Hospital Analysis Script

BASE_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
WATER_LOG="$BASE_DIR/active_logs/water_usage.log"

# MIRIAM (Facility Auditor)
water_audit() {
    echo "== Auditing Water Usage =="

    if [ ! -f "$WATER_LOG" ]; then
        echo "No water usage log found yet."
        return
    fi

    grep -o "'WaterUsage': [0-9.]*" "$WATER_LOG" | \
    awk -F': ' '
        {
            sum += $2
            count++
        }
        END {
            if (count > 0) {
                printf "%-25s %10s\n", "Metric", "Value"
                printf "%-25s %10d\n", "Readings analyzed", count
                printf "%-25s %9.2f L\n", "Average usage", sum / count
            } else {
                print "No WaterUsage readings found."
            }
        }
    '
}

water_audit
