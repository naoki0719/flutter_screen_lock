# Flutter Screen Lock

This Flutter plugin provides an feature for screen lock.
Enter your passcode to unlock the screen.
You can also use biometric authentication as an option.

<p align="center">
  <img src="https://github.com/naoki0719/flutter_screen_lock/blob/master/resources/flutter_screen_lock.gif" />
</p>

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

### Simple

```dart
import 'package:flutter_screen_lock/flutter_screen_lock.dart';

showLockScreen(
  context: context,
  correctString: '1234',
);
```

### Change digits

Default 4 digits can be changed. Change the correctString accordingly.

```dart
import 'package:flutter_screen_lock/flutter_screen_lock.dart';

showLockScreen(
  context: context,
  digits: 6,
  correctString: '123456',
);
```

### Use local_auth

Specify `canBiometric` and `biometricFunction`.
`biometricFunction`

Add local_auth processing to `biometricFunction`. See the following page for details.

https://pub.dev/packages/local_auth

```dart
import 'package:flutter_screen_lock/flutter_screen_lock.dart';

showLockScreen(
  context: context,
  correctString: '1234',
  canBiometric: true,
  biometricFunction: (context) async {
    LocalAuthentication localAuth = LocalAuthentication();
    bool didAuthenticate =
        await localAuth.authenticateWithBiometrics(
            localizedReason:
                'Please authenticate to show account balance');
    if (didAuthenticate) {
      Navigator.of(context).maybePop();
    }
  },
);
```

### Open biometric first

add option showBiometricFirst.

```dart
showLockScreen(
  context: context,
  correctString: '1234',
  canBiometric: true,
  showBiometricFirst: true,
  biometricFunction: (context) async {
    LocalAuthentication localAuth = LocalAuthentication();
    bool didAuthenticate =
        await localAuth.authenticateWithBiometrics(
            localizedReason:
                'Please authenticate to show account balance');
    if (didAuthenticate) {
      Navigator.of(context).maybePop();
    }
  },
);
```

### Can't cancel

This is the case where you want to force authentication when the app is first launched.

```dart
showLockScreen(
  context: context,
  correctString: '1234',
  canCancel: false,
);
```

### Customize text

You can change `Cancel` and `Delete` text.
We recommend no more than 6 characters at this time.

```dart
showLockScreen(
  context: context,
  correctString: '1234',
  cancelText: 'Close',
  deleteText: 'Remove',
);
```
