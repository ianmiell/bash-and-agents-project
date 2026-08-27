#!/usr/bin/env bash

set -o pipefail

readonly COMMAND_NAME="deploy_app"
readonly DESCRIPTION="Deploy an application"

usage() {
  cat <<'EOF'
Usage:
  deploy_app.sh --environment <dev|test|prod> --version <version> [--dry-run]
  deploy_app.sh --health <dev|test|prod>
  deploy_app.sh --describe
  deploy_app.sh --help

Exit codes:
  0  Success
  1  Missing dependency
  2  Invalid arguments

Example output:
  $ deploy_app.sh --environment test --version 1.2.3
  {
    "ok": true,
    "action": "deploy",
    "application": "app",
    "environment": "test",
    "version": "1.2.3",
    "status": "deployed",
    "dry_run": false,
    "deploy_time": "Fri 31 Jul 2026 15:46:39 BST"
  }

  $ deploy_app.sh --environment test --version 1.2.3 --dry-run
  {
    "ok": true,
    "action": "deploy",
    "application": "app",
    "environment": "test",
    "version": "1.2.3",
    "status": "dry-run",
    "dry_run": true,
    "deploy_time": "Fri 31 Jul 2026 15:46:39 BST"
  }

  $ deploy_app.sh --health test
  {
    "ok": true,
    "action": "health",
    "application": "app",
    "environment": "test",
    "status": "healthy",
    "check_time": "Fri 31 Jul 2026 15:46:39 BST"
  }
EOF
}

require_jq() {
  if ! command -v jq >/dev/null 2>&1; then
    printf '{"ok":false,"error":"jq needs to be installed"}\n' >&2
    exit 1
  fi
}

describe_command() {
  jq -n \
    --arg name "$COMMAND_NAME" \
    --arg description "$DESCRIPTION" \
    '{
        name: $name,
        description: $description,
        arguments: {
          environment: {
            required: false,
            values: ["dev", "test", "prod"]
          },
          version: {
            required: true
          },
          health: {
            required: false,
            values: ["dev", "test", "prod"]
          },
          dry_run: {
            required: false,
            values: [true, false]
          }
        },
        exit_codes: {
          "0": "Success",
          "1": "Missing dependency",
          "2": "Invalid arguments"
        }
     }'
}

argument_error() {
  local message=$1

  jq -n \
    --arg error "$message" \
    '{ok: false, error: $error}' >&2
  exit 2
}

valid_environment() {
  case "$1" in
    dev|test|prod) return 0 ;;
    *) return 1 ;;
  esac
}

deploy_app() {
  local environment=$1
  local version=$2
  local dry_run=$3
  local deploy_time status
  deploy_time=$(date)

  if [[ "$dry_run" == "true" ]]; then
    status="dry-run"
  else
    # Work to actually deploy the app would go here
    status="deployed"
  fi

  jq -n \
    --arg environment "$environment" \
    --arg version "$version" \
    --arg status "$status" \
    --argjson dry_run "$dry_run" \
    --arg deploy_time "$deploy_time" \
    '{
      ok: true,
      action: "deploy",
      application: "app",
      environment: $environment,
      version: $version,
      status: $status,
      dry_run: $dry_run,
      deploy_time: $deploy_time
    }'
}

health_app() {
  local environment=$1
  local check_time
  check_time=$(date)
  jq -n \
    --arg environment "$environment" \
    --arg check_time "$check_time" \
    '{
      ok: true,
      action: "health",
      application: "app",
      environment: $environment,
      status: "healthy",
      check_time: $check_time
    }'
}

main() {
  local environment=""
  local health_environment=""
  local version=""
  local dry_run="false"

  require_jq

  while [[ $# -gt 0 ]]; do
    case "$1" in
      --describe)
        describe_command
        return 0
        ;;
      --help|-h)
        usage
        return 0
        ;;
      --environment|-e)
        [[ $# -ge 2 ]] || argument_error "--environment requires a value"
        environment=$2
        shift 2
        ;;
      --environment=*)
        environment=${1#*=}
        shift
        ;;
      --version|-v)
        [[ $# -ge 2 ]] || argument_error "--version requires a value"
        version=$2
        shift 2
        ;;
      --version=*)
        version=${1#*=}
        shift
        ;;
      --health)
        [[ $# -ge 2 ]] || argument_error "--health requires a value"
        health_environment=$2
        shift 2
        ;;
      --health=*)
        health_environment=${1#*=}
        shift
        ;;
      --dry-run)
        dry_run="true"
        shift
        ;;
      -*)
        argument_error "unknown option: $1"
        ;;
      *)
        if [[ -n "$environment" ]]; then
          argument_error "unexpected argument: $1"
        fi
        environment=$1
        shift
        ;;
    esac
  done

  if [[ -n "$health_environment" ]]; then
    [[ -z "$environment" ]] || argument_error "--health cannot be combined with --environment"
    [[ -z "$version" ]] || argument_error "--health cannot be combined with --version"
    [[ "$dry_run" == "false" ]] || argument_error "--health cannot be combined with --dry-run"
    valid_environment "$health_environment" || argument_error "health environment must be one of: dev, test, prod"
    health_app "$health_environment"
    return 0
  fi

  [[ -n "$environment" ]] || argument_error "environment is required"
  valid_environment "$environment" || argument_error "environment must be one of: dev, test, prod"
  [[ -n "$version" ]] || argument_error "version is required"

  deploy_app "$environment" "$version" "$dry_run"
}

main "$@"
