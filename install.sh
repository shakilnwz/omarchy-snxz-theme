#!/usr/bin/env bash
set -euo pipefail

# Omarchy owns cloning, updating, and applying user themes. This wrapper is
# useful only when run from a Git checkout; normal users should invoke the
# equivalent `omarchy theme install <repository-url>` command directly.

THEME_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
REPOSITORY_URL="${1:-$(git -C "$THEME_DIR" remote get-url origin 2>/dev/null || true)}"

if ! command -v omarchy >/dev/null 2>&1; then
	printf 'Omarchy is required. Install with: omarchy theme install <repository-url>\n' >&2
	exit 1
fi

if [[ -z $REPOSITORY_URL ]]; then
	printf 'No Git remote found. Usage: %s <repository-url>\n' "$0" >&2
	exit 1
fi

if [[ -n $(git -C "$THEME_DIR" status --porcelain 2>/dev/null) ]]; then
	printf 'Note: Omarchy installs the remote repository, not uncommitted local changes.\n' >&2
fi

exec omarchy theme install "$REPOSITORY_URL"
