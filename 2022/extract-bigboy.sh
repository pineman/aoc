#!/bin/bash
set -euxo pipefail

fd 7z -x sh -c '7z e -so {} > {.}'
