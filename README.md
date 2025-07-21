# Ultraspec - Spec-Driven Development for Claude Code

[![GitHub](https://img.shields.io/github/license/aiconsultancy/ultraspec)](https://github.com/aiconsultancy/ultraspec/blob/main/LICENSE)
[![Claude Code Compatible](https://img.shields.io/badge/Claude_Code-Compatible-blue)](https://claude.ai/code)

Ultraspec is a comprehensive template for implementing spec-driven development workflows with [Claude Code](https://claude.ai/code). It provides a structured approach to feature development, ensuring requirements are well-defined, designs are thoughtful, and implementation follows test-driven development practices.

**Repository**: [https://github.com/aiconsultancy/ultraspec](https://github.com/aiconsultancy/ultraspec)

## Features

- **Spec-Driven Workflow**: Requirements → Design → Tasks → Implementation
- **Platform Agnostic**: Works with any technology stack
- **Makefile Interface**: Consistent commands across all projects
- **Security Hooks**: Protects against dangerous commands and sensitive file access
- **Auto-Formatting**: Automatic code formatting on file changes
- **TDD Enforcement**: Mandatory test-driven development approach
- **Stack Templates**: Pre-configured for .NET, Node.js, Bun, and Go
- **Multi-Stack Support**: Combine frontend and backend technologies

## Quick Start

### Option 1: Quick Install (Recommended)

#### Super Quick (2 prompts)
```bash
curl -fsSL https://raw.githubusercontent.com/aiconsultancy/ultraspec/main/quick-install.sh | bash
```

#### With Options
```bash
curl -fsSL https://raw.githubusercontent.com/aiconsultancy/ultraspec/main/install.sh | bash -s -- \
  --name "My App" \
  --stack node-pnpm \
  --path ~/projects/myapp
```

#### Interactive
```bash
curl -fsSL https://raw.githubusercontent.com/aiconsultancy/ultraspec/main/install.sh | bash
```

### Option 2: Manual Installation

```bash
# Clone ultraspec
git clone https://github.com/aiconsultancy/ultraspec.git

# Initialize a new project
./ultraspec/init-ultraspec.sh ~/projects/myapp --stack node-pnpm --name "My App"
```

### After Installation

```bash
# Navigate to your project
cd ~/projects/myapp

# Start using spec workflow
# In Claude Code, use: /spec-create user-authentication
```

## Workflow Commands

All commands are available as slash commands in Claude Code:

### Spec-Driven Development
- `/spec-create [name]` - Create a new spec module
- `/spec-reqs` - Generate requirements document
- `/spec-design` - Create technical design
- `/spec-tasks` - Generate implementation tasks
- `/spec-execute [task]` - Implement a specific task
- `/spec-status` - Check module progress
- `/spec-list` - List all spec modules

### Git Workflow
- `/commit [ticket-id]` - Create a single commit from staged changes
- `/create-commits [ticket-id]` - Create multiple atomic commits from unstaged changes
- `/create-pr` - Create a pull request with AI-generated description

### Project Maintenance
- `/self-improve` - Analyze project and suggest improvements

## Project Structure

```
your-project/
├── .claude/
│   ├── settings.json      # Permissions and hooks
│   ├── commands/          # Spec workflow commands
│   └── hooks/             # Pre/post tool hooks
├── CLAUDE.md              # Project guidance for Claude
├── Makefile               # Standardized commands
└── docs/
    └── specs/             # Feature specifications
        └── feature-name/
            ├── reqs.md    # Requirements
            ├── design.md  # Technical design
            └── tasks.md   # Implementation tasks
```

## Available Stacks

### Single Stack Options

#### .NET (C#)
- Clean Architecture structure
- Entity Framework Core
- xUnit for testing
- `make migrate` for database migrations

#### Node.js + pnpm
- TypeScript support
- Fast package management
- Vitest/Jest testing
- ESLint + Prettier

#### Bun
- Native TypeScript execution
- Built-in SQLite support
- Fast runtime performance
- Integrated test runner

#### Go
- Standard project layout
- Clean Architecture
- Built-in testing
- golangci-lint integration

### Multi-Stack Options

When choosing multi-stack, you can combine:

**Frontend Options:**
- React + Vite + pnpm
- React + Vite + Bun
- Vue + Vite + pnpm  
- Next.js + pnpm

**Backend Options:**
- Node.js + Express + TypeScript
- .NET Web API
- Go + Gin/Echo
- Bun + Elysia

The multi-stack setup includes:
- Unified Makefile commands
- Docker Compose for services
- Coordinated frontend/backend development
- Shared type definitions support

## Makefile Commands

All projects include these standard commands:

```bash
make init      # Initialize dependencies
make build     # Build the project
make test      # Run tests
make format    # Format code
make lint      # Run linters
make clean     # Clean artifacts
make run       # Run application
make dev       # Development mode
make help      # Show all commands
```

### Multi-Stack Commands

Multi-stack projects have additional commands:

```bash
# Run both stacks
make dev              # Start frontend and backend
make test             # Test both stacks

# Stack-specific commands  
make frontend-dev     # Frontend only
make backend-dev      # Backend only
make frontend-test    # Test frontend only
make backend-test     # Test backend only

# Docker services
make services-up      # Start DB, Redis, etc.
make services-down    # Stop services
make test-integration # Full integration tests
```

## Security Features

### Pre-Tool Hook
- Blocks dangerous `rm -rf` commands
- Prevents access to `.env` and `.envrc` files
- Allows `.env.sample` and `.env.example`
- Customizable security rules

### Post-Tool Hook
- Automatically runs `make format` after file changes
- Only triggers on Edit/Write operations
- Skips if no Makefile or format target

## Spec-Driven Workflow

### 1. Requirements Phase
- User stories with acceptance criteria
- GIVEN-WHEN-THEN format
- Edge cases and non-functional requirements
- Must be approved before design

### 2. Design Phase
- Technical architecture
- Component diagrams
- Data models and interfaces
- Must be approved before tasks

### 3. Tasks Phase
- Atomic, testable tasks
- Complexity estimates (XS/S/M/L)
- Requirements traceability
- Must be approved before implementation

### 4. Implementation Phase
- One task at a time
- Mandatory TDD approach
- Stop for review after each task
- Update progress in tasks.md

## Customization

### Adding Custom Commands
1. Create new `.md` file in `.claude/commands/`
2. Follow the existing command format
3. Commands are automatically available

### Modifying Hooks
1. Edit `.claude/hooks/pre_tool_use.sh` for security
2. Edit `.claude/hooks/post_tool_use.sh` for formatting
3. Hooks run automatically based on settings.json

### Stack-Specific Configuration
1. Update the Makefile for your tools
2. Modify CLAUDE.md with project details
3. Add stack-specific guidance

## Best Practices

1. **Always Start with Specs**: Use `/spec-create` before coding
2. **Get Approvals**: Each phase needs explicit approval
3. **One Task at a Time**: Focus on single tasks during implementation
4. **TDD is Mandatory**: Write tests first, always
5. **Update Progress**: Mark tasks complete as you go
6. **Use Make Commands**: Consistent interface across all operations

## Troubleshooting

### Formatter Not Running
- Check if Makefile has a `format` target
- Ensure file path matches your language files
- Verify hook permissions: `chmod +x .claude/hooks/*.sh`

### Commands Not Found
- Ensure `.claude/commands/` contains the command files
- Check command file has proper frontmatter
- Restart Claude Code session if needed

### Permission Errors
- Run `chmod +x .claude/hooks/*.sh`
- Check file ownership
- Ensure .claude directory is accessible

## Contributing

To add new stack templates:
1. Create directory in `stacks/[stack-name]/`
2. Add `Makefile` with standard targets
3. Add `CLAUDE.md.template` with stack guidance
4. Update `init-ultraspec.sh` with new option

## Contributing

Contributions are welcome! To contribute:

1. Fork the repository
2. Create a feature branch
3. Make your changes
4. Submit a pull request

Please ensure your contributions follow the existing patterns and include appropriate documentation.

## Support

For issues, questions, or suggestions:
- Open an issue on [GitHub](https://github.com/aiconsultancy/ultraspec/issues)
- Check existing issues for solutions
- Provide detailed information for bug reports

## License

MIT License - see [LICENSE](LICENSE) file for details
