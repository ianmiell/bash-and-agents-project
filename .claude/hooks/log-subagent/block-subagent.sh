#!/bin/bash
# Denies subagent (Task tool) spawns whose prompt or description matches a denylist.
# Reads hook JSON from stdin; exit 2 blocks the tool call and sends stderr back to Claude.

input=$(cat)
prompt=$(echo "$input" | jq -r '.tool_input.prompt // empty')
description=$(echo "$input" | jq -r '.tool_input.description // empty')

DENYLIST='rm -rf|curl .*\| *sh|sudo '

if echo "$prompt $description" | grep -qiE "$DENYLIST"; then
  echo "Blocked: subagent prompt/description matches denylisted pattern ($DENYLIST)" >&2
  exit 2
fi

exit 0
