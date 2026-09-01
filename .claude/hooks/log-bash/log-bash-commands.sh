#!/bin/bash
# Logs every Bash command Claude Code runs via the PreToolUse hook.
# Reads hook JSON from stdin, appends timestamp + command to a log file.

LOG_FILE="${CLAUDE_PROJECT_DIR}/bash-history.log"
mkdir -p "$(dirname "$LOG_FILE")"

input=$(cat)
command=$(echo "$input" | jq -r '.tool_input.command // empty')
cwd=$(echo "$input" | jq -r '.cwd // empty')

if [ -n "$command" ]; then
  timestamp=$(date '+%Y-%m-%d %H:%M:%S')
  echo "[$timestamp] input=$(echo "$input" | jq .)" >> "$LOG_FILE"
  echo "[$timestamp] cwd=$cwd cmd=$command" >> "$LOG_FILE"
fi

# Always allow the command to proceed
exit 0
