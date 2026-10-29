#!/usr/bin/env bash
# ==============================================================================
#  update.sh — Pull the latest version of the Minecraft modpack from GitHub
#
#  Usage:  ./update.sh
#
#  Works on: Linux, macOS, WSL
#  Requires: git (https://git-scm.com/downloads)
# ==============================================================================

set -euo pipefail

# ---------- colors ----------
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
CYAN='\033[0;36m'
NC='\033[0m' # No Color

# ---------- helpers ----------
info() { printf "${BLUE}[INFO]${NC} %s\n" "$*"; }
success() { printf "${GREEN}[OK]${NC}   %s\n" "$*"; }
warn() { printf "${YELLOW}[WARN]${NC} %s\n" "$*"; }
error() { printf "${RED}[ERR]${NC}  %s\n" "$*" >&2; }
header() { printf "\n${CYAN}=== %s ===${NC}\n" "$*"; }

# ---------- detect script directory ----------
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

# ---------- check git is installed ----------
header "Checking prerequisites"
if ! command -v git &>/dev/null; then
	error "Git is not installed or not found in PATH."
	echo ""
	echo "To install Git:"
	echo "  • Linux (Debian/Ubuntu):  sudo apt install git"
	echo "  • Linux (Fedora):          sudo dnf install git"
	echo "  • Linux (Arch):            sudo pacman -S git"
	echo "  • macOS:                   brew install git  (or install Xcode CLI tools)"
	echo "  • Windows:                 https://git-scm.com/download/win"
	echo ""
	echo "After installing, restart your terminal and run this script again."
	exit 1
fi

GIT_VERSION="$(git --version)"
success "Git found: $GIT_VERSION"

# ---------- verify we are in a git repository ----------
cd "$SCRIPT_DIR"
if ! git rev-parse --is-inside-work-tree &>/dev/null; then
	error "This directory is not a Git repository."
	echo ""
	echo "Make sure you cloned the modpack with:"
	echo "  git clone https://github.com/BufaloAcquatico/MCKModpack.git"
	echo ""
	echo "Or run this script from inside the modpack directory."
	exit 1
fi

success "Git repository detected."

# ---------- check remote ----------
header "Checking remote"
REMOTE_URL="$(git remote get-url origin 2>/dev/null || true)"
if [ -z "$REMOTE_URL" ]; then
	error "No 'origin' remote configured."
	echo "Add it with:  git remote add origin https://github.com/BufaloAcquatico/MCKModpack.git"
	exit 1
fi
info "Remote: $REMOTE_URL"

# ---------- check for uncommitted changes ----------
header "Checking local changes"
if ! git diff --quiet 2>/dev/null || ! git diff --cached --quiet 2>/dev/null; then
	warn "You have uncommitted local changes."
	echo "  These changes may be overwritten by the update."
	echo ""
	echo "  Options:"
	echo "    • Commit them first:    git add -A && git commit -m \"my changes\""
	echo "    • Stash them:           git stash"
	echo "    • Discard them:         git checkout -- ."
	echo ""
	read -rp "Continue pulling anyway? (y/N) " answer
	if [[ ! "$answer" =~ ^[Yy]$ ]]; then
		info "Update cancelled. No changes were made."
		exit 0
	fi
fi

# ---------- fetch ----------
header "Fetching from GitHub"
if ! git fetch origin main --quiet 2>&1; then
	error "Failed to fetch from GitHub."
	echo ""
	echo "Possible causes:"
	echo "  • No internet connection"
	echo "  • Authentication required (private repository)"
	echo "  • Remote URL is incorrect"
	echo ""
	echo "Authentication setup:"
	if [[ "$REMOTE_URL" == git@* ]]; then
		echo "  SSH remote detected. Ensure your SSH key is added to ssh-agent:"
		echo "    ssh-add ~/.ssh/id_ed25519"
		echo "  And that the public key is added to GitHub."
	else
		echo "  HTTPS remote detected. Store credentials permanently:"
		echo "    git config --global credential.helper store"
		echo "  Then run this script again to enter your credentials once."
	fi
	exit 1
fi
success "Fetched latest data."

# ---------- compare ----------
LOCAL_HASH="$(git rev-parse HEAD)"
REMOTE_HASH="$(git rev-parse origin/main)"

if [ "$LOCAL_HASH" = "$REMOTE_HASH" ]; then
	success "Already up to date! No new version available."
	echo ""
	echo "Your modpack is at commit: ${LOCAL_HASH:0:8}"
	exit 0
fi

# ---------- pull ----------
header "Pulling updates"
info "Local:  ${LOCAL_HASH:0:8}"
info "Remote: ${REMOTE_HASH:0:8}"
echo ""

if ! git pull origin main; then
	error "Pull failed — there may be merge conflicts."
	echo ""
	echo "Resolve conflicts manually:"
	echo "  1. Open conflicted files and fix markers (<<<<<<< ======= >>>>>>>)"
	echo "  2. git add <resolved-files>"
	echo "  3. git commit"
	echo "  4. Run this script again"
	exit 1
fi

success "Modpack updated successfully!"
echo ""
echo "Updated to commit: $(git rev-parse --short HEAD)"
echo "You can now launch the modpack from your Minecraft launcher."
