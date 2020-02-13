# Flutter Screen Lock

This Flutter plugin provides an feature for screen lock.
Enter your passcode to unlock the screen.
You can also use biometric authentication as an option.

<img src="https://github.com/naoki0719/flutter_screen_lock/blob/master/resources/flutter_screen_lock.gif" />

## Features

- Any number of digits can be specified
- You can change `Cancel` and `Delete` text
- The UI expands and contracts according to the size of the device
- You can disable cancellation
- You can use biometrics
- Biometrics can be displayed on first launch

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
