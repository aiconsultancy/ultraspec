---
title: 'Generate Requirements Document'
name: spec-reqs
description: Creates or updates requirements document for a spec module
read_only: false
type: 'command'
---

# Generate Requirements Document

Creates a comprehensive requirements document following best practices for user stories and acceptance criteria.

## Overview

- Generates user stories in standard format
- Creates acceptance criteria using GIVEN-WHEN-THEN format
- Includes edge cases and non-functional requirements
- Requires approval before moving to design phase

## Process Flow

1. **Gather Context**
   - Understand the feature/module purpose
   - Identify key stakeholders and users
   - Clarify business objectives

2. **Generate User Stories**
   - Format: "As a [role], I want [feature], so that [benefit]"
   - Focus on user value, not implementation
   - Keep stories small and testable

3. **Create Acceptance Criteria**
   - Use GIVEN-WHEN-THEN format
   - Cover happy paths and edge cases
   - Include performance and security requirements
   - Number criteria for easy reference

4. **Request Approval**
   - Present requirements for review
   - Incorporate feedback
   - Get explicit approval before proceeding

## Requirements Template Structure

```markdown
# Requirements: [Module Name]

## Overview
[Brief description of the module's purpose and scope]

## User Stories

### Story 1: [Title]
**As a** [user role]  
**I want** [feature/capability]  
**So that** [business value/benefit]

**Acceptance Criteria:**
1. **GIVEN** [context/precondition]  
   **WHEN** [action/event]  
   **THEN** [expected outcome]

2. **GIVEN** [context]  
   **WHEN** [action]  
   **THEN** [outcome]

### Story 2: [Title]
[Continue pattern...]

## Non-Functional Requirements

### Performance
- [Requirement 1]
- [Requirement 2]

### Security
- [Requirement 1]
- [Requirement 2]

## Edge Cases
- [Edge case 1]
- [Edge case 2]

## Out of Scope
- [What this module will NOT do]
```

## Usage Examples

```bash
# Generate requirements for existing module
/spec-reqs user-authentication

# Update requirements with new stories
/spec-reqs payment-processing
```

## Rules/Restrictions

- Must have existing module created with `/spec-create`
- Cannot proceed to design without approval
- All stories must have acceptance criteria
- Include both functional and non-functional requirements

## Next Steps

After requirements are approved:
1. Use `/spec-design` to create technical design
2. Design will reference these requirements
3. All implementation tasks will trace back to requirements