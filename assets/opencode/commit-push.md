---
command: commit-push
description: Check changes, craft a commit, then push to origin
---

# Commit and push

## Intent

Create a meaningful commit based on current changes and push it to `origin`.

## Steps

1. Inspect changes
   - `git status`
   - `git diff`
2. If there are no changes, stop and explain.
3. Draft a commit message
   - Title: short, lowercase, imperative
   - Body: 1-2 sentences describing why the change was made
4. Commit and push
   - `git add -A`
   - `git commit -m "<title>" -m "<body>"`
   - `git push origin $(git rev-parse --abbrev-ref HEAD)`
