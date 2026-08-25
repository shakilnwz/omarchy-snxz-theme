#!/usr/bin/env bash
set -euo pipefail

# Since Omarchy 4.0.1, themes cloned by `omarchy theme install <url>` are staged
# without their .lua or terminal configs: those run code at login, so themes
# from a repo someone else wrote are restricted to colors. A symlink to your
# own working copy is explicitly trusted and stages this checkout verbatim.
# Run this script from the checkout to link it into place and apply the theme.

THEME_NAME=snxz
THEME_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
THEME_LINK="$HOME/.config/omarchy/themes/$THEME_NAME"

if ! command -v omarchy >/dev/null 2>&1; then
	printf 'Omarchy is required.\n' >&2
	exit 1
fi

if [[ -L $THEME_LINK ]]; then
	if [[ $(readlink "$THEME_LINK") == "$THEME_DIR" ]]; then
		printf 'Already linked: %s -> %s\n' "$THEME_LINK" "$THEME_DIR"
	else
		printf 'Relinking %s: %s -> %s\n' "$THEME_LINK" "$(readlink "$THEME_LINK")" "$THEME_DIR"
		ln -nsf "$THEME_DIR" "$THEME_LINK"
	fi
elif [[ -e $THEME_LINK ]]; then
	printf '%s already exists and is not a symlink (a clone installed by `omarchy theme install`?).\n' "$THEME_LINK" >&2
	printf 'Move it aside first, e.g.: mv %s %s.old\n' "$THEME_LINK" "$THEME_LINK" >&2
	exit 1
else
	mkdir -p "$(dirname "$THEME_LINK")"
	ln -s "$THEME_DIR" "$THEME_LINK"
fi

# Namespace the theme's bin helpers under ~/.local/bin/snxz as symlinks to
# this checkout: keybinds call them by full path, interactive shells find them
# through $PATH. Never touches files not owned by this theme.
BIN_LINK_DIR="$HOME/.local/bin/snxz"
mkdir -p "$BIN_LINK_DIR"

for script in "$THEME_DIR"/bin/*; do
	name=${script##*/}
	ln -nsf "$script" "$BIN_LINK_DIR/$name"

	bare="$HOME/.local/bin/$name"
	if [[ -L $bare && $(readlink "$bare") == "$THEME_DIR"/bin/* ]]; then
		rm "$bare"
	fi
done

# Manage every shell edit this theme makes between markers in .zshrc: appended
# on first run, replaced in place on re-runs so updates propagate without
# duplicating.
ZSHRC="${ZDOTDIR:-$HOME}/.zshrc"
ALIAS_START='# >>> snxz theme >>>'
ALIAS_END='# <<< snxz theme <<<'

if [[ -f $ZSHRC ]] && grep -qF "$ALIAS_START" "$ZSHRC"; then
	tmp=$(mktemp)
	awk -v s="$ALIAS_START" -v e="$ALIAS_END" '
		index($0, s) { skip = 1; next }
		index($0, e) { skip = 0; next }
		!skip { print }
	' "$ZSHRC" >"$tmp"
	cat "$tmp" >"$ZSHRC"
	rm -f "$tmp"
fi

cat >>"$ZSHRC" <<'SNXZ_BLOCK'

# >>> snxz theme >>>
# Theme bin helpers on $PATH
export PATH="$HOME/.local/bin/snxz:$PATH"

# Custom configuration
alias vi="nvim"
# alias lvim='NVIM_APPNAME="lvim" nvim'
alias kvim='NVIM_APPNAME="kvim" nvim'
# tmux alias
alias ta="tmux attach"
alias hd="herdr"
alias ts='tmux new-session'
# Yazi
alias yz='yazi'
# lazygit
alias lg='lazygit'
# lazydocker
alias ld='lazydocker'
# tmux sessionizer keybind
bindkey -s '^\' 'herdr-sessionizer\n'
# <<< snxz theme <<<
SNXZ_BLOCK

printf 'Shell configuration managed in %s\n' "$ZSHRC"

exec omarchy theme set "$THEME_NAME"
