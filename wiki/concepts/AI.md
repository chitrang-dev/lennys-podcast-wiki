---
type: concept
title: AI
status: active
created: 2026-04-05
updated: 2026-04-07
tags:
  - concept
  - ai
source_count: 8
---

# AI

## Summary

The emerging AI corpus in this wiki treats AI less as a feature add-on and more as a moving product substrate. The central challenge is not simply model access, but designing trustworthy systems, workflows, and organizational habits that can improve as models and user behavior change.

## Core Pattern

- AI products behave differently from traditional software because they are non-deterministic and often involve agency tradeoffs.
- Product teams need faster learning loops because the capability frontier shifts constantly.
- Trust, control, data quality, and evaluation are recurring leverage points.
- Many AI advantages come from workflows, flywheels, and proprietary context rather than raw model novelty alone.

## Recurring Principles

- `Start problem-first, not model-first`
  Aishwarya Reganti and Kiriti Badam explicitly warn that teams fixate on solution complexity and forget the problem.
- `Build step-by-step with tight calibration loops`
  Successful AI teams keep the system narrow enough to learn, then expand while monitoring failures and user trust.
- `Integrate AI into product thinking, not as a detached specialty`
  Tomer Cohen argues AI teams and product teams need shared objectives; AI cannot remain a separate service org.
- `Prototype aggressively`
  Aparna Chennapragada frames prototyping with AI as the new normal because the interface and design space are changing too quickly for static planning.
- `Assume the capability frontier will move`
  Kevin Weil emphasizes that the model available today is the worst one you will use going forward, which changes how teams should think about timing and product bets.
- `Data and context quality matter more than most teams think`
  Shaun Clowes argues that the value in AI systems often sits in the freshness, structure, and relevance of the data behind the model.

## What Good Looks Like

- A narrow but meaningful use case with visible user value.
- Human control where failures are costly or trust is fragile.
- Continuous evaluation using both quantitative and user-facing signals.
- Product, engineering, and leadership staying hands-on enough to learn from real system behavior.
- A plan for the system to get better over time via usage, feedback, or proprietary context.

## Common Failure Modes

- Shipping an agent because the market expects one, rather than because the workflow justifies one.
- Treating evals as a complete answer instead of one input into reliability.
- Underestimating prompt injection, trust breakdowns, hallucinations, or stale context.
- Optimizing for demo appeal rather than recurring real-world use.
- Building around current model limits as if they are permanent.

## Tensions To Manage

- `Agency vs. control`
  More autonomous systems can unlock more value but create bigger reliability and trust risks.
- `Speed vs. trust`
  AI teams often need to ship fast, but repeated trust violations can permanently damage adoption.
- `General-purpose models vs. domain-specific leverage`
  The most durable moats often come from proprietary context, workflow integration, and data flywheels rather than just picking the best base model.

## Supporting Pages

- [[wiki/sources/2026-01-11 - Why most AI products fail - Lessons from 50+ AI deployments at OpenAI, Google & Amazon]]
- [[wiki/sources/2025-12-04 - Why AI is disrupting traditional product management Tomer Cohen (LinkedIn CPO) (tomer-cohen)]]
- [[wiki/sources/2025-05-18 - Microsoft CPO - If you aren’t prototyping with AI you’re doing it wrong Aparna Chennapragada]]
- [[wiki/sources/2025-04-10 - OpenAI’s CPO on how AI changes must-have skills, moats, coding, startup playbooks, more Kevin Weil]]
- [[wiki/sources/2024-12-29 - Why great AI products are all about the data Shaun Clowes (CPO at Confluent)]]
- [[wiki/sources/2025-10-10 - Inside Google's AI turnaround - AI Mode, AI Overviews, and vision for AI-powered search Robby Stein]]
- [[wiki/sources/2025-09-25 - Why AI evals are the hottest new skill for product builders Hamel Husain & Shreya Shankar]]
- [[wiki/sources/2025-06-19 - AI prompt engineering in 2025 - What works and what doesn’t Sander Schulhoff (sander-schulhoff)]]

## Open Questions

- Which AI moats recur most often in the catalog: data, workflow integration, trust, distribution, or speed of iteration?
- How should this page separate AI product advice for consumer, enterprise, and developer tools?

## Links

- [[wiki/concepts/AI-First Product Development]]
- [[wiki/concepts/Product Strategy]]
- [[wiki/concepts/Leadership]]
- [[wiki/concepts/AI Product Development Lifecycle]]
- [[wiki/concepts/AI Evals and Reliability]]
- [[wiki/concepts/AI UX and Interaction Design]]
- [[wiki/concepts/AI Data, Moats, and Platform Shifts]]
