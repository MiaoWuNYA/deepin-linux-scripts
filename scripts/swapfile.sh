#!/usr/bin/env bash
# 没有 swap 分区时建一个 swapfile
set -euo pipefail

SIZE="${1:-4G}"
SWAPFILE=/swapfile

if swapon --show | grep -q .; then
  echo "已经有 swap 了："
  swapon --show
  exit 0
fi

if [[ -f "$SWAPFILE" ]]; then
  echo "$SWAPFILE 已存在，先手动删掉再来" >&2
  exit 1
fi

fallocate -l "$SIZE" "$SWAPFILE" || dd if=/dev/zero of="$SWAPFILE" bs=1M count="${SIZE%G}024" status=progress
chmod 600 "$SWAPFILE"
mkswap "$SWAPFILE"
swapon "$SWAPFILE"

grep -q "^$SWAPFILE" /etc/fstab || echo "$SWAPFILE none swap sw 0 0" >> /etc/fstab
echo "swap 已启用：$SIZE"
