bash
#!/bin/bash

# Hospital Analysis Script

BASE_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

WATER_LOG="$BASE_DIR/active_logs/water_usage_log.log"
HEART_RATE_LOG="$BASE_DIR/active_logs/heart_rate_log.log"
TEMPERATURE_LOG="$BASE_DIR/active_logs/temperature_log.log"
REPORT="$BASE_DIR/reports/critical_alerts.txt"

# KEVINE (Clinical Analyst)

process_vitals() {

    echo "== Processing Critical Vitals =="

    mkdir -p "$BASE_DIR/reports"

    > "$REPORT"

    echo "Critical Heart Rate Alerts:" >> "$REPORT"

    if [ -f "$HEART_RATE_LOG" ]; then
        grep "CRITICAL" "$HEART_RATE_LOG" | \
        awk -F'|' '{print $1, $2, $3}' >> "$REPORT"
    fi

    echo "Critical Temperature Alerts:" >> "$REPORT"

    if [ -f "$TEMPERATURE_LOG" ]; then
        grep "CRITICAL" "$TEMPERATURE_LOG" | \
        awk -F'|' '{print $1, $2, $3}' >> "$REPORT"
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

    awk -F'|' '$2 ~ /ICU_WATER_RESERVE/ {
        sum += $3
        count++
    }
    END {
        if (count > 0) {
            printf "%-25s %10s\n", "Metric", "Value"
            printf "%-25s %10d\n", "Readings analyzed", count
            printf "%-25s %9.2f L\n", "Average usage", sum / count
        } else {
            print "No ICU_WATER_RESERVE readings found."
        }
    }' "$WATER_LOG"
}

process_vitals
water_audit
