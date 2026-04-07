---
type: concept
title: Ingest Workflow
status: active
created: 2026-04-04
updated: 2026-04-04
tags:
  - concept
  - workflow
---

# Ingest Workflow

## Summary

The ingest workflow turns a raw source into a set of maintained wiki updates.

## Default Steps

1. Read a file from `raw/`.
2. Create or update a source note in `wiki/sources/`.
3. Update affected entity and concept pages.
4. Update [[index]].
5. Append an entry to [[log]].

## Review Questions

- What is genuinely new here?
- Which existing pages should change?
- Does the source contradict anything already in the wiki?
- Should this create a new concept or entity page?
