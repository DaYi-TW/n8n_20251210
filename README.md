# n8n Development Project

Development workspace for n8n workflows and automation.

## Quick Start

### Development Session Scripts

This project includes automated workflow scripts to streamline your development sessions:

**Starting a session:**
```bash
./startup.sh
```
This will:
- Pull latest code from GitHub
- Review recent changes
- Read handover documentation from previous session
- Suggest next steps based on active OpenSpec changes

**Ending a session:**
```bash
./ending.sh
```
This will:
- Prompt you to review task progress
- Validate OpenSpec changes
- Archive completed changes (with confirmation)
- Write handover documentation for next session
- Commit and push changes to GitHub

### Requirements

- Git installed and configured
- Bash or Git Bash (on Windows)
- OpenSpec CLI (install with `npm install -g openspec`)

### GitHub Setup

Repository owner: **DaYi-TW**  
Email: kirito203203@gmail.com

## Project Structure

```
.
├── openspec/              # OpenSpec change management
│   ├── changes/          # Active change proposals
│   ├── specs/            # Deployed specifications
│   └── project.md        # Project conventions
├── .agent/               # Agent workflows
├── startup.sh            # Dev session startup script
├── ending.sh             # Dev session ending script
└── handover.md          # Auto-generated handover docs
```

## OpenSpec Workflow

This project uses [OpenSpec](https://github.com/openspec-dev/openspec) for spec-driven development. See `openspec/AGENTS.md` for detailed workflow instructions.

## License

MIT
