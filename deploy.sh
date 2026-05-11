#!/bin/bash

# =============================================================
# 🚀 Enhanced Safe Push Script
# =============================================================

# Colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m' # No Color

# Get current branch
BRANCH=$(git branch --show-current)

echo ""
echo -e "${BLUE}╔══════════════════════════════════════════╗${NC}"
echo -e "${BLUE}║   🚀 Safe Push - Pre-Push Validation     ║${NC}"
echo -e "${BLUE}╚══════════════════════════════════════════╝${NC}"
echo ""
echo -e "📍 Current branch: ${YELLOW}$BRANCH${NC}"
echo ""

# ========== STEP 1: Lint Check ==========
echo -e "${BLUE}🔍 Step 1: Running ESLint...${NC}"
npm run lint
if [ $? -ne 0 ]; then
  echo ""
  echo -e "${RED}❌ ESLint failed! Run 'npm run lint:fix' to auto-fix.${NC}"
  exit 1
fi
echo -e "${GREEN}✅ ESLint passed${NC}"
echo ""

# ========== STEP 2: Prettier Check ==========
echo -e "${BLUE}💅 Step 2: Checking Prettier formatting...${NC}"
npm run format:check
if [ $? -ne 0 ]; then
  echo ""
  echo -e "${RED}❌ Prettier failed! Run 'npm run format' to auto-fix.${NC}"
  exit 1
fi
echo -e "${GREEN}✅ Prettier passed${NC}"
echo ""

# ========== STEP 3: Run Tests ==========
echo -e "${BLUE}🧪 Step 3: Running Vitest tests...${NC}"
npx vitest run
if [ $? -ne 0 ]; then
  echo ""
  echo -e "${RED}❌ Tests FAILED! Push BLOCKED!${NC}"
  echo -e "${YELLOW}💡 Fix the failing tests and try again.${NC}"
  exit 1
fi
echo -e "${GREEN}✅ All tests passed${NC}"
echo ""

# ========== STEP 4: Push to GitHub ==========
echo -e "${BLUE}🚀 Step 4: Pushing to GitHub...${NC}"
git push origin "$BRANCH"
if [ $? -eq 0 ]; then
  echo ""
  echo -e "${GREEN}╔══════════════════════════════════════════╗${NC}"
  echo -e "${GREEN}║   🎉 Successfully pushed to GitHub!      ║${NC}"
  echo -e "${GREEN}╚══════════════════════════════════════════╝${NC}"
else
  echo ""
  echo -e "${RED}❌ Push failed! Check the error above.${NC}"
  exit 1
fi

