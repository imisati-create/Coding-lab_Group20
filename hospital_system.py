#!/usr/bin/env python3
import sys
import time
import random

# Simulated data generator
def generate_data():
    while True:
        heart_rate = random.randint(60, 100)          # beats per minute
        temperature = round(random.uniform(36.0, 37.5), 1)  # Celsius
        water_usage = round(random.uniform(0.5, 2.0), 2)    # liters/hour

        print({
            "Monitors": {
                "HeartRate": heart_rate,
                "Temperature": temperature,
                "WaterUsage": water_usage
            }
        })
        time.sleep(2)  # wait 2 seconds before next reading

# Entry point
if __name__ == "__main__":
    if len(sys.argv) != 2:
        print("Usage: python3 hospital_system.py [start|stop]")
        sys.exit(1)

    command = sys.argv[1].lower()

    if command == "start":
        print("Starting KNH Data Simulator...")
        try:
            generate_data()
        except KeyboardInterrupt:
            print("\nSimulator stopped manually.")
    elif command == "stop":
        print("Stopping KNH Data Simulator...")
        # In practice, you’d stop the running process with Ctrl+C or kill command
    else:
        print("Unknown command. Use 'start' or 'stop'.")

