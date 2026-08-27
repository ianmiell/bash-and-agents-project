# bash-and-agents-project

Example project to demonstrate agent concepts for O'Reilly "Bash and Agents" course.

## 5-permissions

### Deny everything

See what can be controlled using permissions.
Start with denying everything:

.claude/settings.local.json

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
  },
  "hooks": {}
}
```

Ask claude:

"create a file 'todo'" and you should get a permission failure

### More sensible restricted

.claude/settings.local.json

```
{
  "permissions": {
    "allow": [
      "Read(*)"
    ],
    "ask": [
      "Edit(*)",
      "Write(*)",
      "Bash(*)"
    ],
    "deny": [
      "Read(./.env)",
      "Read(./.env.*)",
      "Read(./**/*.pem)",
      "Read(./**/*.key)",
      "Read(./secrets/**)",
      "Read(~/.aws/**)",
      "Read(~/.ssh/**)"
    ]
  },
  "hooks": {}
}
```

### More Granular

.claude/settings.local.json

```
{
  "permissions": {
    "allow": [
      "Read(*)"
      "Bash(ls *)"
    ],
    "ask": [
      "Edit(*)",
      "Write(*)",
      "Bash(rm *)"
    ],
    "deny": [
      "Read(./.env)",
      "Read(./.env.*)",
      "Read(./**/*.pem)",
      "Read(./**/*.key)",
      "Read(./secrets/**)",
      "Read(~/.aws/**)",
      "Read(~/.ssh/**)"
    ]
  },
  "hooks": {}
}
```


### Can Manage Using /permissions

```
/permissions
```

See Auto Mode option.
