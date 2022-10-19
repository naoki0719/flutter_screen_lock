# Flutter Screen Lock

This Flutter plugin provides an feature for screen lock.
Enter your passcode to unlock the screen.
You can also use biometric authentication as an option.

<img src="https://raw.githubusercontent.com/naoki0719/flutter_screen_lock/master/resources/flutter_screen_lock_v3.gif" />

## Features

- By the length of the character count
- You can change `Cancel` and `Delete` widget
- Optimizes the UI for device size and orientation
- You can disable cancellation
- You can use biometrics (local_auth plugin)
- Biometrics can be displayed on first launch
- Unlocked callback
- You can specify a mismatch event.
- Limit the maximum number of retries

## Usage

You can easily lock the screen with the following code.  
To unlock, enter correctString.

### Simple

If the passcode the user entered matches, `onUnlocked` is called.

```dart
import 'package:flutter_screen_lock/flutter_screen_lock.dart';

showLockScreen(
  context: context,
  correctString: '1234',
  onUnlocked: () => print('Unlocked.'),
);
```

### Change digits

Digits will be adjusted to the length of `correctString`.

```dart
import 'package:flutter_screen_lock/flutter_screen_lock.dart';

lockScreen(
  context: context,
  correctString: '123456',
);
```

When creating a PIN, you can specify the amount:

```dart
import 'package:flutter_screen_lock/flutter_screen_lock.dart';

lockScreenCreate(
  context: context,
  digits: 6,
  onConfirmed: (value) => print(value),
);
```


### Use local_auth

Add the [local_auth](https://pub.dev/packages/local_auth) package to pubspec.yml.

It includes an example that calls biometrics as soon as screenLock is displayed in `didOpened`.

```dart
import 'package:flutter_screen_lock/flutter_screen_lock.dart';
import 'package:local_auth/local_auth.dart';
import 'package:flutter/material.dart';

Future<void> localAuth(BuildContext context) async {
  final localAuth = LocalAuthentication();
  final didAuthenticate = await localAuth.authenticateWithBiometrics(
      localizedReason: 'Please authenticate');
  if (didAuthenticate) {
    Navigator.pop(context);
  }
}

screenLock(
  context: context,
  correctString: '1234',
  customizedButtonChild: Icon(Icons.fingerprint),
  customizedButtonTap: () async => await localAuth(context),
  didOpened: () async => await localAuth(context),
);
```

### Block user

This is the case where you want to force authentication when the app is first launched.

```dart
lockScreen(
  context: context,
  correctString: '1234',
  canCancel: false,
);
```

### Customize text

You can change `Cancel` and `Delete` text.

```dart
showLockScreen(
  context: context,
  correctString: '1234',
  cancelButton: Text('Close'),
  deleteButton: Text('Remove'),
);
```

### User creating new passcode

Will let user enter a new passcode and confirm it.

You have to store the passcode somewhere manually.

```dart
import 'package:flutter_screen_lock/flutter_screen_lock.dart';

screenLockCreate(
  context: context,
  onConfirmed: (value) => print(value), // store new passcode somewhere here
);
```

## FAQ

### How to prevent the background from being transparent

Set the `backgroundColorOpacity` option to 1
