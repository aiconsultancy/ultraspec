---
title: 'Execute Implementation Task'
name: spec-execute
description: Executes a specific task from the approved task list
read_only: false
type: 'command'
prerequisites: Approved task list (tasks.md)
---

# Execute Implementation Task

Implements a single task from the approved task list following TDD methodology.

## Overview

- Executes ONE task at a time
- Mandatory TDD approach (Red-Green-Refactor)
- Updates task status on completion
- Stops for review after each task

## Process Flow

1. **Load Context**
   - Read reqs.md for requirements context
   - Read design.md for technical approach
   - Read tasks.md for specific task details
   - Identify the requested task

2. **TDD Implementation**
   - **RED Phase**:
     - Write failing tests first
     - Define expected behavior
     - Cover edge cases
   - **GREEN Phase**:
     - Write minimal code to pass tests
     - Focus only on making tests pass
   - **REFACTOR Phase**:
     - Improve code quality
     - Ensure all tests still pass
     - Follow project conventions

3. **Validate Implementation**
   - Ensure all tests pass
   - Check requirements are met
   - Verify design compliance
   - Run linting/formatting

4. **Update Status**
   - Mark task as complete in tasks.md
   - Update any progress tracking
   - Stop and wait for review

## Execution Guidelines

### TDD Example Flow

```markdown
Task: Implement user validation service

1. RED - Write failing tests:
   - Test email validation
   - Test password requirements
   - Test error handling

2. GREEN - Implement minimal code:
   - Add validation logic
   - Return appropriate errors
   - Make all tests pass

3. REFACTOR - Improve implementation:
   - Extract constants
   - Improve error messages
   - Add documentation
```

### Code Organization

- Place tests near implementation files
- Follow project structure conventions
- Use consistent naming patterns
- Keep commits atomic per TDD cycle

## Usage Examples

```bash
# Execute a specific task by ID
/spec-execute T-001

# Execute the next incomplete task
/spec-execute next

# Execute with specific context
/spec-execute T-003 --focus-on-error-handling
```

## Rules/Restrictions

- Only ONE task per execution
- TDD is MANDATORY - no exceptions
- Cannot skip to implementation without tests
- Must complete current task before starting next
- All tests must pass before marking complete
- Stop after task completion for review

## Error Handling

- **Blocked by dependency**: Document blocker, suggest next task
- **Unclear requirements**: Ask for clarification, don't assume
- **Test failures**: Fix code, not tests (unless tests are wrong)
- **Design conflicts**: Raise for discussion, don't deviate

## Task Completion Checklist

Before marking a task complete:
- [ ] All tests written and passing
- [ ] Code follows project conventions
- [ ] Requirements referenced are satisfied
- [ ] No TODO comments left unresolved
- [ ] Code is properly formatted
- [ ] Task marked complete in tasks.md

## Next Steps

After task completion:
1. Review implementation with user
2. Address any feedback
3. Use `/spec-status` to see progress
4. Execute next task when ready