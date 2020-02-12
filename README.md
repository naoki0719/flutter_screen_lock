# Flutter Screen Lock

This Flutter plugin provides an feature for screen lock.

## Features

- Any number of digits can be specified
- You can change `Cancel` and`Delete`
- The UI expands and contracts according to the size of the device
- You can disable cancellation
- You can use a custom button to call biometrics etc

## Usage

You can easily lock the screen with the following code.  
To unlock, enter correctString.

```dart
import 'package:flutter_screen_lock/flutter_screen_lock.dart';

showLockScreen(
  context: context,
  correctString: '1234',
);
```
