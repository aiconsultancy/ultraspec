---
title: 'Create Multiple Commits'
name: create-commits
description: Create atomic commits from unstaged changes with conventional commit format
read_only: true
type: 'command'
---

# Create Commits with Conventional Format

Creates one or more atomic commits from unstaged changes using conventional commit format.

## Overview

- Analyzes unstaged changes and suggests logical groupings
- Uses conventional commit format: `type(scope): description`
- Automatically detects or accepts ticket ID for scope
- Stages files intelligently, respecting .gitignore
- Asks for confirmation before each commit
- NEVER pushes changes automatically

## Ticket ID Detection

The command will attempt to find ticket ID in this order:
1. From command argument: `/create-commits ABC-123`
2. From current branch name (e.g., `feature/ABC-123-user-auth`)
3. From recent commit messages in the branch
4. If not found, prompts user or proceeds without

## Process Flow

1. **Check for unstaged changes**
   - Run `git status` to see all modified files
   - If no changes, abort with message

2. **Extract ticket ID**
   - Check command argument first
   - Extract from branch name using regex: `/[A-Z]+-\d+/`
   - Check recent commits: `git log -n 10 --oneline`
   - Ask user if still not found

3. **Analyze changes**
   - Group related changes into logical units:
     - Files in same directory/module
     - Files with related functionality
     - Dependencies between changes
   - Each group should be independently committable

4. **For each logical group:**
   - Stage relevant files using `git add`
   - Generate 5 commit message suggestions
   - Display staged files and messages
   - Ask for confirmation
   - Create commit after approval

5. **After all commits:**
   - Show summary of created commits
   - Wait for further instructions

## Conventional Commit Types

- `feat`: New feature
- `fix`: Bug fix
- `docs`: Documentation only changes
- `style`: Formatting, missing semicolons, etc.
- `refactor`: Code change that neither fixes nor adds feature
- `perf`: Performance improvements
- `test`: Adding or correcting tests
- `build`: Build system or dependency changes
- `ci`: CI configuration changes
- `chore`: Other changes
- `revert`: Reverts a previous commit

## Example Messages

With ticket ID:
- `feat(ABC-123): add user authentication module`
- `fix(ABC-123): resolve null pointer in payment`
- `refactor(ABC-123): extract validation logic`
- `docs(ABC-123): update API documentation`
- `test(ABC-123): add unit tests for user service`

Without ticket ID:
- `chore: update eslint configuration`
- `build: upgrade to React 18`
- `ci: add deployment workflow`

## Usage Examples

```bash
# With ticket ID
/create-commits ABC-123

# Without argument (auto-detect)
/create-commits

# Branch names that auto-detect:
# feature/ABC-123-user-auth
# bugfix/XYZ-456-payment-issue
# ABC-789-refactor-validation
```

## Restrictions

- NEVER push without explicit user instruction
- NEVER add co-authorship footers
- NEVER mention AI/LLM assistance
- NEVER stage .gitignored files
- NEVER proceed without confirmation
- Keep commit messages concise

## Error Handling

- If staging fails: Show error and ask user to resolve
- If commit fails: Show error and offer to retry
- If push requested but fails: Show error and suggest checking remote