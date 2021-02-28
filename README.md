# Flutter Screen Lock

This Flutter plugin provides an feature for screen lock.
Enter your passcode to unlock the screen.
You can also use biometric authentication as an option.

<img src="https://raw.githubusercontent.com/naoki0719/flutter_screen_lock/master/resources/flutter_screen_lock_v3.gif" />

## ⚠Attention

A detailed API description will be provided later.
Only tentatively necessary information is provided.

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

If you give the same input as correctString, it will automatically close the screen.

```dart
import 'package:flutter_screen_lock/functions.dart';

screenLock(
  context: context,
  correctString: '1234',
);
```

### Change digits

Provides a screen lock that cannot be canceled.

```dart
import 'package:flutter_screen_lock/functions.dart';

screenLock(
  context: context,
  correctString: '1234',
  canCancel: false,
);
```

### Confirmation screen

You can display the confirmation screen and get the first input with didConfirmed if the first and second inputs match.

```dart
import 'package:flutter_screen_lock/functions.dart';

screenLock(
  context: context,
  correctString: '',
  confirmation: true,
  didConfirmed: (matchedText) {
    print(matchedText);
  },
);
```

### Use local_auth

Add the local_auth package to pubspec.yml.

https://pub.dev/packages/local_auth

It includes an example that calls biometrics as soon as screenLock is displayed in `didOpened`.

```dart
import 'package:flutter_screen_lock/functions.dart';
import 'package:local_auth/local_auth.dart';
import 'package:flutter/material.dart';

/// Method extraction to call by initial display and custom buttons.
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
  customizedButtonChild: Icon(
    Icons.fingerprint,
  ),
  customizedButtonTap: () async {
    await localAuth(context);
  },
  didOpened: () async {
    await localAuth(context);
  },
);
```

### Full customize

```dart
import 'package:flutter/material.dart';
import 'package:flutter_screen_lock/configurations/input_button_config.dart';
import 'package:flutter_screen_lock/configurations/screen_lock_config.dart';
import 'package:flutter_screen_lock/configurations/secret_config.dart';
import 'package:flutter_screen_lock/configurations/secrets_config.dart';
import 'package:flutter_screen_lock/functions.dart';
import 'package:flutter_screen_lock/screen_lock.dart';

screenLock(
  context: context,
  title: Text('change title'),
  confirmTitle: Text('change confirm title'),
  correctString: '1234',
  confirmation: true,
  screenLockConfig: ScreenLockConfig(
    backgroundColor: Colors.deepOrange,
  ),
  secretsConfig: SecretsConfig(
    spacing: 15, // or spacingRatio
    padding: const EdgeInsets.all(40),
    secretConfig: SecretConfig(
      borderColor: Colors.amber,
      borderSize: 2.0,
      disabledColor: Colors.black,
      enabledColor: Colors.amber,
      height: 15,
      width: 15,
      build: (context, {config, enabled}) {
        return SizedBox(
          child: Container(
            decoration: BoxDecoration(
              shape: BoxShape.rectangle,
              color: enabled
                  ? config.enabledColor
                  : config.disabledColor,
              border: Border.all(
                width: config.borderSize,
                color: config.borderColor,
              ),
            ),
            padding: EdgeInsets.all(10),
            width: config.width,
            height: config.height,
          ),
          width: config.width,
          height: config.height,
        );
      },
    ),
  ),
  inputButtonConfig: InputButtonConfig(
    textStyle:
        InputButtonConfig.getDefaultTextStyle(context).copyWith(
      color: Colors.orange,
      fontWeight: FontWeight.bold,
    ),
    buttonStyle: OutlinedButton.styleFrom(
      shape: RoundedRectangleBorder(),
      backgroundColor: Colors.deepOrange,
    ),
  ),
  cancelButton: const Icon(Icons.close),
  deleteButton: const Icon(Icons.delete),
);
```

<img src="https://raw.githubusercontent.com/naoki0719/flutter_screen_lock/master/resources/customize_styles_v3.png" />

## Apps I use

TimeKey

[iOS](https://apps.apple.com/us/app/timekey-authenticator/id1506129753)

[Android](https://play.google.com/store/apps/details?id=net.incrementleaf.TimeKey)
