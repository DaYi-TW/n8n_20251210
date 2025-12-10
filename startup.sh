#!/bin/bash
# Development Session Startup Script
# Automates: git pull, code review, handover reading, and next step suggestions

set -e

echo "=================================="
echo "🚀 Starting Development Session"
echo "=================================="
echo ""

# 1. Pull latest code from GitHub
echo "📥 Pulling latest code from GitHub..."
if git pull origin main 2>/dev/null || git pull origin master 2>/dev/null; then
    echo "✅ Code updated successfully"
else
    echo "⚠️  No remote configured yet or pull failed"
fi
echo ""

# 2. Review recent code changes
echo "📝 Recent Code Changes (last 5 commits):"
echo "----------------------------------------"
git log --oneline --decorate -5 2>/dev/null || echo "No git history yet"
echo ""

# Show uncommitted changes if any
if [[ -n $(git status -s 2>/dev/null) ]]; then
    echo "⚠️  Uncommitted Changes:"
    git status -s
    echo ""
fi

# 3. Read handover document
echo "📖 Reading Handover Documentation..."
echo "----------------------------------------"
if [ -f "handover.md" ]; then
    cat handover.md
    echo ""
else
    echo "ℹ️  No handover.md found (this is your first session or previous session had no handover)"
    echo ""
fi

# 4. Suggest next steps based on OpenSpec state
echo "🎯 Suggested Next Steps:"
echo "----------------------------------------"

# Check for active OpenSpec changes
if command -v openspec &> /dev/null; then
    active_changes=$(openspec list 2>/dev/null | grep -c "^  " || echo "0")
    
    if [ "$active_changes" -gt 0 ]; then
        echo "📋 Active OpenSpec Changes:"
        openspec list
        echo ""
        
        # Find incomplete tasks
        for change_dir in openspec/changes/*/; do
            if [ -d "$change_dir" ] && [ ! -d "${change_dir}archive" ]; then
                change_name=$(basename "$change_dir")
                if [ -f "${change_dir}tasks.md" ]; then
                    incomplete=$(grep -c "^- \[ \]" "${change_dir}tasks.md" 2>/dev/null || echo "0")
                    if [ "$incomplete" -gt 0 ]; then
                        echo "   → Continue work on: $change_name ($incomplete tasks remaining)"
                    fi
                fi
            fi
        done
    else
        echo "✨ No active OpenSpec changes"
        echo "   → Consider creating a new change with: openspec (or review project.md)"
    fi
else
    echo "ℹ️  OpenSpec not installed"
fi

echo ""
echo "=================================="
echo "✅ Ready to code! Happy hacking! 🎉"
echo "=================================="
