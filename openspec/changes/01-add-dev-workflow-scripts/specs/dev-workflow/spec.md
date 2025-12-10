## ADDED Requirements

### Requirement: Development Session Startup
The system SHALL provide a startup script that automates development session initialization.

#### Scenario: Starting a development session
- **WHEN** developer runs startup.sh
- **THEN** the script pulls latest code from GitHub
- **AND** reviews recent code changes
- **AND** reads handover documentation
- **AND** suggests next steps based on context

### Requirement: Development Session Ending
The system SHALL provide an ending script that automates development session wrap-up.

#### Scenario: Ending a development session
- **WHEN** developer runs ending.sh
- **THEN** the script updates task.md with current progress
- **AND** validates any OpenSpec changes
- **AND** archives completed changes if applicable
- **AND** writes handover documentation
- **AND** pushes code to GitHub
