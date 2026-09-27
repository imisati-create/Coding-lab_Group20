# Coding-lab_Group20 — KNH Hospital Monitoring System

## Overview
This project simulates a hospital monitoring pipeline for Kenyatta National
Hospital (KNH). A Python engine (`hospital_system.py`) generates live
Heart Rate, Temperature, and Water Usage readings and writes them to
`active_logs/`. Shell scripts then secure, analyze, and archive that data.

## Components
| File | Purpose |
|---|---|
| `hospital_system.py` | Data-generating engine. `start` writes readings every 2s to `active_logs/*.log`; `stop` halts the running process via `/tmp/hospital_system.pid`. |
| `hospital_admin.sh` | Creates `active_logs/`, `archived_logs/`, `reports/` and locks down permissions on `active_logs/` (owner-only). |
| `hospital_analysis.sh` | Scans live logs for `CRITICAL` readings and reports on average ICU water usage. |
| `hospital_archive.sh` | Rotates logs from `active_logs/` into timestamped files in `archived_logs/`, then recreates empty active logs. |
| `.gitignore` | Excludes generated log/report data and the PID file from version control (no patient data on GitHub). |

## Log format
Each log line in `active_logs/` is comma-separated:
```
Timestamp,Device_ID,Value,Status



## Running the system
```bash
# 1. Set up directories and permissions
./hospital_admin.sh

# 2. Start the simulator in the background
python3 hospital_system.py start &

# 3. Let it run a while, then analyze live data
./hospital_analysis.sh

# 4. Archive the analyzed logs and roll over fresh ones
./hospital_archive.sh

# 5. Stop the simulator when done
python3 hospital_system.py stop
```

## Group Roles
| Member | Role | Contribution |
|---|---|---|
| iAN | Architect | `initialize_system()` in `hospital_admin.sh` |
| Benjamin | Security Lead | `secure_data()` in `hospital_admin.sh` |
| Ian | Orchestrator | Main execution logic in `hospital_admin.sh` |
| Kevine | Archivist | `hospital_archive.sh` |
| Miriam | Clinical Analyst | `process_vitals()` in `hospital_analysis.sh` |
| Kevine & Miriam | Facility Auditor | `water_audit()` in `hospital_analysis.sh` |

## Data policy
KNH policy forbids uploading real/simulated patient data to GitHub.
`active_logs/`, `archived_logs/`, `reports/`, and the simulator's PID file
are all excluded via `.gitignore`.
