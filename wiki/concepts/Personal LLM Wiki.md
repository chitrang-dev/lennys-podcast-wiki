---
type: concept
title: Personal LLM Wiki
status: active
created: 2026-04-04
updated: 2026-04-04
tags:
  - concept
  - workflow
source_files:
  - llm-wiki.md
source_count: 1
---

# Personal LLM Wiki

## Summary

A persistent markdown knowledge base where raw sources are compiled into maintained wiki pages instead of being re-derived from scratch at query time.

## Core Idea

- `raw/` stores immutable source material.
- `wiki/` stores maintained summaries, entity pages, concept pages, and analyses.
- `AGENTS.md` defines how Codex should read, write, update, and maintain the vault.
- Obsidian is the reading and navigation layer.

## Why It Matters

- Synthesis compounds over time.
- Cross-links persist.
- Contradictions can be recorded explicitly.
- Good answers can be promoted into durable wiki pages.

## Related Pages

- [[wiki/concepts/Ingest Workflow]]
- [[wiki/concepts/Query Workflow]]
- [[wiki/concepts/Lint Workflow]]
- [[index]]
