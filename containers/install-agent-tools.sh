#!/usr/bin/env bash
set -euo pipefail

agent_user="${1:?usage: install-agent-tools.sh USER}"

export DEBIAN_FRONTEND=noninteractive

apt-get update
apt-get install -y --no-install-recommends \
    bubblewrap \
    build-essential \
    ca-certificates \
    curl \
    fd-find \
    fzf \
    gh \
    git \
    git-lfs \
    gnupg \
    jq \
    less \
    lsof \
    netcat-openbsd \
    openssh-client \
    procps \
    python3 \
    python3-pip \
    python3-venv \
    ripgrep \
    rsync \
    shellcheck \
    socat \
    sqlite3 \
    sudo \
    tree \
    unzip \
    wget \
    zip

node_major=0
if command -v node >/dev/null 2>&1; then
    node_major="$(node --version | sed -E 's/^v([0-9]+).*/\1/')"
fi

if [ "$node_major" -lt 26 ]; then
    curl -fsSL https://deb.nodesource.com/setup_26.x | bash -
    apt-get install -y --no-install-recommends nodejs
fi

if [ ! -e /usr/local/bin/fd ]; then
    ln -s /usr/bin/fdfind /usr/local/bin/fd
fi

npm install --global @openai/codex@latest

su - "$agent_user" -c 'curl -fsSL https://claude.ai/install.sh | bash'

rm -rf /var/lib/apt/lists/*
