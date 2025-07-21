---
title: 'Generate Implementation Tasks'
name: spec-tasks
description: Creates task list based on approved design
read_only: false
type: 'command'
prerequisites: Completed and approved design (design.md)
---

# Generate Implementation Tasks

Creates an actionable task list for implementing the approved design.

## Overview

- Breaks down design into atomic, executable tasks
- Each task references specific requirements
- Includes complexity estimates
- Follows TDD approach for all tasks

## Process Flow

1. **Analyze Design Document**
   - Review all components and interfaces
   - Identify implementation dependencies
   - Consider testing requirements

2. **Create Atomic Tasks**
   - Each task should be completable in 1-4 hours
   - Tasks must be independently testable
   - Include both implementation and test writing

3. **Add Requirement References**
   - Each task links to specific requirement(s)
   - Format: `_Requirements: Story X, Criteria Y_`

4. **Estimate Complexity**
   - XS: < 1 hour
   - S: 1-2 hours
   - M: 2-4 hours
   - L: 4-8 hours (consider breaking down)

5. **Order by Dependencies**
   - Foundation tasks first
   - Dependent tasks follow
   - Testing tasks alongside implementation

## Task List Template

```markdown
# Tasks: [Module Name]

## Overview
Implementation tasks for [module name] based on approved design.

## Task List

### Foundation Tasks

- [ ] **[T-001]** Create base [component] structure _(S)_
  _Requirements: Story 1_
  - Set up file structure
  - Create interfaces/types
  - Write initial tests

- [ ] **[T-002]** Implement [model/entity] with validation _(M)_
  _Requirements: Story 1, Criteria 1-3_
  - Define data model
  - Add validation rules
  - Write comprehensive tests

### Core Implementation

- [ ] **[T-003]** Implement [feature] handler/service _(M)_
  _Requirements: Story 2, Criteria 1-2_
  - Create service class/module
  - Implement core logic
  - Write unit tests
  - Handle error cases

- [ ] **[T-004]** Create API endpoint for [operation] _(S)_
  _Requirements: Story 2, Criteria 3_
  - Define route/endpoint
  - Add request validation
  - Connect to service layer
  - Write integration tests

### Integration Tasks

- [ ] **[T-005]** Integrate with [external service/component] _(M)_
  _Requirements: Story 3_
  - Create adapter/connector
  - Handle connection errors
  - Add retry logic
  - Write integration tests

### Testing & Quality

- [ ] **[T-006]** Add performance tests for [critical path] _(S)_
  _Requirements: NFR-Performance_
  - Create load test scenarios
  - Establish baselines
  - Document results

## Task Execution Notes

1. Follow TDD for all implementation tasks:
   - RED: Write failing tests first
   - GREEN: Implement minimal code to pass
   - REFACTOR: Improve code quality

2. Complete tasks in order unless dependencies allow parallel work

3. Each task completion includes:
   - All tests passing
   - Code review ready
   - Documentation updated

## Excluded Tasks
These are NOT included (handled separately):
- Deployment configuration
- User acceptance testing
- Production monitoring setup
- User documentation
```

## Usage Examples

```bash
# Generate tasks for module with approved design
/spec-tasks user-authentication

# Regenerate tasks after design updates
/spec-tasks payment-processing
```

## Rules/Restrictions

- MUST have approved design first
- Every task must reference requirements
- Tasks should be atomic and testable
- Include complexity estimates
- Exclude non-development tasks
- Follow TDD approach mandatory

## Next Steps

After tasks are approved:
1. Use `/spec-execute [task-id]` to implement specific tasks
2. Complete tasks one at a time
3. Mark tasks complete in tasks.md
4. Use `/spec-status` to track progress