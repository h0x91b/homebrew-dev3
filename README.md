# homebrew-dev3

Homebrew tap for [dev-3.0](https://github.com/h0x91b/dev-3.0) — terminal-centric project manager for AI coding agents.

## Install

```sh
brew tap h0x91b/dev3
brew install --cask dev3
```

## Update

```sh
brew upgrade --cask dev3
```

## Known issue: tmux >= 3.7

tmux 3.7/3.7a/3.7b (in Homebrew core since Jul 2026) has a regression: whenever
the tmux server is busy for a few seconds, every newly spawned tmux command
client busy-spins at 100% CPU instead of sleeping. dev3 polls tmux constantly,
so under 3.7 the spinners starve the server and can freeze the whole machine
for tens of seconds. tmux 3.6a and earlier are unaffected.

This tap ships a pinned, keg-only [`tmux@3.6`](Formula/tmux@3.6.rb) formula
(installed to `/opt/homebrew/opt/tmux@3.6`, not linked into `PATH`). An
upcoming dev3 release will depend on it and prefer it automatically.

**Until that release lands** (dev3 <= 1.29 uses whatever `tmux` is on `PATH`),
installing `tmux@3.6` alone is not enough — keep your `PATH` tmux below 3.7,
e.g. by downgrading core tmux or force-linking the pinned keg:

```sh
brew install h0x91b/dev3/tmux@3.6
brew unlink tmux        # if core tmux is installed
brew link --overwrite --force h0x91b/dev3/tmux@3.6
```
