from pathlib import Path

BASE = Path.cwd()

SELECTION = {
    "config": ["fzf", "nvim", "tmux", "starsheep", "wezterm"],
    "dotfiles": ["zsh"],
}

for root, subdirs in SELECTION.items():
    base = BASE / root
    for sub in subdirs:
        path = base / sub
        for p in sorted(path.rglob("*")):
            if p.is_file():
                print(f"\n===== {p} =====\n")
                print(p.read_text())
