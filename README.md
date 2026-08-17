# 🛠️ Developer Dotfiles

> Modular, optimized, and developer-tailored configuration files (*dotfiles*) for Ubuntu & Linux workstations.

---

## 📁 Repository Structure

```
dotfiles/
├── install.sh                  # Automated symlink installer & backup script
├── .gitignore                  # Security & ignore rules
├── README.md                   # Complete documentation & cheat-sheet
│
├── zsh/                        # Zsh Shell Configuration
│   ├── .zshrc                  # Main zshrc with aliases, plugins, and PATHs
│   ├── .zshenv                 # Environment exports
│   └── .zshrc.backup           # Fallback backup
│
├── ohmyposh/                   # Oh-My-Posh Prompt Themes
│   └── clean-detailed.omp.json # Custom clean detailed theme
│
├── tmux/                       # Tmux Multiplexer Configs
│   ├── tmux.conf               # Main tmux configuration
│   ├── .tmux.conf.work         # Work/production session configuration
│   └── .tmux.conf.bak          # Backup configuration
│
├── git/                        # Git Global Configuration
│   └── .gitconfig              # User info, credential helper & alias suite
│
├── alacritty/                  # Alacritty Terminal Emulator
│   ├── alacritty.toml          # Modern TOML format configuration
│   └── alacritty.yml           # Legacy YAML format configuration
│
├── cursor/                     # Cursor AI Editor
│   ├── settings.json           # Cursor editor settings
│   └── keybindings.json        # Custom keybindings
│
├── windsurf/                   # Windsurf IDE
│   └── settings.json           # IDE settings
│
├── vscode/                     # Visual Studio Code
│   └── settings.json           # VS Code settings
│
├── bin/                        # Custom System Utilities
│   └── optimize.sh             # Linux system RAM/ZRAM & CPU optimizer
│
├── ssh/                        # SSH Configuration (Sanitized)
│   ├── config.example          # Multi-account GitHub SSH host mappings
│   └── README.md               # SSH setup & key management guide
│
├── shell-extras/               # Terminal styling & CLI tools
│   ├── .dircolors              # LS_COLORS palette definitions
│   ├── .showsh_config          # Directory display rules
│   └── .angular-config.json    # Angular CLI global config
│
├── mcp/                        # Model Context Protocol & Tools
│   ├── tools.yaml              # API / Portainer tool specifications
│   └── mcp_config.example.json # MCP server environment definition template
│
└── neofetch/                   # Neofetch System Information
    └── config.conf             # Neofetch display layout
```

---

## 🚀 Quick Start & Installation

### Option 1: Automated Installer (Recommended)

Run the included installer script. It automatically detects existing configurations, creates a timestamped safety backup in `~/.dotfiles_backup_*`, and creates symlinks:

```bash
chmod +x install.sh
./install.sh
```

### Option 2: Using GNU Stow

If you prefer `stow`:

```bash
sudo apt install -y stow
stow -t ~ zsh ohmyposh tmux git alacritty cursor windsurf vscode bin shell-extras neofetch
```

---

## ⌨️ Git Alias Cheat-Sheet (Built-in)

The included [`.gitconfig`](git/.gitconfig) comes pre-configured with productivity aliases:

| Alias | Command | Purpose |
| :--- | :--- | :--- |
| `git st` | `git status` | Quick status check |
| `git co` | `git checkout` | Checkout branch/commit |
| `git br` | `git branch` | List branches |
| `git ci` | `git commit` | Commit staged changes |
| `git df` | `git diff` | Diff working directory |
| `git lg` | `git log --oneline --graph --all --decorate` | Visual commit history graph |
| `git plo` | `git pull origin` | Pull from origin |
| `git ps` | `git push` | Push commits |
| `git rb` | `git rebase` | Rebase branch |
| `git mg` | `git merge` | Merge branch |
| `git ga` | `git add` | Stage changes |
| `git gci` | `git commit -m` | Commit with message |
| `git gcm` | `git checkout main` | Switch to main branch |
| `git gcd` | `git checkout dev` | Switch to dev branch |
| `git gcs` | `git checkout staging` | Switch to staging branch |
| `git gpo` | `git push origin` | Push to origin branch |
| `git gsta`| `git stash` | Stash unstaged changes |
| `git gstp`| `git stash pop` | Pop latest stash |

---

## 🔑 Multi-Account GitHub SSH Setup

The SSH configuration supports multiple GitHub accounts on port 443 (firewall-friendly):

```ssh
# Main Account
Host github.com
    Hostname ssh.github.com
    Port 443
    User git
    IdentityFile ~/.ssh/id_rsa_main

# Secondary Account
Host github.com-secondary
    Hostname ssh.github.com
    Port 443
    User git
    IdentityFile ~/.ssh/id_rsa_secondary
```

### Testing Connection:

```bash
# Test main account
ssh -T git@github.com

# Test secondary account
ssh -T git@github.com-secondary
```

> [!IMPORTANT]
> **Security Notice**: Private keys (`id_rsa*`, `*.pem`, `*.key`) are ignored by `.gitignore` and must **never** be committed to public repositories.

---

## 📜 License

MIT License &copy; 2026
