#!/bin/bash

set -Eeuo pipefail

# OPTIONS =====

DATE_STAMP="$(date '+%Y-%m-%d %H:%M')"
REPO_DIR="$(dirname "$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)")"
# DEST_DIR="$HOME"
DEST_DIR="$HOME/Projects/SampleSpace"
LOG_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)/ScriptLogs"
LOG_FILE="$LOG_DIR/dots-bisync-$DATE_STAMP.log"
FILTER_FILE="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)/rclone-filter.txt"


# Initialization ======

exec 9>"$LOG_DIR/dots-bisync.lock"

if ! flock -n 9; then
    notify-send -a "Dots Bisync" -u critical "Another bisync process is already running." "Please check the process in $LOG_DIR"
    exit 1
fi

# Log all output
exec > >(tee -a "$LOG_FILE") 2>&1

log() {
    echo "$*"
}

die() {
    log "ERROR: $*"
    exit 1
}


# Help Section =====
usage() {
    cat <<EOF
Usage: $0 [OPTIONS]

Options:
  --check       Preview changes without syncing
  --resync      Rebuild bisync baseline
  --help        Show this help

Examples:
  $0 --dry-run
  $0
  $0 --resync
EOF
}

RESYNC=""
DRY_RUN=""

while [[ $# -gt 0 ]]; do
    case "$1" in
         --dry-run)
            DRY_RUN="--dry-run"
            ;;
        --resync)
            RESYNC="--resync"
            ;;       
        --help|-h)
            usage
            exit 0
            ;;
        *)
            die "Unknown argument: $1"
            ;;
    esac
    shift
done

# Validating =====
command -v rclone >/dev/null 2>&1 || die "rclone not installed"
command -v flock >/dev/null 2>&1 || die "flock not installed"

[[ -d "$REPO_DIR" ]] || die "Repository does not exist: $REPO_DIR"
[[ -d "$DEST_DIR" ]] || die "Destination directory does not exist: $DEST_DIR"
[[ -f "$FILTER_FILE" ]] || die "Filter file missing: $FILTER_FILE"

[[ "$REPO_DIR" != "$DEST_DIR" ]] || die "Repository and destination cannot be identical"

notify-send -a "Dots Bisync" -u low "Starting Dots Bisync" "Please check the process in $LOG_DIR"

log ""
log "=========================================="
log "Starting rclone bisync"
log "Repository: $REPO_DIR"
log "Destination: $DEST_DIR"
log "Filter: $FILTER_FILE"
log "=========================================="
log ""

# Arguments =====

# BSYNC_ARGS="--include-from $FILTER_FILE \
#   --log $LOG_FILE \
#   --log-file-max-size 1M \
#   --log-file-max-backups 3 \
#   --log-level INFO \
#   --conflict-resolve newer \
#   --conflict-loser delete \
#   --create-empty-src-dir \
#   --compare size,modtime \
#   --slow-hash-sync-only \
#   --M \
#   --fix-case \
#   --resilient"

BSYNC_ARGS=(--include-from "$FILTER_FILE"
  --conflict-resolve newer
  --conflict-loser delete
  --create-empty-src-dirs
  --compare size,modtime
  --slow-hash-sync-only
  -Mv
  --fix-case
  --resilient)

# Syncing ======

log "Starting synchronization..."
log ""

if rclone bisync "$DEST_DIR" "$REPO_DIR" "${BSYNC_ARGS[@]}" $RESYNC $DRY_RUN; then
    log "Synchronization completed successfully."
else
    STATUS=$?
    log "Synchronization FAILED with exit code $STATUS"
    exit "$STATUS"
fi

# Original Command
# rclone bisync "$DEST_DIR" "$REPO_DIR" "${BSYNC_ARGS[@]}" $RESYNC $DRY_RUN


# Log File Cleaning =====

log "Cleaning log files..."

ls -1t "$LOG_DIR"/dots-bisync-*.log 2>/dev/null |
    tail -n +4 |
    while IFS= read -r file; do
        rm -f -- "$file"
    done

# Testing =====
echo ""
echo $REPO_DIR
echo $DEST_DIR
echo $LOG_FILE
echo $FILTER_FILE
