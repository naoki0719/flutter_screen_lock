# Flutter Screen Lock

This Flutter plugin provides an feature for screen lock.
Enter your passcode to unlock the screen.
You can also use biometric authentication as an option.

<img src="https://raw.githubusercontent.com/naoki0719/flutter_screen_lock/master/resources/flutter_screen_lock_v3.gif" />

## Landscape view

<img src="https://raw.githubusercontent.com/naoki0719/flutter_screen_lock/master/resources/landscape.png" />

## 6.x to 7 migration

Change delayChilde to delayBuilder.
It used to push another screen, but has been changed to display a message in TextWidget.

We would like to thank [clragon](https://github.com/clragon) for their significant contribution to these changes.

## 5.x to 6 migration

The major change is that Navigator.pop will be controlled by the developer.
This is because it is undesirable to pop inside the package in various situations.
However, we continue to pop in the initial value of the callback as before.

We would like to thank [clragon](https://github.com/clragon) for their significant contribution to these changes.

## 4.x to 5 migration

Change to the next import only.

```dart
import 'package:flutter_screen_lock/flutter_screen_lock.dart';
```

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
import 'package:flutter_screen_lock/flutter_screen_lock.dart';

screenLock(
  context: context,
  correctString: '1234',
);
```

### Change digits

Provides a screen lock that cannot be canceled.

```dart
import 'package:flutter_screen_lock/flutter_screen_lock.dart';

screenLock(
  context: context,
  correctString: '1234',
  canCancel: false,
);
```

### Confirmation screen

You can display the confirmation screen and get the first input with didConfirmed if the first and second inputs match.

```dart
import 'package:flutter_screen_lock/flutter_screen_lock.dart';

screenLock(
  context: context,
  correctString: '',
  confirmation: true,
  didConfirmed: (matchedText) {
    print(matchedText);
  },
);
```

### Control the confirmation state

```dart
import 'package:flutter_screen_lock/flutter_screen_lock.dart';

final inputController = InputController();

screenLock(
  context: context,
  correctString: '',
  confirmation: true,
  inputController: inputController,
);

// Release the confirmation state at any event.
inputController.unsetConfirmed();
```

### Use local_auth

Add the local_auth package to pubspec.yml.

https://pub.dev/packages/local_auth

It includes an example that calls biometrics as soon as screenLock is displayed in `didOpened`.

```dart
import 'package:flutter_screen_lock/flutter_screen_lock.dart';
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
import 'package:flutter_screen_lock/flutter_screen_lock.dart';

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

## Back me up!

<a href="https://www.buymeacoffee.com/noa.nao" target="_blank"><img src="https://cdn.buymeacoffee.com/buttons/v2/default-yellow.png" alt="Buy Me A Coffee" width="30%" ></a>
