# AI Workspace

> I'm sharing my personal development workspace in the hope that others find
> it useful. I use Vercel AI Gateway to choose the right model for each task.
> — Nuwan Bandara

Run Codex or Claude Code in an isolated dev container.

## Contents

- [Getting started](#getting-started)
- [Environments](#environments)
- [Codex](#codex)
- [Claude Code](#claude-code)
- [Dev Containers](#dev-containers)
- [OpenTelemetry](#opentelemetry)
- [Disclaimer](#disclaimer)
- [License](#license)

## Getting started

Create the environment file:

```sh
cp .env.example .env
```

Add your Vercel AI Gateway key to `.env`:

```dotenv
AI_GATEWAY_API_KEY=your-key
```

See the [Vercel AI Gateway model catalog](https://vercel.com/ai-gateway/models)
for available models and pricing.

Build the images:

```sh
docker compose build
```

Put your projects under `./workspace`.

## Environments

Node is used when `AGENT_ENV` is not set.

| Value  | Runtime         |
|--------|-----------------|
| `node` | Node.js         |
| `java` | Amazon Corretto |
| `rust` | Rust stable     |

The Java image installs Corretto with SDKMAN. All images include Node.js 26,
which is scheduled to enter LTS in October 2026.

Select an environment for each command:

```sh
AGENT_ENV=java ./codex
AGENT_ENV=rust ./claude
```

## Codex

```sh
./codex
AGENT_ENV=java ./codex
AGENT_ENV=rust ./codex exec "Run the tests"
```

Override the configured model:

```sh
./codex --model openai/gpt-5.6-sol
```

The default model is set in `config/codex/config.toml`.

## Claude Code

```sh
./claude
AGENT_ENV=java ./claude
AGENT_ENV=rust ./claude --model moonshotai/kimi-k3
```

## Dev Containers

Open one of these configurations with your editor:

- `.devcontainer/node/devcontainer.json`
- `.devcontainer/java/devcontainer.json`
- `.devcontainer/rust/devcontainer.json`

Inside the container:

```sh
codex
claude --model moonshotai/kimi-k3
```

## Observability

Codex and Claude then send prompts, metrics, logs, and traces through the
collector.

Noop by default. Enable Dash0 export in `.env`:

```dotenv
OTEL_ENABLED=1
DASH0_OTLP_ENDPOINT=https://ingress.example.aws.dash0.com
DASH0_AUTH_TOKEN=auth_your_token
DASH0_DATASET=ai-workspace
```

> [!CAUTION]
> Tool details, tool content, and complete API bodies remain
> disabled by default because they may contain source code or secrets. 

Enable them only when required:

```dotenv
OTEL_LOG_TOOL_DETAILS=1
OTEL_LOG_TOOL_CONTENT=1
OTEL_LOG_RAW_API_BODIES=1
```

## Disclaimer

This project was developed with assistance from AI-based coding tools.

## License

Licensed under the [MIT License](LICENSE.md).
