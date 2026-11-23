This directory is the workspace for three machine-configuration repos. Each is
a chezmoi source for one operating system, cloned into a directory here:

| Directory | Configures | Hosts |
| --- | --- | --- |
| `mac-dev-config/` | macOS | Neuromancer, cortex |
| `ubuntu-dev-config/` | Ubuntu | rama |
| `windows-dev-config/` | Windows 11 | sophon |

This directory is a git repo (jcouball/dev-config), and so is each of the
three inside it. They are separate repos, ignored by this one's `.gitignore`.
Run `git` and `gh` for a config repo inside its directory. `git status` at the
top level describes this repo only. A branch, an issue or a pull request
belongs to the repo whose files it changes.

A config repo's own `CLAUDE.md` is not loaded when the session starts here. It
is loaded when a file in that repo is first read. Before working in a config
repo, read its `CLAUDE.md` if it has one.

Shared files, such as `dot_gitconfig` and `dot_claude/CLAUDE.md`, are copied
between the three, not templated. A change to a shared file is made in each
repo that should have it, as separate commits and pull requests.

The clones here are for editing. Nothing applies from them. The chezmoi source
on each machine is a different clone (`~/.local/share/chezmoi`, or
`C:\Users\james\.local\share\chezmoi` on sophon), which stays on merged `main`.
An edit here reaches a machine only after it merges and `chezmoi update` runs
there.

Changes to the Ubuntu repo are tested on rama (`ssh rama`) and changes to the
Windows repo on sophon (`ssh sophon`), not on the Mac. Each config repo's
README says how its changes are certified.

Two rules for this repo: no git submodules, and no machine configuration.
