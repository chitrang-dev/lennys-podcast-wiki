# Getting Started

This vault is set up so Obsidian is the reading interface and Codex is the maintainer.

## 1. Open It In Obsidian

Open `/Users/chitrang.dave/source/wiki` as an Obsidian vault.

Recommended Obsidian settings:

- Set `Files and links -> Default location for new notes` to the vault root or a folder you prefer.
- Set `Files and links -> Attachment folder path` to `raw/assets`.
- Install `Dataview` later if you want dynamic dashboards, but the vault does not depend on it.

## 2. Put New Material In `raw/inbox/`

Examples:

- Web-clipped markdown articles
- Book chapter notes
- Meeting notes
- Journal entries
- Research papers converted to markdown

Treat `raw/` as your source archive. Do not manually rewrite those files after ingest unless you intentionally want to change the source of truth.

## 3. Ask Codex To Ingest

Example prompts:

- `Read raw/inbox/<file>.md and ingest it into my wiki. Update source, concept, and entity pages as needed.`
- `Ingest everything currently in raw/inbox/ one file at a time and show me what changed after each source.`
- `Read this article and build or update the relevant concept pages in my wiki.`

## 4. Browse The Results In Obsidian

Useful places to start:

- [[Home]]
- [[index]]
- [[wiki/dashboards/Topics Dashboard]]
- [[wiki/dashboards/Episodes Dashboard]]
- [[wiki/dashboards/Guests Dashboard]]
- Backlinks and graph view

## 5. Query The Wiki

Example prompts:

- `Based on my wiki, what are the main themes around burnout?`
- `Across all Lenny's Podcast episodes, what recurring advice appears on product strategy? Save the answer as an analysis note.`
- `Compare what my sources say about deep work versus attention residue. Save the answer as a wiki page.`
- `What contradictions exist in my current notes about sleep and productivity?`

## 6. Run Periodic Maintenance

Example prompts:

- `Lint the wiki for orphan pages, duplicate concepts, and stale claims.`
- `Find pages that should probably link to each other but do not yet.`
- `What important concepts recur in the sources but still do not have their own page?`
