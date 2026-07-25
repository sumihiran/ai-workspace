FROM mcr.microsoft.com/devcontainers/rust:1-bookworm

USER root

COPY containers/install-agent-tools.sh /usr/local/share/install-agent-tools.sh
RUN bash /usr/local/share/install-agent-tools.sh vscode \
    && rm /usr/local/share/install-agent-tools.sh

COPY --chown=vscode:vscode config/codex/config.toml /home/vscode/.codex/config.toml

USER vscode
ENV PATH="/home/vscode/.local/bin:${PATH}"

WORKDIR /workspace
CMD ["sleep", "infinity"]
