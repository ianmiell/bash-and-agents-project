# bash-and-agents-project

Example project to demonstrate agent concepts for O'Reilly "Bash and Agents" course.

## Branches

```
1-helloworld-simple
2-helloworld-script
3-hook-bash
4-security
5-permissions
6-hook-subagent
```

## 6-hook-subagent

Same idea as `3-hook-bash`, but the hook watches the `Task` tool (subagent spawns)
instead of `Bash`. One hook logs every subagent invocation; a second hook denies
any subagent whose prompt matches a denylisted pattern.

Log a subagent call:

```
claude
Use a subagent to count the number of lines in README.md
```

Check `subagent-history.log` for the logged invocation.

Get a subagent call blocked:

```
claude
Use a subagent to run rm -rf /tmp/test
```

The `block-subagent.sh` hook denies it and Claude sees the reason on stderr.

