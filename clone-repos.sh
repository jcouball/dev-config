#!/bin/sh
#
# Clone the three config repos into this directory.
#
#   ./clone-repos.sh
#
# A repo whose directory is already here is skipped: nothing in an existing
# clone is fetched, checked out or changed. Run it again at any time to get
# the ones that are missing.

set -eu

cd "$(dirname "$0")"

status=0
for repo in mac-dev-config ubuntu-dev-config windows-dev-config; do
  if [ -e "$repo" ]; then
    echo ">> $repo is already here; left as it is."
  else
    echo ">> Cloning $repo..."
    git clone "https://github.com/jcouball/$repo.git" "$repo" || status=1
  fi
done

exit "$status"
