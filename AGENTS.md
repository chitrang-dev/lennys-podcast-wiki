# Personal LLM Wiki Schema

This repository is an Obsidian-first personal wiki maintained primarily by Codex.

## Purpose

The goal is to turn raw sources into a persistent, interlinked markdown wiki that compounds over time.

Codex owns the wiki layer. The user owns source curation, review, and direction.

## Directory Structure

- `raw/` contains source material and attachments. Treat files here as immutable.
- `raw/inbox/` is the default drop zone for newly clipped or imported markdown sources.
- `raw/assets/` stores downloaded images and attachments referenced by source files.
- `wiki/sources/` contains one page per ingested source.
- `wiki/entities/` contains durable pages about people, places, companies, products, projects, habits, or other recurring entities.
- `wiki/concepts/` contains topic pages, frameworks, themes, questions, and synthesized ideas.
- `wiki/analyses/` contains query outputs worth preserving, such as comparisons, plans, decision memos, and thematic syntheses.
- `wiki/dashboards/` contains overview pages for navigation.
- `templates/` contains page templates and writing patterns for the LLM to follow.
- `index.md` is the canonical content index for the wiki.
- `log.md` is the chronological append-only log of activity.

At larger catalog sizes, use dashboard pages to organize long lists:

- `wiki/dashboards/Episodes Dashboard.md` for the full episode catalog
- `wiki/dashboards/Guests Dashboard.md` for guest entity navigation
- `wiki/dashboards/Podcast Topics Dashboard.md` for keyword-level topic discovery

## Global Rules

1. Never modify files in `raw/` unless the user explicitly asks.
2. Prefer updating existing wiki pages over creating near-duplicates.
3. Preserve markdown readability in Obsidian. Use standard links like `[[Page Name]]` wherever practical.
4. Every substantive wiki page should include YAML frontmatter.
5. When new evidence conflicts with existing content, do not silently overwrite the older claim. Update the affected page and note the contradiction or supersession explicitly.
6. When answering a useful question, prefer saving the answer into `wiki/analyses/` if it will likely be useful again.
7. Keep `index.md` and `log.md` current whenever the wiki changes materially.

## Naming Conventions

- Use title-style filenames with spaces for Obsidian readability.
- Source pages: `wiki/sources/YYYY-MM-DD - Short Title.md`
- Analysis pages: `wiki/analyses/YYYY-MM-DD - Topic.md`
- Entity and concept pages: short descriptive names, for example `Sleep.md`, `Attention.md`, `OpenAI.md`, `Personal Systems.md`

For podcast transcript sources:

- Treat each transcript as one source page even if it lives inside a guest folder.
- Create or update an entity page for the guest.
- Prefer concept pages for reusable ideas, frameworks, and operating principles discussed in the episode.
- Record podcast metadata in the source page frontmatter when available, such as `guest`, `channel`, `video_id`, `youtube_url`, and `publish_date`.
- When bulk-ingesting a large transcript set, metadata-derived source and entity pages are acceptable as a first pass. Deeper concept synthesis can be layered on later.

## Frontmatter Conventions

Use frontmatter like this when applicable:

```yaml
---
type: source | entity | concept | analysis | dashboard
title: Page Title
status: active
created: YYYY-MM-DD
updated: YYYY-MM-DD
tags:
  - tag-name
source_files:
  - raw/inbox/example.md
source_count: 1
---
```

Guidance:

- `type` is required.
- `updated` must change when the page is materially revised.
- `source_files` is required on source pages and optional elsewhere.
- `source_count` is useful on synthesized pages that depend on multiple sources.

## Ingest Workflow

When the user asks to ingest a new source:

1. Read the new file from `raw/inbox/` or another `raw/` path.
2. Create or update a source note in `wiki/sources/`.
3. Update relevant entity, concept, and dashboard pages.
4. Update `index.md`.
5. Append a new entry to `log.md`.
6. Surface ambiguities, contradictions, and follow-up questions to the user.

## Query Workflow

When the user asks a question about the wiki:

1. Read `index.md` first to identify relevant pages.
2. Read the most relevant linked pages.
3. Answer using the wiki as the primary context.
4. If the answer produces a durable artifact, save it in `wiki/analyses/`.
5. Append a query entry to `log.md` if a new analysis page was created.

## Lint Workflow

When asked to lint or health-check the wiki:

1. Look for stale claims, duplicate pages, orphan pages, missing links, weak summaries, and unresolved contradictions.
2. Propose or make fixes where confidence is high.
3. Save notable findings as a dated analysis note if useful.
4. Append a lint entry to `log.md`.

## Writing Style

- Write concise pages optimized for scanning.
- Prefer headings, bullets, and short paragraphs over long prose blocks.
- Use sections such as `Summary`, `Key Points`, `Evidence`, `Open Questions`, and `Links` when useful.
- Keep speculation clearly labeled.
- Preserve uncertainty instead of flattening it into false certainty.

## Obsidian Compatibility

- Prefer wiki links like `[[index]]` and `[[Sleep]]`.
- Avoid custom markdown constructs that render poorly in Obsidian.
- Keep pages useful both in graph view and through backlink navigation.
