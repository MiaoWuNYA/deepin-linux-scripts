#!/usr/bin/env bash
# 清 log 和 apt 缓存。默认保留 3 天日志。
set -euo pipefail

DAYS="${1:-3}"

echo "== journal =="
journalctl --disk-usage || true
journalctl --vacuum-time="${DAYS}d"

echo "== apt cache =="
du -sh /var/cache/apt/archives 2>/dev/null || true
apt-get clean

echo "== /tmp 里超过 7 天的文件 =="
find /tmp -maxdepth 1 -type f -mtime +7 -print -delete 2>/dev/null | head -20 || true

echo "done."
