class PreCommitGenerator {
  static String generate() {
    return '''
#!/bin/sh

echo ""
echo "🚀 Flutter Husky - Pre Commit Checks"
echo ""

# ---------------------------------------
# Get staged Dart files
# ---------------------------------------

STAGED_DART_FILES=\$(git diff --cached --name-only --diff-filter=ACM | grep "\\.dart\$")

if [ -z "\$STAGED_DART_FILES" ]; then
  echo "ℹ️ No Dart files staged"
  exit 0
fi

# ---------------------------------------
# Install cspell if missing
# ---------------------------------------

if ! command -v cspell >/dev/null 2>&1; then
  echo ""
  echo "📦 Installing cspell..."

  npm install -g cspell

  if [ \$? -ne 0 ]; then
    echo ""
    echo "❌ Failed to install cspell"
    exit 1
  fi
fi

# ---------------------------------------
# Run dart fix
# ---------------------------------------

echo ""
echo "🛠 Running dart fix..."
dart fix --apply

if [ \$? -ne 0 ]; then
  echo ""
  echo "❌ dart fix failed"
  exit 1
fi

# ---------------------------------------
# Format code
# ---------------------------------------

echo ""
echo "🎨 Running formatter..."
dart format .

if [ \$? -ne 0 ]; then
  echo ""
  echo "❌ Formatting issues found"
  exit 1
fi

# ---------------------------------------
# Analyze code
# ---------------------------------------

echo ""
echo "🔍 Running analyzer..."
flutter analyze

if [ \$? -ne 0 ]; then
  echo ""
  echo "❌ Analyzer issues found"
  exit 1
fi

# ---------------------------------------
# Detect print statements
# ---------------------------------------

echo ""
echo "🐛 Checking print statements..."

if grep -r "print(" lib test; then
  echo ""
  echo "❌ Remove print statements before commit"
  exit 1
fi

# ---------------------------------------
# Detect debugPrint statements
# ---------------------------------------

echo ""
echo "📢 Checking debugPrint statements..."

if grep -r "debugPrint(" lib test; then
  echo ""
  echo "❌ Remove debugPrint statements before commit"
  exit 1
fi

# ---------------------------------------
# Detect TODO/FIXME comments
# ---------------------------------------

echo ""
echo "📝 Checking TODO/FIXME comments..."

if grep -r "TODO\\|FIXME" lib test; then
  echo ""
  echo "⚠️ TODO/FIXME comments found"
fi

# ---------------------------------------
# Detect possible secrets
# ---------------------------------------

echo ""
echo "🔐 Checking hardcoded secrets..."

if grep -r "API_KEY\\|SECRET\\|TOKEN\\|PASSWORD" lib; then
  echo ""
  echo "❌ Possible hardcoded secret detected"
  exit 1
fi

# ---------------------------------------
# Spell checking
# ---------------------------------------

echo ""
echo "🔤 Checking spelling..."

cspell "lib/**/*.dart"

if [ \$? -ne 0 ]; then
  echo ""
  echo "❌ Spelling mistakes found"
  exit 1
fi

# ---------------------------------------
# Re-stage files
# ---------------------------------------

echo ""
echo "📂 Re-staging files..."
git add .

echo ""
echo "✅ Pre-commit checks passed"
echo ""
''';
  }
}
