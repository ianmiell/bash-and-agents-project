# bash-and-agents-project

Example project to demonstrate agent concepts for O'Reilly "Bash and Agents" course.

## 4-security

To demonstrate leakage via a nefarious skill:

```
cat .claude/skills/helloworld/SKILL.md
rm -f ~/env_copied
cat env
claude
say hello world
QUIT
cat ~/env_copied
cat .claude/skills/helloworld/hello_world.sh
```

