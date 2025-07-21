---
title: 'Create Pull Request'
name: create-pr
description: Create a pull request with AI-generated description
read_only: true
type: 'command'
---

# Create Pull Request

Creates a GitHub/GitLab/Bitbucket pull request from your current branch with an AI-generated description.

## Overview

- Generates PR description based on changes
- Supports GitHub CLI (gh), GitLab CLI (glab), or web interface
- Handles uncommitted changes gracefully
- Can create draft PRs
- Links to issues when appropriate

## Process Flow

1. **Verify Git Repository**
   - Check if in git repository
   - Ensure remote origin configured
   - Confirm not on default branch (main/master)
   - Check for CLI tools (gh/glab)

2. **Analyze Changes**
   - Check for uncommitted changes with `git status`
   - If uncommitted changes exist, ask user to:
     - Commit them first
     - Stash them
     - Proceed without them
   - Get diff from base branch: `git diff origin/main...HEAD`

3. **Gather PR Information**
   - Suggest PR title based on branch/commits
   - Ask for base branch (default: main)
   - Ask if draft PR
   - Ask for additional context

4. **Generate PR Description**
   - Create structured description:
   ```markdown
   ## Summary
   Brief overview of changes

   ## Changes
   - List of key changes
   - Grouped by type

   ## Testing
   - Tests added/modified
   - Testing approach

   ## Checklist
   - [ ] Code follows style guidelines
   - [ ] Tests pass locally
   - [ ] Documentation updated
   ```

5. **Review and Edit**
   - Show generated description
   - Options: use as-is, edit, regenerate

6. **Push Branch**
   - Push to remote: `git push -u origin <branch>`
   - Handle any errors

7. **Create Pull Request**
   - Using GitHub CLI:
     ```bash
     gh pr create --title "<title>" --body "<description>" --base <branch> [--draft]
     ```
   - Using GitLab CLI:
     ```bash
     glab mr create --title "<title>" --description "<description>" --target-branch <branch> [--draft]
     ```
   - Fallback: Show web URL for manual creation

8. **Post-Creation Options**
   - Open in browser
   - Add reviewers
   - Add labels
   - Link issues

## Platform Detection

Automatically detects platform from remote URL:
- GitHub: `github.com`
- GitLab: `gitlab.com` or self-hosted
- Bitbucket: `bitbucket.org`

## Quick PR Mode

For quick PR without customization:
```bash
# GitHub
gh pr create --fill

# GitLab  
glab mr create --fill
```

## Error Handling

- **No CLI tool**: Provide install instructions or web URL
- **Not authenticated**: Guide through auth process
- **PR already exists**: Offer to view/update existing PR
- **Push rejected**: Handle branch protection

## Usage Examples

```bash
# Standard PR creation
/create-pr

# Quick mode
/create-pr --quick

# Draft PR
/create-pr --draft
```

## Platform-Specific Features

### GitHub
- Project board integration
- GitHub Actions status
- Auto-reviewers from CODEOWNERS

### GitLab
- Merge request templates
- Pipeline status
- Approval rules

### Bitbucket
- Pull request templates
- Build status
- Default reviewers

## Best Practices

1. **Clear titles**: Use imperative mood
2. **Descriptive body**: Include why, not just what
3. **Link issues**: Reference related issues
4. **Small PRs**: Keep changes focused
5. **Test evidence**: Include test results when relevant