---
description: Multi-role review of a PR/branch; writes findings into the Obsidian vault
---

Invoke the `reviewing-pr` skill to review the change set from every expert role
(Architect, React, Testing, Bug, Clean code, Code style, Security) and write a
structured review note into the routed Obsidian vault.

**PR or branch**: $ARGUMENTS

If nothing is given, review the current branch against its merge base.
