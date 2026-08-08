# ahelper

A lightweight operational toolkit for sustainable ARM64 Linux systems.

## Overview

`ahelper` is part of the broader **Sustainable AArch Stack**, a reproducible
infrastructure ecosystem focused on:

- ARM64-first computing
- sustainable local inference
- lightweight Linux workflows
- reproducible scientific infrastructure
- transparent operational tooling
- high-fidelity technical documentation


### v0.1

The initial release focuses narrowly on:

- Apple Silicon systems running Asahi Linux
- NVIDIA Jetson Orin Nano systems
- Arch Linux
- btrfs
- reproducible operational workflows

The goal of v0 is not to create a large framework or universal system manager.

The goal is to:

1. solve real operational problems on modern ARM64 systems
2. establish a clean modular architecture
3. build reproducible benchmarking and observability foundations
4. support sustainable local inference workflows

The need arose out of difficulties encountered by SubtleTea Research, which has been slowed down by patchy availability of reproducible ARM64 binaries and tools for Arch Linux.

Arch Linux provides some of the most advanced software available for efficient computing and local inference workflows, but ARM64 support often remains fragmented across manual builds, unofficial repositories, and inconsistent deployment practices.

`ahelper` aims to serve as a lightweight operational hub for consolidating reproducible ARM64 workflows, deployment knowledge, benchmarking tools, and sustainable inference infrastructure.

## Core Philosophy

`ahelper` favors:

- explicit operations
- transparent scripts
- measurable system behavior
- lightweight tooling
- operational reproducibility
- sustainable compute practices

The architecture intentionally avoids:

- excessive abstraction
- hidden automation
- heavyweight orchestration
- unnecessary framework complexity

Rust provides:

- orchestration
- validation
- CLI ergonomics

Shell scripts perform:

- direct system operations
- diagnostics
- deployment steps

## Future Direction

Future versions may add:

- live efficiency monitoring
- local web dashboards
- inference benchmarking
- Jetson telemetry
- thermal monitoring services
- Quarto report export
- distributed module ecosystem
- lightweight observability servers

Example future command:

```bash
ahelper efficiency-watcher --port 7979
```

---

## Module Architecture

The module system is intentionally lightweight.

Modules may eventually provide:

- shell scripts
- standalone binaries
- telemetry tools
- web interfaces
- Quarto exporters
- benchmarking utilities

The core binary remains intentionally small.

Future modules may be installed via:

```bash
ahelper add username/repository
```

without requiring recompilation of the core project.

---

## Sustainable AArch Stack

`ahelper` forms part of the broader **Sustainable AArch Stack**, alongside:

- local inference tooling
- benchmarking infrastructure
- reproducible deployment systems
- computational publishing workflows
- [`oq` (*Opinionated
Quarto*)](https://github.com/SubtleTea-Research/Opinionated-Quarto), another
tidy computational science tool from SubtleTea Research.

The broader ecosystem is motivated partly by ideas from cultural evolution and scientific reproducibility:

- durable knowledge transmission
- adaptive innovation
- operational transparency
- reproducible infrastructure

The long-term goal is to support sustainable, efficient, transparent computational systems for:

- scientific computing
- local AI
- robotics
- edge inference
- technical education
- public-interest infrastructure
