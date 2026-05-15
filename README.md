# Flutter Husky

Git hooks for Flutter & Dart projects.

`flutter_husky` helps you automatically check code quality before every commit and push.

It keeps your codebase clean by running formatter, analyzer, tests, spell checking, and detecting bad practices like debug prints or hardcoded secrets.

---

![Flutter Husky Landing Page](https://raw.githubusercontent.com/atulproject99/flutter_husky/main/assets/screenshots/landing-page.png)

---

# Demo

![Hook Demo](https://raw.githubusercontent.com/atulproject99/flutter_husky/main/assets/screenshots/hook-demo.gif)

---

## Links

- 🌐 Website: https://huskey-landing-page.onrender.com/
- 📦 pub.dev: https://pub.dev/packages/flutter_husky
- 💻 GitHub: https://github.com/atulproject99/flutter_husky

# Features

## Pre-commit checks

Before every commit, Flutter Husky automatically:

- ✅ Runs `dart fix --apply`
- ✅ Formats code using `dart format`
- ✅ Runs `flutter analyze`
- ✅ Detects `print()` statements
- ✅ Detects TODO/FIXME comments
- ✅ Detects possible hardcoded secrets
- ✅ Runs spell checking using `cspell`
- ✅ Re-stages fixed files automatically

---

## Pre-push checks

Before every push, Flutter Husky automatically:

- ✅ Runs Flutter tests
- ✅ Runs integration tests (if available)
- ✅ Verifies Flutter build
- ✅ Checks dependency status
- ✅ Detects merge conflict markers

---

# Why Flutter Husky?

Flutter Husky helps teams avoid committing:

- Debug code
- Unformatted code
- Analyzer issues
- Hardcoded secrets
- Broken tests
- Bad practices

This improves code quality and keeps repositories production-ready.

---

# Installation

Add as dev dependency:

```bash
flutter pub add --dev flutter_husky
```

or

```bash
dart pub add --dev flutter_husky
```

---

# Initialize Flutter Husky

Run:

```bash
dart run flutter_husky:init
```

This automatically creates:

```txt
.git/hooks/pre-commit
.git/hooks/pre-push
```

---

# Global Installation (Optional)

Install globally:

```bash
dart pub global activate flutter_husky
```

Then run directly:

```bash
flutter_husky:init
```

---

# Example

## Initialize Git

```bash
git init
```

---

## Install Flutter Husky

```bash
flutter pub add --dev flutter_husky
```

---

## Generate Hooks

```bash
dart run flutter_husky:init
```

Expected output:

```txt
✔ pre-commit hook installed
✔ pre-push hook installed

Flutter Husky initialized successfully
```

---

# How Pre-commit Works

When you run:

```bash
git commit -m "your message"
```

Flutter Husky automatically runs:

```bash
dart fix --apply
dart format .
flutter analyze
```

It also checks for:

- `print()`
- TODO comments
- hardcoded secrets
- spelling mistakes

If any issue is found, commit will be blocked.

---

# Example: Block Debug Print

If your code contains:

```dart
print("debug");
```

Commit will fail:

```txt
❌ Remove print statements before commit
```

---

# Example: Block Hardcoded Secret

If your code contains:

```dart
const API_KEY = "123";
```

Commit will fail:

```txt
❌ Possible hardcoded secret detected
```

---

# Terminal Preview

![Terminal Demo](https://raw.githubusercontent.com/atulproject99/flutter_husky/main/assets/screenshots/terminal-demo.png)

---

# How Pre-push Works

When you run:

```bash
git push
```

Flutter Husky automatically runs:

```bash
flutter test
flutter build apk --debug
```

If tests or build fail, push will be blocked.

---

# Skip Tests During Push

Sometimes you may want to skip tests temporarily.

Use:

```bash
SKIP_TESTS=true git push
```

---

# Skip All Hooks

Git provides a built-in bypass option.

Skip commit hooks:

```bash
git commit --no-verify
```

Skip push hooks:

```bash
git push --no-verify
```

---

# Automatic cspell Installation

Flutter Husky automatically installs `cspell` if it is not available.

Used for:

- spelling checks
- typo detection
- comment validation

---

# Recommended Lint Rules

For best results, use strict linting.

Install:

```bash
flutter pub add --dev very_good_analysis
```

Then create:

## `analysis_options.yaml`

```yaml
include: package:very_good_analysis/analysis_options.yaml
```

This improves:

- linting
- unused import detection
- naming conventions
- code quality

---

# Generated Hooks

## Pre-commit

Checks:

- formatter
- analyzer
- debug prints
- spelling
- secrets
- TODOs

---

## Pre-push

Checks:

- tests
- integration tests
- build verification
- merge conflicts

---

# Requirements

- Flutter SDK
- Dart SDK >= 3.0.0
- Git installed
- Node.js (for cspell)

---

# Supported Platforms

- macOS
- Linux
- Windows (Git Bash recommended)

---

# Troubleshooting

## Hooks are not running

Make sure Git is initialized:

```bash
git init
```

---

## Permission denied

Run:

```bash
chmod +x .git/hooks/pre-commit
chmod +x .git/hooks/pre-push
```

---

## Flutter command not found

Check Flutter installation:

```bash
flutter doctor
```

---

# Roadmap

Upcoming features:

- YAML configuration support
- Custom commands
- Run checks only on staged files
- Conventional commit validation
- Melos support
- CI/CD integration
- Interactive setup wizard

---

# Contributing

Contributions are welcome.

Feel free to open issues or submit pull requests.

---

# License

MIT License
