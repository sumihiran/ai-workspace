FROM mcr.microsoft.com/devcontainers/base:bookworm

ARG JAVA_VERSION=25.0.4-amzn

USER root

COPY containers/install-agent-tools.sh /usr/local/share/install-agent-tools.sh
RUN bash /usr/local/share/install-agent-tools.sh vscode \
    && rm /usr/local/share/install-agent-tools.sh

COPY --chown=vscode:vscode --chmod=0755 containers/bin/claude /home/vscode/.local/bin/claude
COPY --chown=vscode:vscode --chmod=0755 containers/bin/codex /home/vscode/.local/bin/codex
COPY --chown=vscode:vscode config/nemo-relay/ /home/vscode/.config/nemo-relay/

RUN su - vscode -c 'curl -fsSL https://get.sdkman.io | bash' \
    && su - vscode -c "bash -c 'source /home/vscode/.sdkman/bin/sdkman-init.sh \
        && sdk install java ${JAVA_VERSION} \
        && sdk default java ${JAVA_VERSION}'" \
    && sed -i 's/^sdkman_healthcheck_enable=.*/sdkman_healthcheck_enable=false/' \
        /home/vscode/.sdkman/etc/config

COPY config/codex/config.toml /etc/codex/config.toml
RUN install -d -o vscode -g vscode /home/vscode/.codex

USER vscode
ENV SDKMAN_DIR="/home/vscode/.sdkman"
ENV JAVA_HOME="/home/vscode/.sdkman/candidates/java/current"
ENV PATH="${JAVA_HOME}/bin:/home/vscode/.local/bin:${PATH}"

WORKDIR /workspace
CMD ["sleep", "infinity"]
