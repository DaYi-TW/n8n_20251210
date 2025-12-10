# Change: Add Dev Workflow Scripts

## Why
Developers need automated workflow scripts to streamline daily development tasks including syncing code, reviewing context, and managing OpenSpec changes consistently.

## What Changes
- Add `startup.sh` - Automates development session startup
  - Pulls latest code from GitHub
  - Reviews recent code changes
  - Reads handover documentation
  - Suggests next steps based on context
- Add `ending.sh` - Automates development session wrap-up
  - Updates task.md with current progress
  - Validates OpenSpec changes
  - Archives completed changes
  - Writes handover documentation
  - Pushes code to GitHub

## Impact
- Affected specs: `dev-workflow` (new capability)
- Affected code: Root directory scripts (new files)
