#!/bin/bash

# =============================================================
# 🚀 Safe Push Script
# Runs tests before pushing to GitHub
# =============================================================

# Get current branch
BRANCH=$(git branch --show-current)

echo ""
echo "🚀 ============================================"
echo "   Safe Push Script"
echo "   Branch: $BRANCH"
echo "============================================"
echo ""

# ========== Step 1: Run Tests ==========
echo "🧪 Running Vitest tests..."
echo ""

npx vitest run

# Check if tests passed
if [ $? -ne 0 ]; then
  echo ""
  echo "❌ ============================================"
  echo "❌ TESTS FAILED! Push BLOCKED!"
  echo "❌ ============================================"
  echo ""
  echo "💡 Fix the failing tests above and try again."
  echo ""
  exit 1
fi

echo ""
echo "✅ All tests passed!"
echo ""

# ========== Step 2: Push to GitHub ==========
echo "🚀 Pushing to GitHub..."
echo ""

git push origin "$BRANCH"

# Check if push succeeded
if [ $? -eq 0 ]; then
  echo ""
  echo "🎉 ============================================"
  echo "🎉 Successfully pushed to GitHub!"
  echo "============================================"
  echo ""
else
  echo ""
  echo "❌ Push failed! Check the error above."
  echo ""
  exit 1
fi

