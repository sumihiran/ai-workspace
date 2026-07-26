FROM mcr.microsoft.com/devcontainers/base:bookworm

USER root

COPY containers/install-agent-tools.sh /usr/local/share/install-agent-tools.sh
RUN bash /usr/local/share/install-agent-tools.sh vscode \
    && rm /usr/local/share/install-agent-tools.sh

COPY --chown=vscode:vscode --chmod=0755 containers/bin/claude /home/vscode/.local/bin/claude
COPY --chown=vscode:vscode --chmod=0755 containers/bin/codex /home/vscode/.local/bin/codex
COPY config/codex/config.toml /etc/codex/config.toml
COPY --chown=vscode:vscode config/nemo-relay/ /home/vscode/.config/nemo-relay/
RUN install -d -o vscode -g vscode /home/vscode/.codex

USER vscode
ENV PATH="/home/vscode/.local/bin:${PATH}"

WORKDIR /workspace
CMD ["sleep", "infinity"]
