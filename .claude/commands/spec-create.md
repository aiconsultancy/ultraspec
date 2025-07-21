---
title: 'Create New Spec Module'
name: spec-create
description: Creates a new spec module in the documentation structure
read_only: false
type: 'command'
---

# Create New Spec Module

Creates a new spec module with the standard structure for spec-driven development.

## Overview

- Creates directory structure: `docs/specs/{module-name}/`
- Generates initial files: `reqs.md`, `design.md`, `tasks.md`
- Sets up module for spec-driven workflow
- Follows naming pattern: `{module-name}`

## Process Flow

1. **Validate Module Name**
   - Check if module already exists
   - Ensure name follows conventions (lowercase, hyphens)
   - Confirm with user before creation

2. **Create Directory Structure**
   - Create `docs/specs/{module-name}/` directory
   - Initialize with template files
   - Set proper permissions

3. **Generate Initial Files**
   - `reqs.md` - Requirements template
   - `design.md` - Design document template
   - `tasks.md` - Task list template

## Usage Examples

```bash
# Create a new module
/spec-create user-authentication

# Create a module with compound name
/spec-create payment-processing
```

## Module Structure

```
docs/specs/{module-name}/
├── reqs.md      # Requirements (user stories, acceptance criteria)
├── design.md    # Technical design and architecture
└── tasks.md     # Implementation task list
```

## Rules/Restrictions

- Module names must be lowercase with hyphens
- Cannot create duplicate modules
- Must follow spec-driven workflow after creation
- NEVER skip directly to implementation

## Next Steps

After creating a module:
1. Use `/spec-reqs` to generate requirements
2. Get requirements approved
3. Use `/spec-design` to create technical design
4. Get design approved
5. Use `/spec-tasks` to generate task list
6. Use `/spec-execute` to implement tasks