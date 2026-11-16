#!/usr/bin/env bash
# 备份 dotfiles + ~/Documents 到外接盘
# 用法： ./backup-home.sh /media/miaowu/backup
set -euo pipefail

DEST="${1:-}"
[[ -z "$DEST" ]] && { echo "usage: $0 <dest-dir>" >&2; exit 1; }
[[ -d "$DEST" ]] || { echo "no such dir: $DEST" >&2; exit 1; }

EXCLUDES="${HOME}/.cache
${HOME}/.local/share/Trash
${HOME}/.mozilla
${HOME}/snap
${HOME}/node_modules
${HOME}/.npm
${HOME}/.cargo/registry"

EXARG=()
while IFS= read -r line; do
  [[ -n "$line" ]] && EXARG+=("--exclude=$line")
done <<< "$EXCLUDES"

rsync -avh --delete "${EXARG[@]}" \
  "$HOME/.bashrc" "$HOME/.profile" "$HOME/.gitconfig" "$HOME/.ssh/config" \
  "$HOME/Documents/" \
  "$DEST/home-$(date +%Y%m%d)/"

echo "backup -> $DEST/home-$(date +%Y%m%d)"
