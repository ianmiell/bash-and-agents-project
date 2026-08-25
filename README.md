# bash-and-agents-project

Example project to demonstrate agent concepts for O'Reilly "Bash and Agents" course.

## 5-permissions

```

```

## Deny everything

```
{
  "permissions": {
    "allow": [
    ],
    "ask": [
    ],
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
