# Alex's Kidnap Experience — Minecraft Modpack

A Minecraft 1.20.1 Fabric modpack shared privately with friends.

## Prerequisites

- **Minecraft Launcher** (Prism Launcher, MultiMC, or official Minecraft Launcher)
- **Git** — [Download Git](https://git-scm.com/downloads)
  - Windows: https://git-scm.com/download/win
  - Linux: `sudo apt install git` (Debian/Ubuntu) or `sudo dnf install git` (Fedora)
  - macOS: `brew install git` or install Xcode CLI tools

## Setup

### 1. Clone the repository

```bash
git clone https://github.com/BufaloAcquatico/MCKModpack.git
cd MCKModpack
```

### 2. Configure authentication (private repository)

Since this is a private repository, you need to authenticate with GitHub.

**Option A — HTTPS (simpler):**

```bash
git config --global credential.helper store
```

Then run the update script once to enter your credentials. They will be saved permanently.

**Option B — SSH (more secure):**

```bash
# Generate a key
ssh-keygen -t ed25519 -C "your_email@example.com"

# Add to ssh-agent
eval "$(ssh-agent -s)"
ssh-add ~/.ssh/id_ed25519

# Copy the public key and add it to GitHub
cat ~/.ssh/id_ed25519.pub
```

Then add the key at: https://github.com/settings/keys

### 3. Launch the modpack

Open the cloned directory as a Minecraft instance in your launcher.

## Updating the modpack

Whenever a new version is released, run the update script:

**Windows:**
```
Double-click update.bat
```
or from Command Prompt:
```
update.bat
```

**Linux / macOS:**
```bash
chmod +x update.sh   # only needed once
./update.sh
```

The script will:
1. Check that Git is installed
2. Verify you are in the correct directory
3. Fetch the latest changes from GitHub
4. Pull updates if available
5. Warn you about any local uncommitted changes

## Troubleshooting

### "Git is not installed"
Install Git from https://git-scm.com/downloads and restart your terminal.

### "This directory is not a Git repository"
Make sure you cloned the repo with `git clone` and are running the script from inside the cloned folder.

### "Failed to fetch from GitHub"
- Check your internet connection
- Verify authentication (see Setup step 2)
- For HTTPS: run `git config --global credential.helper store` and try again
- For SSH: ensure your key is added with `ssh-add ~/.ssh/id_ed25519`

### Merge conflicts
If you have local modifications that conflict with the update:
1. Open the conflicted files and fix the conflict markers
2. `git add <resolved-files>`
3. `git commit`
4. Run the update script again

### Authentication keeps asking for credentials
Set up a credential helper:
```bash
git config --global credential.helper store
```

## Notes

- The `.gitignore` file excludes worlds, logs, cache, and other runtime-generated files — only the pack definition is tracked.
- Do not commit your world saves or personal settings.
- If you modify configs locally, be careful when updating — your changes may be overwritten.