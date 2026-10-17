# bash-and-agents-project

Example project to demonstrate agent concepts for O'Reilly "Bash and Agents" course.

## 6-hook-subagent

Same idea as `3-hook-bash`, but the hook watches the `Task` tool (subagent spawns)
instead of `Bash`. One hook logs every subagent invocation; a second hook denies
any subagent whose prompt matches a denylisted pattern.

Log a subagent call:

```
claude
Use a subagent to count the number of lines in README.md
```

Check `subagent-history.log` for the logged invocation, called via the hook in `.claude/settings.json`.

Get a subagent call blocked using a hook:

```
claude
Use a subagent to run rm -rf /tmp/test
```

The `block-subagent.sh` hook in `.claude/settings.json` denies it and Claude sees the reason on stderr.

