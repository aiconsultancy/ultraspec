---
title: 'Self Improve'
name: self-improve
description: Analyze and improve project configuration and practices
read_only: false
type: 'command'
---

# Self Improve

Analyzes the current project and suggests improvements to configuration, practices, and workflow.

## Overview

This command helps improve your project by:
- Analyzing current setup and configurations
- Suggesting best practices for your stack
- Identifying missing configurations
- Recommending workflow improvements
- Updating outdated patterns

## Analysis Areas

### 1. **Project Configuration**
- Check for missing configuration files
- Validate existing configs
- Suggest stack-specific improvements
- Ensure consistency across configs

### 2. **Development Workflow**
- Review Makefile targets
- Check CI/CD setup
- Analyze git hooks
- Validate testing setup

### 3. **Code Quality**
- Linting configuration
- Formatting rules
- Type checking setup
- Testing coverage

### 4. **Documentation**
- README completeness
- API documentation
- Code comments
- Spec documentation

### 5. **Security**
- Environment variable handling
- Dependency vulnerabilities
- Security headers
- Authentication patterns

## Process Flow

1. **Detect Project Type**
   - Identify technology stack
   - Check for framework markers
   - Analyze dependencies

2. **Run Analysis**
   - Check each area systematically
   - Compare against best practices
   - Identify gaps and issues

3. **Generate Report**
   ```markdown
   ## Project Analysis Report
   
   ### ✅ Good Practices Found
   - [List of things done well]
   
   ### ⚠️ Improvements Suggested
   - [List of improvements with priority]
   
   ### 🔧 Quick Fixes
   - [Immediate actions available]
   
   ### 📋 Action Plan
   1. [Prioritized list of improvements]
   ```

4. **Offer Automatic Fixes**
   - Show what can be fixed automatically
   - Get user confirmation
   - Apply selected improvements

## Stack-Specific Checks

### Node.js/TypeScript
- Package.json scripts
- TypeScript config
- ESLint/Prettier setup
- Test configuration

### .NET
- Project file settings
- NuGet configurations
- Code analyzers
- Test projects

### Go
- Module configuration
- Linting tools
- Build optimization
- Test coverage

### Python
- Virtual environment
- Requirements management
- Type checking
- Code formatting

## Common Improvements

### Missing Files
```bash
# Often missing:
- .editorconfig
- .gitattributes
- CONTRIBUTING.md
- SECURITY.md
- .env.example
```

### Makefile Enhancements
```makefile
# Useful targets to add:
check: lint test
watch: dev
install: init
update: deps-update
```

### Git Improvements
```bash
# Pre-commit hooks
# Branch protection
# Commit message validation
```

## Usage Examples

```bash
# Run full analysis
/self-improve

# Focus on specific area
/self-improve --focus=security
/self-improve --focus=testing

# Auto-fix safe improvements
/self-improve --auto-fix
```

## Report Example

```
## Project Analysis Report

### ✅ Good Practices Found
- Makefile with standard targets
- TypeScript strict mode enabled
- Comprehensive .gitignore
- Environment example file

### ⚠️ Improvements Suggested

HIGH Priority:
- Add pre-commit hooks for formatting
- Configure test coverage reporting
- Add security headers middleware

MEDIUM Priority:
- Update TypeScript to latest version
- Add API documentation generation
- Configure dependabot

LOW Priority:
- Add performance monitoring
- Enhance logging configuration

### 🔧 Quick Fixes Available
1. Add .editorconfig file
2. Create pre-commit hook
3. Add test:coverage script
4. Update .gitignore patterns

Apply quick fixes? [y/N]
```

## Best Practices Database

The command maintains knowledge of best practices for:
- Project structure
- Configuration files
- Development workflows
- Testing strategies
- Deployment patterns
- Security measures

## Continuous Improvement

- Run periodically to catch drift
- After major dependency updates
- When adding new features
- Before major releases