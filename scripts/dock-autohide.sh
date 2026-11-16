#!/usr/bin/env bash
# DDE 任务栏改智能隐藏，并修复工作区快捷键
set -euo pipefail

DCONF="gsettings"

# 任务栏位置：bottom / top / left / right
$DCONF set com.deepin.dde.dock.mainwindow hide-mode "$(printf 'uint32 %d' 1)"

# 关闭「开机自动隐藏」以外的多余动画
$DCONF set com.deepin.dde.dock.mainwindow show-in-primary true

# 工作区切换：把 Super+方向 键恢复成 Ctrl+Alt+方向
$DCONF set com.deepin.dde.keybinding.mediakey left ""
for i in 1 2 3 4; do
  $DCONF set "com.deepin.wrap.gnome.desktop.wm.keybindings" switch-to-workspace-$i "['<Control><Alt>$i']" 2>/dev/null || true
done

echo "done. 如果任务栏没变，注销重进一次 DDE。"
