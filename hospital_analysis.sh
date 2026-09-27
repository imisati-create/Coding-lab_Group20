#!/bin/bash

# Hospital Analysis Script

BASE_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

WATER_LOG="$BASE_DIR/active_logs/water_usage.log"
HEART_RATE_LOG="$BASE_DIR/active_logs/heart_rate.log"
TEMPERATURE_LOG="$BASE_DIR/active_logs/temperature.log"
REPORT="$BASE_DIR/reports/critical_alerts.txt"

# KEVINE (Clinical Analyst)

process_vitals() {

    echo "== Processing Critical Vitals =="

    mkdir -p "$BASE_DIR/reports"

    > "$REPORT"

    echo "Critical Heart Rate Alerts:" >> "$REPORT"

    if [ -f "$HEART_RATE_LOG" ]; then
        grep "CRITICAL" "$HEART_RATE_LOG" | \
        awk '{print $1, $2, $3, $5}' >> "$REPORT"
    fi

    echo "Critical Temperature Alerts:" >> "$REPORT"

    if [ -f "$TEMPERATURE_LOG" ]; then
        grep "CRITICAL" "$TEMPERATURE_LOG" | \
        awk '{print $1, $2, $3, $5}' >> "$REPORT"
    fi

    echo "Critical alerts saved to $REPORT"
}

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

process_vitals
water_audit
