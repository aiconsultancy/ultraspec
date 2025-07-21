# CLAUDE.md

This file provides guidance to Claude Code when working with code in this repository.

## Project Overview

[PROJECT DESCRIPTION - Update this section with your project details]

### Technology Stack
- [PRIMARY LANGUAGE/FRAMEWORK]
- [DATABASE]
- [KEY LIBRARIES]

### Project Structure
```
src/
├── [main source directories]
tests/
├── [test directories]
docs/
└── specs/          # Spec-driven development documentation
```

## Essential Commands

All commands are standardized through the Makefile:

```bash
# Core development commands
make init      # Initialize project dependencies
make build     # Build the project
make test      # Run tests
make format    # Format code (automatically run by hooks)
make lint      # Run linters
make clean     # Clean build artifacts

# Additional commands
make run       # Run the application
make dev       # Run in development/watch mode
make help      # Show all available commands
```

The Makefile provides a consistent interface across all technology stacks. Stack-specific commands are implemented in the Makefile based on your project type.

## Spec-Driven Development Workflow

This project follows a spec-driven methodology for feature development.

### Workflow Commands

#### Spec-Driven Development
- `/spec-create [module]` - Create new spec module
- `/spec-reqs` - Generate requirements
- `/spec-design` - Create technical design  
- `/spec-tasks` - Generate task list
- `/spec-execute [task]` - Implement specific task
- `/spec-status` - Check progress
- `/spec-list` - View all specs

#### Git Workflow
- `/commit [ticket-id]` - Commit staged changes
- `/create-commits [ticket-id]` - Create atomic commits
- `/create-pr` - Create pull request

#### Maintenance
- `/self-improve` - Analyze and improve project

### Workflow Philosophy

#### Core Principles
- **Structured Development**: Follow the sequential phases without skipping
- **User Approval Required**: Each phase must be explicitly approved
- **Atomic Implementation**: Execute one task at a time
- **Requirement Traceability**: All tasks reference specific requirements
- **Test-Driven Development**: MANDATORY for all implementation

### Detailed Workflow Process

#### Phase 1: Requirements (`/spec-reqs`)
- User stories: "As a [role], I want [feature], so that [benefit]"
- Acceptance criteria in GIVEN-WHEN-THEN format
- Include edge cases and non-functional requirements
- **MUST** get approval before proceeding

#### Phase 2: Design (`/spec-design`)
- Technical architecture based on requirements
- Component design, data models, interfaces
- Include diagrams where helpful
- Follow existing patterns in codebase
- **MUST** get approval before proceeding

#### Phase 3: Tasks (`/spec-tasks`)
- Break design into atomic, executable tasks
- Each task references requirements
- Include complexity estimates (XS/S/M/L)
- Exclude deployment and operational tasks
- **MUST** get approval before proceeding

#### Phase 4: Implementation (`/spec-execute`)
- Execute ONE task at a time
- **MANDATORY TDD Approach**:
  - RED: Write failing tests first
  - GREEN: Minimal code to pass tests
  - REFACTOR: Improve code quality
- Update tasks.md after completion
- Stop for review after each task

### Workflow Rules
- **Sequential**: Requirements → Design → Tasks → Implementation
- **Approval Gates**: Wait for explicit approval at each phase
- **Single Task**: Only one task in progress at a time
- **TDD Mandatory**: No implementation without tests
- **Traceability**: All work traces to requirements

## Test-Driven Development (TDD)

**CRITICAL**: All implementation MUST follow TDD methodology.

### TDD Workflow
1. **RED**: Write failing tests that define behavior
2. **GREEN**: Write minimal code to pass tests
3. **REFACTOR**: Improve code while keeping tests green

### TDD Rules
- Write test file before implementation file
- Tests define the API/interface
- Commit after each RED-GREEN-REFACTOR cycle
- A task isn't complete without passing tests

### Test Organization
- [Your test file organization pattern]
- [Test naming conventions]
- [Test framework details]

## Code Standards

### General Principles
- Follow existing patterns in the codebase
- Keep functions/methods small and focused
- Use descriptive names
- Handle errors appropriately
- Write self-documenting code

### Formatting
- Auto-formatting is configured via post-hook
- Run formatter before committing
- [Additional formatting rules]

### [Language-Specific Standards]
[Add your language-specific coding standards]

## Documentation Structure

All feature documentation lives in `docs/specs/`:

```
docs/specs/
└── [module-name]/
    ├── reqs.md      # Requirements document
    ├── design.md    # Technical design
    └── tasks.md     # Implementation tasks
```

### Documentation Rules
1. All specs must be in `docs/specs/`
2. Follow the template structure exactly
3. Keep documentation up-to-date
4. Mark tasks complete as you progress

## Development Workflow

### Before Starting Work
1. Check `/spec-status` for current state
2. Read all relevant documentation
3. Understand existing patterns

### During Development  
1. Follow TDD strictly
2. Make atomic commits
3. Keep tests passing
4. Update documentation

### After Completing Tasks
1. Ensure all tests pass
2. Run formatter/linter
3. Update tasks.md
4. Wait for review

## Environment Setup

### Required Tools
- [Tool 1]
- [Tool 2]

### Environment Variables
```bash
# Create .env.example (never commit .env)
VARIABLE_NAME=example_value
```

## Common Operations

### Running Tests
```bash
[Your test command]
```

### Building the Project
```bash
[Your build command]
```

### Starting Development Server
```bash
[Your dev server command]
```

## Troubleshooting

### Common Issues
[Add common issues and solutions]

## Additional Notes

[Any project-specific information that doesn't fit above]