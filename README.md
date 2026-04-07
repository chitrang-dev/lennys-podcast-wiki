# Lenny's Podcast Wiki

This repository is an Obsidian-first markdown wiki for Lenny's Podcast. It is designed to turn raw podcast transcripts into a durable, interlinked knowledge base that compounds over time.

The vault is maintained in plain markdown files so it stays easy to browse in Obsidian, version with git, and extend with Codex.

## What This Repository Contains

- Raw transcript sources in `raw/inbox/`, organized by guest
- Source notes in `wiki/sources/`
- Guest pages in `wiki/entities/`
- Cross-episode concept pages in `wiki/concepts/`
- Durable analysis notes in `wiki/analyses/`
- Navigation pages in `wiki/dashboards/`

This repository already includes synthesized topic areas such as strategy, growth, AI, and leadership, along with supporting dashboards for episodes, guests, and recurring topics.

## How The Workflow Works

1. Add a transcript to `raw/inbox/<guest-folder>/transcript.md`
2. Ask Codex to ingest the transcript into the wiki
3. Review the generated source, guest, and concept pages in Obsidian
4. Ask cross-episode questions and save strong syntheses back into the vault
5. Commit meaningful updates to git so the wiki remains versioned

## Open In Obsidian

Open `/Users/chitrang.dave/source/wiki` as an Obsidian vault.

Useful starting points:

- `Home.md`
- `Getting Started.md`
- `Prompt Cookbook.md`
- `index.md`
- `wiki/dashboards/Topics Dashboard.md`

## Repository Structure

```text
.
|-- raw/
|   |-- inbox/
|   `-- assets/
|-- scripts/
|-- templates/
|-- wiki/
|   |-- analyses/
|   |-- concepts/
|   |-- dashboards/
|   |-- entities/
|   `-- sources/
|-- AGENTS.md
|-- Home.md
|-- index.md
`-- log.md
```

## Working With Codex

The operating rules for maintaining this vault live in `AGENTS.md`.

Typical prompts:

- `Ingest every transcript in raw/inbox/ that is not yet reflected in the wiki.`
- `Update the leadership synthesis with stronger cross-episode analysis.`
- `Create a new analysis page comparing how guests think about strategy and execution.`
- `Lint the vault for duplicate guest pages, weak concept notes, and broken links.`

## Git

This vault is tracked in git so the markdown knowledge base can be backed up and evolved over time.

Common commands:

```bash
git status
git add .
git commit -m "Update wiki"
git push
```

## Start Here

If you are new to the vault, start with `Home.md`, then `Getting Started.md`, then `index.md`.
