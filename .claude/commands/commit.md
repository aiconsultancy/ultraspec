---
title: 'Create Single Commit'
name: commit
description: Create a single commit from staged changes using conventional commit format
read_only: true
type: 'command'
---

# Commit Staged Changes

Creates a single commit from already staged changes using conventional commit format.

## Overview

- Works ONLY with files that are already staged
- NEVER stages files itself
- Uses conventional commit format with optional ticket ID
- Suggests commit messages based on staged changes
- Requires explicit confirmation before committing

## Process Flow

1. **Check for staged changes**
   - Run `git diff --cached --name-only` to list staged files
   - If no staged changes, abort with message

2. **Extract ticket ID** (optional)
   - Check command argument: `/commit ABC-123`
   - If not provided, try to extract from branch name
   - If not found, proceed without ticket ID

3. **Analyze staged changes**
   - Review the staged files with `git diff --cached`
   - Determine the primary type of change
   - Identify the main scope/area affected

4. **Generate commit messages**
   - Create 5 commit message suggestions
   - Include ticket ID if available
   - Follow conventional format

5. **Get user confirmation**
   - Show staged files summary
   - Display numbered list of suggested messages
   - Wait for user choice

6. **Create commit**
   - Only after explicit confirmation
   - Run `git commit -m "chosen message"`

## Conventional Commit Format

```
type(scope): description
```

Types:
- `feat`: New feature
- `fix`: Bug fix
- `docs`: Documentation changes
- `style`: Formatting changes
- `refactor`: Code restructuring
- `perf`: Performance improvements
- `test`: Test additions/corrections
- `build`: Build system changes
- `ci`: CI configuration changes
- `chore`: Other changes

## Usage Examples

```bash
# With ticket ID
/commit ABC-123

# Without ticket ID
/commit

# Example interaction:
# > Staged files:
# > - src/auth/login.ts
# > - tests/auth.test.ts
# >
# > Suggested commit messages:
# > 1. feat(ABC-123): implement user login functionality
# > 2. feat(ABC-123): add authentication with tests
# > 3. feat(auth): create login module and tests
# > 4. feat: implement user authentication
# > 5. test(ABC-123): add login functionality tests
# >
# > Choose message (1-5) or type custom:
```

## Restrictions

- NEVER use `git add` or stage files
- NEVER push without explicit instruction
- NEVER proceed without user confirmation
- Keep messages concise