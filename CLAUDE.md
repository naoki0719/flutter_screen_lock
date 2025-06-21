# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Project Overview

flutter_screen_lock is a Flutter package that provides screen lock functionality. It supports passcode-based screen locking and biometric authentication (using local_auth).

## Development Commands

This project uses FVM (Flutter Version Management). Flutter 3.32.1 is specified.

### FVM Setup
```bash
# Install FVM (if not already installed)
dart pub global activate fvm

# Use the project-specified Flutter version
fvm use

# Use "fvm flutter" prefix for Flutter commands
```

### Basic Development Commands
```bash
# Install dependencies
fvm flutter pub get

# Run static analysis
fvm flutter analyze

# Run tests
fvm flutter test

# Run example project
cd example && fvm flutter run
```

### Test Commands
```bash
# Run all tests
fvm flutter test

# Run specific test file
fvm flutter test test/input_state_test.dart

# Run single test case
fvm flutter test test/input_state_test.dart --name "test name"
```

### Code Quality and Formatting
```bash
# Install dependencies (required before linting/formatting)
fvm flutter pub get

# Run static analysis (linter)
fvm flutter analyze

# Format code with dart format
fvm dart format .
```

### Package Publishing Preparation
```bash
# Package quality check
fvm flutter pub publish --dry-run

# Check dependency information
fvm flutter pub deps
```

## Architecture

### Main Components

- **ScreenLock**: Main screen lock widget (authentication mode)
- **ScreenLock.create**: Factory constructor for passcode creation mode
- **InputController**: Controller for managing input state
- **KeyPad**: Numeric input keypad
- **Secrets**: Passcode dot display
- **Configuration classes**: Configuration classes for each component

### File Structure

```
lib/
├── flutter_screen_lock.dart          # Package entry point
├── src/
│   ├── screen_lock.dart              # Main ScreenLock widget
│   ├── functions.dart                # screenLock/screenLockCreate functions
│   ├── input_controller.dart         # Input control logic
│   ├── configurations/               # Configuration classes
│   │   ├── screen_lock_config.dart
│   │   ├── key_pad_config.dart
│   │   ├── secret_config.dart
│   │   ├── secrets_config.dart
│   │   └── key_pad_button_config.dart
│   └── layout/                       # UI components
│       ├── key_pad.dart
│       ├── key_pad_button.dart
│       └── secrets.dart
```

### Public API

The package provides two main usage patterns:

1. **Authentication Mode**: `screenLock()` function or ScreenLock widget
2. **Creation Mode**: `screenLockCreate()` function or ScreenLock.create()

## Configuration and Customization

Each component can be customized with the following configuration classes:
- `ScreenLockConfig`: Overall theme and background color
- `SecretsConfig` & `SecretConfig`: Passcode dot appearance
- `KeyPadConfig` & `KeyPadButtonConfig`: Keypad button styling

## Testing Strategy

- `test/input_state_test.dart`: Tests InputController input state management logic
- `example/test/widget_test.dart`: Widget tests for the sample app

## Dependencies

- Flutter SDK (>=3.6.0)
- Optional: local_auth (for biometric authentication)

## Development Notes

- Requires Dart 3.6.0+ and Flutter 3.0+
- Supports all platforms (iOS, Android, Web, Desktop)
- Responsive design with portrait/landscape orientation support
- Accessibility compliant