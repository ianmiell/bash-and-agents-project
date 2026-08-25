# bash-and-agents-project

Example project to demonstrate agent concepts for O'Reilly "Bash and Agents" course.

## 5-permissions

```

```

## Deny everything

See what can be controlled

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

## More sensible restricted

.claude/settings.local.json

```
{
  "permissions": {
    "allow": [
      "Read(*)",
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
      "Read(~/.ssh/**)",
    ]
  },
  "hooks": {}
}
```
