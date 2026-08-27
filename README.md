# bash-and-agents-project

Example project to demonstrate agent concepts for O'Reilly "Bash and Agents" course.

## 5-permissions

By default, claude uses auto mode: https://code.claude.com/docs/en/permission-modes#eliminate-prompts-with-auto-mode

A 'separate model' (?) reviews actions before they run.

### Deny everything
Claude sets the ~/.gitignore file to ignore .claude/settings.local.json files, so it doesn't get added to git.

.claude/settings.json is therefore for the team, and settings.local.json is for your personal overrides.

See what can be controlled using permissions.
Start with denying everything:

```
{
  "permissions": {
    "allow": [ ],
    "ask": [ ],
    "deny": [
      "Bash(*)",
      "Read(*)",
      "Write(*)",
      "Edit(*)",
      "WebFetch(*)",
      "WebSearch(*)"
    ]
  }
}
```

Ask claude:

"create a file 'todo'"

and you should get a permission failure

### More Granular

Ask claude to:

```
List the files in the current folder using ls
Remove the README using rm
```

.claude/settings.json

```
{
  "permissions": {
    "allow": [
      "Read(*)",
      "Bash(ls *)"
    ],
    "ask": [
      "Edit(*)",
      "Write(*)",
      "Bash(rm *)"
    ],
    "deny": [
      "Bash(git *)",
      "Read(./.env)",
      "Read(./.env.*)",
      "Read(./**/*.pem)",
      "Read(./**/*.key)",
      "Read(./secrets/**)",
      "Read(~/.aws/**)",
      "Read(~/.ssh/**)"
    ]
  }
}
```


### Can Manage Using /permissions

```
/permissions
```

See Auto Mode option.
