class PrePushGenerator {
  static String generate() {
    return '''
#!/bin/sh

echo ""
echo "🚀 Flutter Husky - Pre Push Checks"
echo ""

# ---------------------------------------
# Skip tests if needed
# ---------------------------------------

if [ "\$SKIP_TESTS" = "true" ]; then
  echo "⚠️ Tests skipped using SKIP_TESTS=true"
  exit 0
fi

# ---------------------------------------
# Run unit tests
# ---------------------------------------

echo "🧪 Running unit tests..."

flutter test

if [ \$? -ne 0 ]; then
  echo ""
  echo "❌ Tests failed"
  exit 1
fi

# ---------------------------------------
# Run integration tests if available
# ---------------------------------------

if [ -d "integration_test" ]; then
  echo ""
  echo "🧪 Running integration tests..."

  flutter test integration_test

  if [ \$? -ne 0 ]; then
    echo ""
    echo "❌ Integration tests failed"
    exit 1
  fi
fi

# ---------------------------------------
# Verify Flutter build
# ---------------------------------------

echo ""
echo "🏗 Verifying debug build..."

flutter build apk --debug >/dev/null 2>&1

if [ \$? -ne 0 ]; then
  echo ""
  echo "❌ Build failed"
  exit 1
fi

# ---------------------------------------
# Check outdated dependencies
# ---------------------------------------

echo ""
echo "📦 Checking dependencies..."

flutter pub outdated >/dev/null 2>&1

# ---------------------------------------
# Check for unresolved merge conflicts
# ---------------------------------------

echo ""
echo "🔀 Checking merge conflicts..."

if grep -r "<<<<<<<\\|=======\\|>>>>>>>" lib; then
  echo ""
  echo "❌ Merge conflict markers detected"
  exit 1
fi

# ---------------------------------------
# Check generated files
# ---------------------------------------

if [ -f "build_runner" ]; then
  echo ""
  echo "⚙️ Checking generated files..."
  
  dart run build_runner build --delete-conflicting-outputs

  if [ \$? -ne 0 ]; then
    echo ""
    echo "❌ build_runner generation failed"
    exit 1
  fi
fi

# ---------------------------------------
# Final success
# ---------------------------------------

echo ""
echo "✅ Pre-push checks passed"
echo ""
''';
  }
}
