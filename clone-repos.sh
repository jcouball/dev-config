#!/bin/sh
#
# Clone the three config repos into this directory.
#
#   ./clone-repos.sh
#
# A repo whose directory is already here is not cloned again: nothing in an
# existing clone is fetched or checked out. Run it again at any time to get
# the ones that are missing.
#
# One setting is made in every clone, new or not. A repo with a .githooks
# directory has git hooks that stop a commit on main or stable, and git runs
# them only in a clone whose core.hooksPath names the directory. Run this
# again after a repo gains the directory.

set -eu

cd "$(dirname "$0")"

status=0
for repo in mac-dev-config ubuntu-dev-config windows-dev-config; do
  if [ -e "$repo" ]; then
    echo ">> $repo is already here; not cloned again."
  else
    echo ">> Cloning $repo..."
    git clone "https://github.com/jcouball/$repo.git" "$repo" || { status=1; continue; }
  fi

  if [ -d "$repo/.githooks" ] \
     && [ "$(git -C "$repo" config --local --get core.hooksPath || true)" != ".githooks" ]; then
    echo ">> Setting core.hooksPath to .githooks in $repo"
    git -C "$repo" config --local core.hooksPath .githooks || status=1
  fi
done

exit "$status"
