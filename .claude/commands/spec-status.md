---
title: 'Show Spec Status'
name: spec-status
description: Displays current status of spec modules
read_only: true
type: 'command'
---

# Show Spec Status

Displays the current status and progress of spec modules.

## Overview

- Shows workflow phase for each module
- Displays completion progress
- Identifies next actions
- Provides quick health check

## Status Display Format

```
MODULE STATUS REPORT
==================

📁 user-authentication
   Phase: Design
   Progress: Requirements ✅ | Design 🔄 | Tasks ⏳
   Next: Complete design document for approval

📁 payment-processing  
   Phase: Implementation
   Progress: Requirements ✅ | Design ✅ | Tasks 🔄
   Tasks: 3/8 complete (37%)
   Current: T-004 - Create payment API endpoint
   
📁 notification-system
   Phase: Requirements
   Progress: Requirements 🔄 | Design ⏳ | Tasks ⏳
   Next: Finalize requirements for approval
```

## Status Symbols

- ✅ Completed and approved
- 🔄 In progress
- ⏳ Not started
- ❌ Blocked or has issues
- 📝 Awaiting approval

## Phase Definitions

1. **Requirements Phase**
   - Creating user stories
   - Defining acceptance criteria
   - Awaiting requirements approval

2. **Design Phase**
   - Creating technical design
   - Defining architecture
   - Awaiting design approval

3. **Tasks Phase**
   - Breaking down into tasks
   - Estimating complexity
   - Awaiting task list approval

4. **Implementation Phase**
   - Executing tasks
   - Following TDD approach
   - Tracking completion percentage

5. **Complete**
   - All tasks implemented
   - All tests passing
   - Ready for integration

## Usage Examples

```bash
# Show status of all modules
/spec-status

# Show status of specific module
/spec-status user-authentication

# Show only active modules
/spec-status --active

# Show detailed task breakdown
/spec-status payment-processing --detailed
```

## Information Displayed

### Summary View
- Module name and phase
- Progress indicators
- Next recommended action
- Blockers (if any)

### Detailed View
- All summary information
- Task list with completion status
- Recent activity
- File modification dates

## Next Steps

Based on status:
- **Requirements incomplete**: Use `/spec-reqs` to continue
- **Design incomplete**: Use `/spec-design` to continue  
- **Tasks incomplete**: Use `/spec-tasks` to continue
- **Implementation active**: Use `/spec-execute` for next task
- **Blocked**: Address blockers before continuing