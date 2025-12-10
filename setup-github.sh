#!/bin/bash
# GitHub Repository Setup Script
# Run this once to create and connect to your GitHub repository

echo "=================================="
echo "🔧 GitHub Repository Setup"
echo "=================================="
echo ""

# Check if git is installed
if ! command -v git &> /dev/null; then
    echo "❌ Error: Git is not installed or not in PATH"
    echo "Please install Git from: https://git-scm.com/downloads"
    exit 1
fi

# Initialize git repository if not already initialized
if [ ! -d ".git" ]; then
    echo "📦 Initializing git repository..."
    git init
    git config user.name "DaYi-TW"
    git config user.email "kirito203203@gmail.com"
    echo "✅ Git repository initialized"
else
    echo "✅ Git repository already exists"
fi

# Create initial commit
if [ -z "$(git log --oneline 2>/dev/null)" ]; then
    echo ""
    echo "📝 Creating initial commit..."
    git add -A
    git commit -m "Initial commit: Add dev workflow scripts and OpenSpec setup"
    echo "✅ Initial commit created"
fi

# Check if remote exists
if git remote get-url origin &> /dev/null; then
    echo ""
    echo "✅ Remote 'origin' already configured:"
    git remote get-url origin
else
    echo ""
    echo "🔗 Setting up GitHub remote..."
    git remote add origin https://github.com/DaYi-TW/n8n.git
    echo "✅ Remote added: https://github.com/DaYi-TW/n8n.git"
fi

echo ""
echo "=================================="
echo "📋 Next Steps:"
echo "=================================="
echo ""
echo "1. Create the repository on GitHub:"
echo "   Go to: https://github.com/new"
echo "   - Repository name: n8n"
echo "   - Visibility: Public"
echo "   - DO NOT initialize with README (we already have one)"
echo ""
echo "2. Push your code:"
echo "   git branch -M main"
echo "   git push -u origin main"
echo ""
echo "3. Or run this command to push now:"
echo "   git branch -M main && git push -u origin main"
echo ""
echo "=================================="
echo "✅ Setup Complete!"
echo "=================================="
