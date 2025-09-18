#!/usr/bin/env bash

set -euo pipefail

: "${USE_PIPX:=true}"
: "${USE_GO:=false}"

if ! [[ $PATH =~ (^|:)"${HOME}/.local/bin"(:|$) ]]; then
  # shellcheck disable=SC2088
  echo '~/.local/bin is not on PATH; aborting...'
  exit 1
fi

if [ "$USE_GO" = true ]; then
  go install gitlab.com/ribtoks/tdg/cmd/tdg@v0.0.7-1
  go install github.com/rhysd/actionlint/cmd/actionlint@v1.7.3
fi

pip_cmd=pip3
if [[ $USE_PIPX == true ]]; then
  (
    export PIP_REQUIRE_VIRTUALENV=false
    export PIP_BREAK_SYSTEM_PACKAGES=1
    pip3 install --user pipx
  )
  pip_cmd=pipx
fi

$pip_cmd install 'pre-commit==3.3.3'
$pip_cmd install 'yamllint==1.32.0'
$pip_cmd install 'codespell==2.3.0'
