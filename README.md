# dev-config

The workspace for working on my three machine-configuration repos together.
Each is a chezmoi source for one operating system:

| Repo | Configures |
| --- | --- |
| [mac-dev-config](https://github.com/jcouball/mac-dev-config) | macOS |
| [ubuntu-dev-config](https://github.com/jcouball/ubuntu-dev-config) | Ubuntu |
| [windows-dev-config](https://github.com/jcouball/windows-dev-config) | Windows |

This repo holds no machine configuration. It holds what the three share when
they are worked on side by side: instructions for coding agents, the script that
clones them, and issues for changes that span more than one of them.

## Set up the workspace

On a machine with git:

```bash
git clone https://github.com/jcouball/dev-config.git ~/github/jcouball/dev-config
cd ~/github/jcouball/dev-config
./clone-repos.sh
```

`clone-repos.sh` clones the three config repos into this directory. It skips a
repo whose directory is already here and changes nothing in an existing clone,
so it is safe to run again. Then open `~/github/jcouball/dev-config` in VS Code.

```text
~/github/jcouball/dev-config/        this repo
├── README.md
├── CLAUDE.md
├── clone-repos.sh
├── .gitignore                       ignores the three directories below
├── mac-dev-config/                  a clone, its own repo
├── ubuntu-dev-config/               a clone, its own repo
└── windows-dev-config/              a clone, its own repo
```

The script is POSIX `sh`, for the Macs and rama. There is no PowerShell
version: the workspace is not used on sophon. On Windows, clone the three by
hand into the same layout.

The three are plain clones, not git submodules. `git status` at the top level
describes this repo only and stays clean whatever the clones hold.

## Working here with a coding agent

Start the session at the top level, so it can read and change all three repos.

- **Instructions.** The agent reads this repo's [CLAUDE.md](CLAUDE.md) when the
  session starts. A config repo's own `CLAUDE.md` is not read then. Claude Code
  loads it the first time the agent reads or edits a file in that repo.
- **Branches and pull requests.** Each belongs to the repo whose files it
  changes. `git` and `gh` run inside that repo's directory. A change that spans
  repos is one branch and one pull request in each.
- **Settings and hooks.** A config repo's `.claude/settings.json` does not take
  effect in a session started here: Claude Code reads settings and hooks from
  the directory the session started in, and from no directory below it. None of
  the three has a `.claude/settings.json` today. If one gains settings or hooks
  that its work depends on, open that repo by itself for that work.
- **Skills.** Skills under a config repo's `.claude/skills/` are not listed
  when the session starts. They load the first time the agent reads or edits a
  file in that repo. None of the three has project skills today.
- **Memory.** Claude Code keeps agent memory per project path. A session
  started here uses this directory's memory, and a session started in one
  config repo uses that repo's. On a new machine there is nothing to carry
  over. On Neuromancer, the memory of the three repos' old paths was copied to
  their new paths when the clones moved here.

The first two points were checked in a session started here. The points on
settings and skills are from the Claude Code documentation, on its
[memory](https://code.claude.com/docs/en/memory),
[permissions](https://code.claude.com/docs/en/permissions) and
[skills](https://code.claude.com/docs/en/skills) pages.

## The chezmoi source and the working clone

Each machine has two clones of its config repo, and they do different jobs.

| | The chezmoi source | The working clone |
| --- | --- | --- |
| Where | `~/.local/share/chezmoi` | a directory here |
| On | merged `main` | whatever branch is being worked on |
| Used by | `chezmoi apply`, `diff`, `status` and `update` | editor and agent |

- An edit in a working clone does not reach `chezmoi apply` until it is merged
  and `chezmoi update` has run on the machine.
- `chezmoi add`, `re-add` and `edit` write to the source. Commit there, push,
  and pull the commit into the working clone.
- `chezmoi diff` and `chezmoi status` compare the machine with the source, not
  with the working clone.

What this buys: the source stays on merged `main`, so an apply or a topgrade
run never applies a half-finished branch.

### Previewing a branch from a working clone

`chezmoi diff --source <clone>` and `chezmoi status --source <clone>` show what
the branch checked out in the clone would change on this machine. They write
nothing, and `chezmoi status` with the normal source is unchanged afterwards.

```bash
chezmoi diff --source ~/github/jcouball/dev-config/mac-dev-config
```

Do not test a branch with `chezmoi apply --source <clone>` on a real machine.
It writes the branch's files to the home directory and runs the branch's
scripts for real. Once the normal source is in
use again, `chezmoi status` reports each file the branch changed as modified,
until `chezmoi apply` puts `main`'s version back. A file the branch added is
left behind, and nothing a script did is undone. The file half of this was
checked with a temporary destination directory, not a real home directory.

Test a branch the way its repo says to: a certification run in a VM for the
Mac and Windows repos, and in a container for the Ubuntu repo.

## Where issues go

An issue about one operating system goes in that repo. An issue that spans
more than one goes in
[this repo's issues](https://github.com/jcouball/dev-config/issues).

## Two rules

- **No git submodules.** The three are cloned beside this repo's files, not
  pinned by it.
- **No machine configuration.** It belongs in the repo for its operating
  system.

Never create a repo named `neuromancer-config`, `rama-config` or
`sophon-config` under this account. Those were the three repos' names, and
GitHub's redirect from an old name stops when a repo with that name exists.
