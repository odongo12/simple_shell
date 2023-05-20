#!/bin/bash

# Array to store aliases
declare -A aliases

# Function to print all aliases
print_all_aliases() {
  for alias_name in "${!aliases[@]}"; do
    echo "$alias_name='${aliases[$alias_name]}'"
  done
}

# Function to print specific aliases
print_specific_aliases() {
  for alias_name in "$@"; do
    if [[ -n "${aliases[$alias_name]}" ]]; then
      echo "$alias_name='${aliases[$alias_name]}'"
    fi
  done
}

# Function to define new aliases or update existing ones
define_aliases() {
  while [[ $# -gt 0 ]]; do
    alias_definition=$1
    alias_name="${alias_definition%%=*}"
    alias_value="${alias_definition#*=}"

    if [[ -z "$alias_value" ]]; then
      unset aliases["$alias_name"]
    else
      aliases["$alias_name"]="$alias_value"
    fi

    shift
  done
}

# Main function
alias_builtin() {
  if [[ $# -eq 0 ]]; then
    print_all_aliases
  elif [[ $# -eq 1 ]]; then
    print_specific_aliases "$1"
  else
    define_aliases "$@"
  fi
}

# Run the alias command
alias_builtin "$@"

