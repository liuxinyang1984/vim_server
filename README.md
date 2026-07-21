# vim_server — 纯 Vim 配置（CentOS 7 / 老版本 Vim & Neovim）

SSH 服务器用的 **纯 Vimscript** 配置，经 [vim-plug](https://github.com/junegunn/vim-plug) 管理插件。

- **无** coc / Node / Lua / LSP
- 支持 **Vim 7.4+** 与 **Neovim 0.3+**（同一套 `vimrc`）
- 主要编辑：PHP、Go、bash、配置文件

仓库地址：<https://github.com/liuxinyang1984/vim_server.git>

---

## 要求

| 项目 | 说明 |
|------|------|
| Vim | 7.4+，推荐 **`vim-enhanced`**（`vim --version` 含 `+syntax`、**`+python` 或 `+python3`**） |
| Neovim | 0.3+（可选；须编译带 Python 才支持 LeaderF，否则用 Vim） |
| Git / curl | 在线安装时 clone 配置、bootstrap vim-plug |
| Python | LeaderF 依赖（CentOS 7 `+python` / Py2.7；插件钉 **v1.25**） |
| ripgrep | `fr` 全局搜索需 `rg`（EPEL 或本机安装） |
| gcc / python-devel | LeaderF C 扩展编译（可选，加速 `ff`/`fr`） |

---

## 安装（/opt，root 维护）

### 1. 在线安装（服务器能访问 GitHub）

```bash
git clone https://github.com/liuxinyang1984/vim_server.git /opt/vim-config

vim -u /opt/vim-config/vimrc -es +PlugInstall +qa

chown -R root:root /opt/vim-config
chmod -R a+rX /opt/vim-config
chmod -R go-w /opt/vim-config
```

插件安装到 `/opt/vim-config/plugged/`（不提交 Git）。

### 2. 离线安装（服务器不能访问 Git）

在本机 clone 并安装插件后，**整目录 rsync** 到服务器（保留 `plugged/*/.git`，便于在线时 `PlugUpdate`）：

```bash
# 本机
cd /path/to/vim_server
vim -u vimrc -es +PlugUpdate +qa

rsync -avz --progress --exclude '.git' \
  /path/to/vim_server/ \
  root@服务器:/opt/vim-config/
```

服务器上设置权限（同上 `chown` / `chmod`）。

**不要**在插件目录已 rsync 上去后再跑 `:PlugInstall`（会报 `already exists`）；离线环境直接用即可，用 `:PlugStatus` 检查。

### 3. 更新配置

**在线（服务器能访问 GitHub）：**

```bash
cd /opt/vim-config
git pull
vim -u /opt/vim-config/vimrc -es +PlugUpdate +qa
```

新增插件且 `plugged/` 里尚无该目录时，才用 `:PlugInstall`。

**离线：** 在本机 `git pull` + `PlugUpdate` 后，重新 rsync 整包：

```bash
rsync -avz --progress --exclude '.git' \
  /path/to/vim_server/ \
  root@服务器:/opt/vim-config/
```

---

## 用户初始化

配置统一部署在 `/opt/vim-config/`，用户只需让编辑器加载 `/opt/vim-config/vimrc`。

### Vim

**方式 A：写 `~/.vimrc`（推荐，日常直接用 `vim`）**

不要用 `ln -sf` 软链到 `/opt/vim-config/vimrc`（Vim 7.4 会把配置目录解析成 `$HOME`，导致 `E484`）。

```bash
cat > ~/.vimrc <<'EOF'
source /opt/vim-config/vimrc
EOF

vim
```

**方式 B：不改动 `~/.vimrc`**

```bash
vim -u /opt/vim-config/vimrc
```

或写入 shell 别名：

```bash
alias vim='vim -u /opt/vim-config/vimrc'
```

### Neovim（0.3+）

Neovim **不会**自动读 `~/.vimrc`，需要单独配置。

**方式 A：写 `init.vim`（推荐，日常直接用 `nvim`）**

```bash
mkdir -p ~/.config/nvim

cat > ~/.config/nvim/init.vim <<'EOF'
source /opt/vim-config/vimrc
EOF

nvim
```

**方式 B：不改动 `~/.config/nvim/`**

```bash
nvim -u /opt/vim-config/vimrc
```

或写入 shell 别名：

```bash
alias nvim='nvim -u /opt/vim-config/vimrc'
```

### Vim 与 Neovim 同时使用

```bash
# Vim
cat > ~/.vimrc <<'EOF'
source /opt/vim-config/vimrc
EOF

# Neovim
mkdir -p ~/.config/nvim
echo 'source /opt/vim-config/vimrc' > ~/.config/nvim/init.vim
```

之后：

```bash
vim    # ~/.vimrc → source /opt/vim-config/vimrc
nvim   # ~/.config/nvim/init.vim → source /opt/vim-config/vimrc
```

### 验证

```bash
vim -u /opt/vim-config/vimrc -c 'echo g:vim_config_dir' -c 'qa'
nvim -u /opt/vim-config/vimrc -c 'echo g:vim_config_dir' -c 'qa'
```

两行都应输出 `/opt/vim-config`。

手测：gruvbox、airline、`tt` → `l` 开文件、`ff`/`fr`、Insert 输入 `(` 自动补 `)`、`<C-s>`、`:q`。

---

## 目录结构

```text
/opt/vim-config/
├── vimrc                    # 入口，source vim/*.vim
├── autoload/
│   └── plug.vim             # vim-plug（首次可 curl bootstrap）
├── plugged/                 # .gitignore，PlugInstall 目录
└── vim/
    ├── plugin-manager.vim   # vim-plug + Plug 列表 + NERDTree 键位变量
    ├── settings.vim         # set / leader
    ├── after-plugin.vim     # 插件 g: 配置
    ├── maps.vim             # 键位
    └── autocmds.vim         # 自动命令
```

**约定：** 新增插件只改 `vim/plugin-manager.vim`；插件 `g:` 选项写 `after-plugin.vim`。

---

## 插件列表

| 插件 | 用途 |
|------|------|
| gruvbox | 配色 |
| vim-airline | 状态栏 |
| vim-airline-themes | airline 主题 |
| nerdtree | 文件树（`tt`；树内 `h`/`l`） |
| vim-surround | 包围编辑（`ys`/`cs`/`ds` 等） |
| nerdcommenter | 注释（`<C-/>`） |
| vim-table-mode | Markdown 表格（`<Space>t` 前缀） |
| suda.vim | `:Sw` sudo 保存 |
| wildfire | Normal `<Enter>` 扩大选区（括号/引号内） |
| auto-pairs | Insert 自动补全括号、引号 |
| indentLine | 缩进竖线 |
| LeaderF | `ff` / `fr` / `fb` / `fm` 模糊搜索 |
| rainbow | 彩虹括号 |
| vim-peekaboo | `"` / `@` 寄存器预览 |

共 **14** 个插件。

## 键位

### 文件树（NERDTree）

| 键 | 功能 |
|----|------|
| `tt` | 开关文件树 |
| `l` | 目录展开 / 文件打开（右侧，打开后关树） |
| `h` | 折叠父目录 |
| `j` / `k` | 上下移动 |

### 搜索与导航

| 键 | 功能 |
|----|------|
| `ff` | LeaderF 找文件 |
| `fr` | LeaderF ripgrep 搜索 |
| `fb` | LeaderF buffer |
| `fm` | LeaderF 最近文件 |
| `<Enter>`（Normal） | wildfire 扩大选区 |
| `"` / `@` | peekaboo 寄存器预览 |

### 编辑

| 键 | 功能 |
|----|------|
| Insert `(`, `[`, `{`, `'`, `"` | auto-pairs 自动补闭合；输入闭合符可跳过（FlyMode） |
| `<C-s>` / `<C-q>` | 保存 / 退出 |
| `<C-/>` | 注释（Normal / Visual） |
| `:Sw` / `:sw` | sudo 写入 |
| `ddd` / `dddd`（Insert） | 插入日期 / 日期时间 |

### 窗口与标签

| 键 | 功能 |
|----|------|
| `wh` / `wj` / `wk` / `wl` | 窗口间移动 |
| `<A-h>` / `<A-j>` / `<A-k>` / `<A-l>` | 窗口间移动（Alt） |
| `<A-H>` / `<A-J>` / `<A-K>` / `<A-L>` | 调窗口宽/高（±5） |
| `sl` / `sh` / `sj` / `sk` | 分屏（右/左/下/上） |
| `tn` / `th` / `tl` / `tk` / `tj` | 标签页 |

### 其他

| 键 | 功能 |
|----|------|
| `J` / `K` | 上下 5 行（Normal / Visual） |
| `<Esc>` | 取消搜索高亮 |
| `<Space>tm` / `tr` / `ti` | table-mode 开关 / 对齐 / 表格化 |
| Insert `<C-h/j/k/l>` | 方向键 |

---

## LeaderF 补充

LeaderF 钉在 **`v1.25`**，兼容 CentOS 7 `vim-enhanced` 的 **`+python`（Python 2.7）**；新版 LeaderF 需 Python 3，勿随意去掉 tag。

LeaderF **依赖** Vim 编译时带 Python（`vim --version | grep python` 有 `+python`）。CentOS 7 推荐：

```bash
yum install -y vim-enhanced
/usr/bin/vim --version | grep -i python
```

不要用无 Python 的 nvim 冒充 `vim`（`vim -> nvim` 软链会导致 LeaderF 无法分屏）。

首次可在服务器编译 C 扩展（需 gcc、python-devel）：

```bash
vim -u /opt/vim-config/vimrc -c 'LeaderfInstallCExtension' -c 'qa'
```

`fr` 需系统 PATH 中有 `rg`（ripgrep）。

### Git 仓库与 `ff`（dubious ownership）

在 Git 项目目录（如 `/data/www/crmv2`）里用 `ff` 时，LeaderF 会调用 `git ls-files`。Git 2.35+ 若**当前用户**与**仓库目录属主**不一致，会报错：

```text
fatal: detected dubious ownership in repository at '...'
```

**各用户**启用 vim 前执行一次（内网服务器常用）：

```bash
git config --global --add safe.directory '*'
```

仅信任单个目录时：

```bash
git config --global --add safe.directory /data/www/crmv2
```

root 希望**所有用户**生效时（系统级）：

```bash
git config --system --add safe.directory '*'
```

验证：`git config --global --get-all safe.directory`，然后在该项目下再按 `ff`。
