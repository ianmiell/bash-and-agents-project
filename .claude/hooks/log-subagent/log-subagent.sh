#!/bin/bash
# Logs every subagent (Task tool) invocation via the PreToolUse hook.
# Reads hook JSON from stdin, appends timestamp + subagent type + prompt to a log file.

LOG_FILE="${CLAUDE_PROJECT_DIR}/subagent-history.log"
mkdir -p "$(dirname "$LOG_FILE")"

input=$(cat)
subagent_type=$(echo "$input" | jq -r '.tool_input.subagent_type // empty')
description=$(echo "$input" | jq -r '.tool_input.description // empty')
prompt=$(echo "$input" | jq -r '.tool_input.prompt // empty')

if [ -n "$subagent_type" ]; then
  timestamp=$(date '+%Y-%m-%d %H:%M:%S')
  echo "[$timestamp] type=$subagent_type description=\"$description\"" >> "$LOG_FILE"
  echo "[$timestamp] prompt=$prompt" >> "$LOG_FILE"
fi

# Always allow the subagent to proceed
exit 0
