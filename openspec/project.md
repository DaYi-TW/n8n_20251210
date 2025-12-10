# Project Context

## Purpose
n8n development workspace for workflow automation and integration projects.

## Tech Stack
- Bash scripting for workflow automation
- OpenSpec for spec-driven development
- Git/GitHub for version control

## Project Conventions

### Change Management
All OpenSpec changes MUST follow a numbered naming convention:
- Format: `{number}-{descriptive-name}`
- Number format: Two digits with leading zero (01-, 02-, 03-, etc.)
- Auto-increment: Each new change increments the number sequentially
- Examples: `01-add-user-auth`, `02-update-payment-flow`, `03-remove-legacy-api`

**Current counter: 02** (next change should use `02-`)

### Development Workflow
Two main scripts automate development sessions:

**startup.sh** - Start your dev session:
- Pulls latest code from GitHub
- Reviews recent commits
- Reads handover documentation
- Suggests next steps based on active changes

**ending.sh** - End your dev session:
- Updates task progress
- Validates OpenSpec changes  
- Archives completed changes
- Writes handover for next session
- Commits and pushes to GitHub

### Git Workflow
- Repository: https://github.com/DaYi-TW/n8n
- Owner: DaYi-TW
- Email: kirito203203@gmail.com
- Branch strategy: main branch for active development
- Always run `./ending.sh` before ending your session to ensure work is pushed

### Code Style
- Use clear, descriptive variable names
- Comment complex logic
- Follow existing patterns in codebase

### Testing Strategy
- Manual testing of workflow scripts
- Validate OpenSpec changes with `openspec validate --strict`
- Test automation scripts in isolation before relying on them

## Domain Context
This is a development environment for building and managing n8n workflows. The project emphasizes automation and reproducible development practices using OpenSpec for specification-driven development.

## Important Constraints
- Windows environment using PowerShell/Git Bash
- Requires Git and OpenSpec CLI tools installed
- Scripts assume bash-compatible shell (Git Bash on Windows)

## External Dependencies
- OpenSpec CLI: `npm install -g openspec`
- Git for version control
- GitHub for remote repository hosting

