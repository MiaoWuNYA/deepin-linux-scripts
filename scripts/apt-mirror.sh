#!/usr/bin/env bash
# 换 apt 源。用法： sudo ./apt-mirror.sh [tsinghua|aliyun|ustc|official]
set -euo pipefail

MIRROR="${1:-tsinghua}"
CODENAME="$(. /etc/os-release && echo "${VERSION_CODENAME:-apricot}")"
BACKUP="/etc/apt/sources.list.bak.$(date +%Y%m%d%H%M%S)"

case "$MIRROR" in
  tsinghua) HOST="https://mirrors.tuna.tsinghua.edu.cn/debian" ;;
  aliyun)   HOST="https://mirrors.aliyun.com/debian" ;;
  ustc)     HOST="https://mirrors.ustc.edu.cn/debian" ;;
  official) HOST="http://deb.debian.org/debian" ;;
  *) echo "unknown mirror: $MIRROR" >&2; exit 1 ;;
esac

[[ -f /etc/apt/sources.list ]] && cp /etc/apt/sources.list "$BACKUP"

cat > /etc/apt/sources.list <<EOF
deb $HOST $CODENAME main contrib non-free
deb $HOST $CODENAME-updates main contrib non-free
deb $HOST-security $CODENAME/updates main contrib non-free
deb $HOST $CODENAME-backports main contrib non-free
EOF

echo "sources.list 已切到 $MIRROR，备份在 $BACKUP"
apt-get update
