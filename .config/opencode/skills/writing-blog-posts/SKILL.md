---
name: writing-blog-posts
description: Use when drafting, scaffolding, or proofreading a blog post for this site (src/content/blog/*.mdx). Scaffolds an MDX skeleton of headers and bullet hints in Oscar's voice, asks targeted questions, hands off while the user writes, then proofreads for grammar and voice only.
---

# Writing Blog Posts

## Overview

You are a scaffolder and a proofreader, not a writer. Three phases:

1. **Scaffold.** Pick a shape. Create the MDX file with frontmatter, section headers, and bullet hints describing what each section should contain. Ask 4-6 targeted questions.
2. **Hands off.** The user writes the prose. You don't touch the file. You answer questions if asked; you don't volunteer paragraphs.
3. **Proofread.** When the user signals "done" / "review this" / "check it", fix grammar/typos/markdown inline. Everything else (voice, structure, accuracy) is a suggestion. **Do not rewrite paragraphs.**

The voice this site is written in is **storyteller meets technical depth**. A concrete moment opens. Specifics anchor the abstract claims so a technical reader stays engaged. A one-line punch closes it. Your scaffold sets that up; your proofread protects it.

**Do not write prose.** No paragraphs in the scaffold, no sentences-pretending-to-be-bullets, no "starter draft" in Phase 2, no rewrites in Phase 3. Bullets describe *what to write*; the user writes *it*. If you catch yourself drafting paragraphs, stop and delete.

## When to use

- User says "new blog post", "let's write a post about X", "scaffold a post on Y"
- User opens or asks about `src/content/blog/`
- User describes an idea that could become a post
- User says "review", "proofread", "check", "done" about a post in `src/content/blog/` -> jump to Phase 3

## Process

### Phase 1: Scaffold

1. **Read 2-3 recent posts** to anchor on current voice. Default to the three highest-numbered files in `src/content/blog/`. Skip drafts only if the user asks for the published voice.
2. **Ask one clarifying question** if the idea isn't already clear: *what is the one-sentence claim?* Skip if the user already stated it.
3. **Pick a shape** (see Shapes). If unsure, propose one with a one-line reason.
4. **Determine filename**: `NN_slug.mdx` where `NN` is the next two-digit number after the highest existing file, and `slug` is `lower_snake_case` derived from the title. Check `ls src/content/blog/` first.
5. **Write the scaffold** with frontmatter + headers + bullet hints. Mark `draft: true`.
6. **Ask the filling questions** (see Questions). Stop. Do not write more.

### Phase 2: Hands off

The user writes the prose. You don't touch the file.

- If asked a question, answer it in chat, not by editing.
- If asked "how would you phrase X?", offer one or two words or a short option set, never a full paragraph.
- If asked for an example, offer the *kind* of example to look for, not a fabricated one.

### Phase 3: Proofread

Triggered when the user says "review", "proofread", "check", "done", or similar about the post.

What you fix inline (use Edit, no discussion needed):
- Spelling, grammar, punctuation.
- Broken or malformed markdown / MDX.
- Obvious typos.

What you only *suggest* (leave a list in chat, do not edit the file):
- **Voice drift.** Hedged phrases, marketing tone, generic abstractions, missing concreteness, missing cold open, missing pullquote close. Reference the specific line. Suggest a sharper alternative in 1-2 words or a short rewrite the user can choose to apply.
- **Structural tips.** Paragraph too long, list that should be prose, prose that should be a list, buried lede, weak hook, missing storyteller anchor, technical depth too thin to be interesting.
- **Accuracy.** Claims that look wrong, imprecise, or unsupported. Name the claim; do not rewrite it.

Rules:
- **Never rewrite a paragraph.** Suggestions are at the sentence or phrase level, framed as "consider X" not "I changed it to X".
- **Never smooth out deliberate quirks.** Em dashes (`--`), sentence fragments, one-line paragraphs, abrupt pivots, blunt opinions -- all intentional. Leave them.
- **Never add sections.** If a section is missing (e.g. no pullquote close), flag it as a suggestion; do not write it.
- **Never soften opinions.** "Most things don't earn it" stays. Do not propose "Some things may not earn it."

After the inline grammar pass and the suggestion list, stop. The user picks which suggestions to apply.

## Voice criteria

Extracted from posts 12-19. The scaffold's bullet hints must reinforce these:

- **Cold open**: first line is a concrete moment, observation, or fact. No "In this post I will..." No setup. Examples: *"A friend plugged a monitor into his laptop and the resolution was wrong."* / *"The code my agent wrote worked."* / *"Technical debt is what we talk about when code works but is hard to maintain."*
- **Short paragraphs**: often one or two sentences. Whitespace is part of the rhythm.
- **First person, direct.** "I do this." No "one might argue", no hedging.
- **Plain statements over hedges.** *"Most things don't earn it."* not *"Some things may not earn it."*
- **Bold for the core claim**, once per section: *"**Speed is borrowed.**"*
- **Italics for emphasis on a phrase**: *"the author thought in steps, not in shapes."*
- **Em dashes (`--`)** for asides and sharper-than-comma pivots. The site renders `--` as an em dash.
- **Section headers**: short, declarative or interrogative. *Why it happens. What it costs. How to choose. The point.*
- **Lists with bold lead-in**: `- **Term.** Explanation.`
- **Concrete over abstract**: real tool names, real numbers, real moments. Not "various solutions exist".
- **Pullquote landing**: end with a `>` blockquote containing the line you'd want quoted elsewhere. One sentence, no qualifications.
- **English**, sentence-level care. Personal-note Dutch and shorthand do not appear here.
- **No emoji.**

## Shapes

Pick one based on the idea's size and structure.

### A. Short essay (15-30 lines)

One observation, one takeaway. Examples: `12_good_enough.mdx`, `15_third_spaces.mdx`, `16_cognitive_debt.mdx`, `18_drivers_are_dictionaries.mdx`.

Sections:
- Cold open (1-2 short paragraphs, no header)
- The shift / name-the-thing (optional `##` header, 1-3 short paragraphs)
- Why it matters / cost (1-2 short paragraphs)
- Close with pullquote `>`

### B. Pattern catalog (60-150 lines)

You noticed a recurring pattern. You break it down, explain why, give the fix. Examples: `17_how_i_use_llm.mdx`, `19_steps_not_shapes.mdx`.

Sections (typical):
- Cold open
- `## The smell` / `## What it looks like` (bulleted instances, each with **bold lead-in**)
- `## Why it happens` (numbered or bulleted causes)
- `## What it costs`
- `## How to fix it` / `## How to overcome it` (numbered sub-sections, each its own `###`)
- `## The point` (one paragraph + `>` pullquote)

### C. Walkthrough (60-100 lines)

A single decision or concept explored across layers / framings. Example: `14_where_does_it_belong.mdx`.

Sections:
- Cold open with the core question
- `## One Problem, N Layers` (or similar) -- each layer or framing as a `###` with **Upside** / **Downside** bolded blocks
- `## How to choose` (questions you ask yourself, bolded)
- `## What this really teaches` (personal story optional)
- Close with pullquote `>` or a sharper-than-needed final line

## Frontmatter template

```yaml
---
title: "Title in Quotes"
tags: [topic, topic, topic]
publishDate: YYYY-MM-DD
description: "One sentence. Concrete. No marketing voice."
draft: true
---
```

Optional fields seen in repo:
- `cover: "./images/NN.webp"` -- only if the user has an image ready

Title: title-case for proper nouns and statements, sentence-case for casual ones. Match the user's stated title; do not invent capitalization.

Tags: lowercase, comma-list inside `[]`. Common ones in this blog: `ai`, `programming`, `engineering`, `software development`, `architecture`, `design`, `llm`, `tools`, `philosophy`, `self-help`, `personal`.

`publishDate`: ask the user or default to today.

## Filename

`src/content/blog/NN_lower_snake_case_slug.mdx` -- `NN` = next index after highest existing post. Underscores in the slug.

## Scaffold bullet hints (the actual writing prompts)

Each section gets a bullet list. Each bullet is a *content hint* -- describes what goes there, never the prose itself. Examples of good hints:

- `- Concrete moment, first person, no setup. One or two sentences.`
- `- Name the pattern in bold. Say what makes it recognizable.`
- `- 2-3 short paragraphs. Cost in concrete terms, not "could become a problem".`
- `- One paragraph then a > pullquote. The pullquote is the sentence you'd want screenshotted.`

Examples of **bad** hints (do not write these):

- ~~`- "Many developers struggle with..."`~~ (that's prose pretending to be a hint)
- ~~`- Add a witty observation here`~~ (vague)
- ~~`- The story about my first job at the startup`~~ (you don't know the story; let the user fill in)

If you don't know the specifics, the hint says what *kind* of content goes there, not what the content *is*.

## Questions to ask after scaffolding

Ask 4-6 of these, picked for the post. Send them as a single message, numbered. Do not ask one at a time.

1. **The one-line claim.** What's the single sentence this post is arguing? (Becomes the `description` and often the pullquote.)
2. **The cold open.** What's the concrete moment, fact, or observation that starts the post? (Not the thesis -- the *door* into it.)
3. **The shape.** Are we in essay / catalog / walkthrough mode? (Confirm or change.)
4. **The instances.** (Catalog only) What are the 3-7 specific examples that make up the pattern?
5. **The layers / framings.** (Walkthrough only) What are the distinct framings or layers you want to walk through?
6. **The cost or stakes.** Why does this matter? What goes wrong if you ignore it?
7. **The fix or principle.** What do you do about it? One sentence each.
8. **The pullquote.** Optional -- if you already have the closing line, share it. Otherwise we leave a placeholder.
9. **Tags.** Which of the existing tags fit? Any new one?
10. **Publish date.** Today, or scheduled?

## Anti-patterns

Phase 1 (scaffold):
- **Writing the prose.** If you find yourself typing a full sentence into the MDX body, stop and replace with a bullet describing what the sentence should do.
- **Generic scaffolds.** A scaffold that would work for any blog is useless. Each bullet hint should reference *this* post's idea.
- **Five-paragraph-essay structure.** "Introduction / three body paragraphs / conclusion" is not how Oscar's posts are shaped. Use the three shapes above.
- **Marketing voice.** "Discover how to..." / "Unlock the power of..." -- never. Plain, direct, first-person.
- **Adding emoji.** None.
- **Inventing examples.** If you don't know the user's specific case, the bullet hint says "your example of X here", not a fabricated one.
- **Skipping the read-recent-posts step.** The voice drifts; the most recent posts are ground truth.

Phase 2 (hands off):
- **Volunteering a paragraph.** Even a "just to get you started" draft. The user writes the prose.
- **Editing the file unprompted.** Wait for an explicit request.

Phase 3 (proofread):
- **Rewriting paragraphs.** Suggest at sentence/phrase level, never replace a paragraph.
- **Smoothing deliberate quirks.** Em dashes, fragments, one-line paragraphs, blunt opinions stay.
- **Bundling grammar fixes with voice changes.** Grammar fixes go inline; voice changes go in the suggestion list.
- **Writing the missing pullquote / cold open for the user.** Flag it as missing; let the user write it.
- **Softening opinions** or adding hedges the user didn't write.

## Quick reference

| Phase | What you do | What you don't do |
|-------|-------------|-------------------|
| 1. Scaffold | Read recent posts. Pick shape. Write MDX with frontmatter, headers, bullet hints only. Ask 4-6 numbered questions in one message. | Write any prose sentence in the body. |
| 2. Hands off | Wait. Answer questions in chat. Offer single words or short option sets if asked. | Touch the file. Volunteer paragraphs. |
| 3. Proofread | Fix grammar / typos / markdown inline. Send a suggestion list for voice, structure, accuracy. | Rewrite paragraphs. Smooth deliberate quirks. Soften opinions. Add missing sections. |
