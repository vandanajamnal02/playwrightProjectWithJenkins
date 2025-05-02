#!/bin/bash

set -e  # Stop the script on any error

echo "📦 Installing Node.js dependencies..."
npm install

echo "🎭 Installing Playwright and required browser dependencies..."
npx playwright install --with-deps

echo "🚀 Running Playwright tests..."
npx playwright test

echo "✅ Tests completed successfully."

