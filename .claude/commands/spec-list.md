---
title: 'List All Specs'
name: spec-list
description: Shows comprehensive overview of all spec modules
read_only: true
type: 'command'
---

# List All Specs

Provides a comprehensive overview of all spec modules in the project.

## Overview

- Lists all modules with descriptions
- Shows completion status
- Displays last modified dates
- Provides quick navigation

## List Display Format

```
SPEC MODULE OVERVIEW
===================

## Active Modules (3)

### 🔄 user-authentication
Last modified: 2024-01-15
Phase: Implementation (75% complete)
Description: User registration, login, and session management
Requirements: 5 stories | Design: Approved | Tasks: 6/8 complete

### 🔄 payment-processing  
Last modified: 2024-01-14
Phase: Design (awaiting approval)
Description: Handle payments, refunds, and subscription billing
Requirements: 8 stories | Design: In Review | Tasks: Not started

### 🔄 notification-system
Last modified: 2024-01-13
Phase: Requirements (in progress)
Description: Email, SMS, and in-app notification delivery
Requirements: 3 stories (draft) | Design: Not started | Tasks: Not started

## Completed Modules (2)

### ✅ data-migration
Completed: 2024-01-10
Description: Migrate data from legacy system
Requirements: 4 stories | Design: Approved | Tasks: 12/12 complete

### ✅ api-authentication
Completed: 2024-01-05  
Description: JWT-based API authentication system
Requirements: 3 stories | Design: Approved | Tasks: 8/8 complete

## Planned Modules (4)

### ⏳ reporting-dashboard
Status: Not started
Description: Analytics and reporting for administrators
Priority: Medium

### ⏳ audit-logging
Status: Not started
Description: Comprehensive activity logging system  
Priority: High

### ⏳ file-storage
Status: Not started
Description: File upload and storage management
Priority: Medium

### ⏳ search-system
Status: Not started
Description: Full-text search across all entities
Priority: Low

SUMMARY
-------
Total Modules: 9
Active: 3 | Completed: 2 | Planned: 4
Overall Progress: 22% complete
```

## Module Categories

### Active Modules
- Currently being worked on
- Have at least one phase started
- Ordered by last activity

### Completed Modules  
- All tasks implemented
- All tests passing
- No pending work

### Planned Modules
- Identified but not started
- May have priority assigned
- Waiting in backlog

## Usage Examples

```bash
# List all modules
/spec-list

# List only active modules
/spec-list --active

# List with full details
/spec-list --detailed

# List by phase
/spec-list --phase=implementation

# Search modules
/spec-list --search=payment
```

## Information Shown

### Standard View
- Module name and status icon
- Current phase and progress
- Brief description
- Key metrics

### Detailed View
- All standard information
- Full requirement summaries
- Design approval status
- Task breakdown
- Dependencies
- Related modules

## Filtering Options

- `--active`: Only modules in progress
- `--completed`: Only finished modules
- `--planned`: Only backlog modules
- `--phase=[phase]`: Filter by current phase
- `--search=[term]`: Search in names/descriptions

## Next Steps

Based on module status:
- Select a planned module: Use `/spec-create [module-name]`
- Continue active module: Use `/spec-status [module-name]`
- Review completed module: Check tasks.md for details
- Start new module: Plan it first, then `/spec-create`