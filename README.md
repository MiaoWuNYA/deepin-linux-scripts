# deepin-linux-scripts

一堆在 deepin / UOS（统信）上自用的小脚本，边用边攒，主要是把我每次装完系统要手动敲的命令收在一起。

系统环境：deepin 23 / UOS 20（Debian 系），桌面是 DDE，脚本只依赖 bash + 系统自带工具，没装额外依赖。

## 目录

| 脚本 | 作用 |
| --- | --- |
| `scripts/apt-mirror.sh` | 换 apt 源（默认清华，可传参数换别家），换完自动 `apt update` |
| `scripts/dock-autohide.sh` | DDE 任务栏改成「智能隐藏」，顺带把多工作区切换的快捷键修回去 |
| `scripts/clean-journal.sh` | 清 systemd journal 和 /var/cache/apt，只留最近 3 天日志 |
| `scripts/backup-home.sh` | 只备份 dotfiles 和 ~/Documents，用 rsync，支持排除清单 |
| `scripts/swapfile.sh` | 没有 swap 分区的时候建一个 4G swapfile 并写进 fstab |

## 用法

```bash
git clone https://github.com/MiaoWuNYA/deepin-linux-scripts.git
cd deepin-linux-scripts
chmod +x scripts/*.sh
sudo ./scripts/apt-mirror.sh tsinghua
```

## 说明

- 都是我自己机器上跑过的东西，别的发行版不保证能跑。
- `apt-mirror.sh` 会先备份 `/etc/apt/sources.list` 到 `.bak`，出问题可以手动还原。
- `swapfile.sh` 里 btrfs 的情况没处理好，btrfs 根分区上建议别用，会踩到 nocow 的坑。

## License

MIT
