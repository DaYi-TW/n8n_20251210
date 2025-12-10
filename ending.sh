#!/bin/bash
# Development Session Ending Script
# Automates: task updates, validation, archiving, handover writing, and git push

set -e

echo "=================================="
echo "🏁 Ending Development Session"
echo "=================================="
echo ""

# 1. Update task.md with current progress
echo "📝 Checking for task updates..."
echo "----------------------------------------"

# Check if there are active changes with tasks
has_tasks=false
for change_dir in openspec/changes/*/; do
    if [ -d "$change_dir" ] && [ ! -d "${change_dir}archive" ]; then
        if [ -f "${change_dir}tasks.md" ]; then
            has_tasks=true
            change_name=$(basename "$change_dir")
            echo "📋 Tasks in: $change_name"
            echo ""
            cat "${change_dir}tasks.md"
            echo ""
        fi
    fi
done

if [ "$has_tasks" = false ]; then
    echo "ℹ️  No active task files found"
fi
echo ""

# 2. Validate OpenSpec changes
echo "✅ Validating OpenSpec changes..."
echo "----------------------------------------"
if command -v openspec &> /dev/null; then
    if openspec list 2>/dev/null | grep -q "^  "; then
        # Validate each active change
        for change_dir in openspec/changes/*/; do
            if [ -d "$change_dir" ] && [ ! -d "${change_dir}archive" ]; then
                change_name=$(basename "$change_dir")
                echo "Validating: $change_name"
                if openspec validate "$change_name" --strict 2>/dev/null; then
                    echo "✅ $change_name is valid"
                    
                    # Check if all tasks are complete
                    if [ -f "${change_dir}tasks.md" ]; then
                        incomplete=$(grep -c "^- \[ \]" "${change_dir}tasks.md" 2>/dev/null || echo "0")
                        if [ "$incomplete" -eq 0 ]; then
                            echo "🎉 All tasks complete for $change_name!"
                            echo -n "Archive this change? (y/N): "
                            read -r response
                            if [[ "$response" =~ ^[Yy]$ ]]; then
                                echo "📦 Archiving $change_name..."
                                openspec archive "$change_name" --yes || echo "⚠️  Archive failed"
                            fi
                        fi
                    fi
                else
                    echo "❌ Validation failed for $change_name"
                fi
                echo ""
            fi
        done
    else
        echo "ℹ️  No active changes to validate"
    fi
else
    echo "⚠️  OpenSpec not installed, skipping validation"
fi
echo ""

# 3. Write handover documentation
echo "📄 Writing handover documentation..."
echo "----------------------------------------"

cat > handover.md << 'EOF'
# Handover Document
*Auto-generated on: $(date '+%Y-%m-%d %H:%M:%S')*

## Session Summary
EOF

# Add git status
echo "" >> handover.md
echo "### Changes Made" >> handover.md
if [[ -n $(git status -s 2>/dev/null) ]]; then
    echo "\`\`\`" >> handover.md
    git status -s >> handover.md
    echo "\`\`\`" >> handover.md
else
    echo "No uncommitted changes" >> handover.md
fi

# Add active OpenSpec changes
echo "" >> handover.md
echo "### Active OpenSpec Changes" >> handover.md
if command -v openspec &> /dev/null && openspec list 2>/dev/null | grep -q "^  "; then
    echo "\`\`\`" >> handover.md
    openspec list >> handover.md
    echo "\`\`\`" >> handover.md
    
    # Add task status
    for change_dir in openspec/changes/*/; do
        if [ -d "$change_dir" ] && [ ! -d "${change_dir}archive" ]; then
            change_name=$(basename "$change_dir")
            if [ -f "${change_dir}tasks.md" ]; then
                echo "" >> handover.md
                echo "#### Tasks for $change_name" >> handover.md
                incomplete=$(grep -c "^- \[ \]" "${change_dir}tasks.md" 2>/dev/null || echo "0")
                inprogress=$(grep -c "^- \[/\]" "${change_dir}tasks.md" 2>/dev/null || echo "0")
                complete=$(grep -c "^- \[x\]" "${change_dir}tasks.md" 2>/dev/null || echo "0")
                echo "- Incomplete: $incomplete" >> handover.md
                echo "- In Progress: $inprogress" >> handover.md
                echo "- Complete: $complete" >> handover.md
            fi
        fi
    done
else
    echo "No active changes" >> handover.md
fi

# Add next steps
echo "" >> handover.md
echo "### Next Steps" >> handover.md
echo "- Review the changes above" >> handover.md
echo "- Continue working on incomplete tasks" >> handover.md
echo "- Run \`./startup.sh\` to begin next session" >> handover.md

echo "✅ Handover written to handover.md"
echo ""

# 4. Push code to GitHub
echo "🚀 Pushing code to GitHub..."
echo "----------------------------------------"

# Configure git if not already configured
if [ -z "$(git config user.name)" ]; then
    git config user.name "DaYi-TW"
    echo "✅ Set git user.name to DaYi-TW"
fi

if [ -z "$(git config user.email)" ]; then
    git config user.email "kirito203203@gmail.com"
    echo "✅ Set git user.email to kirito203203@gmail.com"
fi

# Check if there are changes to commit
if [[ -n $(git status -s 2>/dev/null) ]]; then
    echo "Staging all changes..."
    git add -A
    
    echo -n "Enter commit message (or press Enter for default): "
    read -r commit_msg
    
    if [ -z "$commit_msg" ]; then
        commit_msg="Dev session update - $(date '+%Y-%m-%d %H:%M')"
    fi
    
    git commit -m "$commit_msg"
    echo "✅ Changes committed"
    
    # Push to remote
    echo "Pushing to GitHub..."
    if git push 2>/dev/null; then
        echo "✅ Code pushed to GitHub successfully"
    else
        echo "⚠️  Push failed. You may need to:"
        echo "   1. Create the repository on GitHub first"
        echo "   2. Add remote with: git remote add origin https://github.com/DaYi-TW/n8n.git"
        echo "   3. Push with: git push -u origin main"
    fi
else
    echo "ℹ️  No changes to commit"
fi

echo ""
echo "=================================="
echo "✅ Session Complete! See you next time! 👋"
echo "=================================="
