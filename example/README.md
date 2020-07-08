# Flutter Screen Lock

This Flutter plugin provides an feature for screen lock.
Enter your passcode to unlock the screen.
You can also use biometric authentication as an option.

<img src="https://raw.githubusercontent.com/naoki0719/flutter_screen_lock/master/resources/flutter_screen_lock.gif" />

## Features

- Any number of digits can be specified
- You can change `Cancel` and `Delete` text
- The UI expands and contracts according to the size of the device
- You can disable cancellation
- You can use biometrics
- Biometrics can be displayed on first launch
- Unlocked callback

## Usage

You can easily lock the screen with the following code.  
To unlock, enter correctString.

### Simple

If the passcode you entered matches, you can callback onUnlocked.

```dart
import 'package:flutter_screen_lock/flutter_screen_lock.dart';

showLockScreen(
  context: context,
  correctString: '1234',
  onUnlocked: () => print('Unlocked.'),
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

Specify `canBiometric` and `biometricAuthenticate`.

Add local_auth processing to `biometricAuthenticate`. See the following page for details.

https://pub.dev/packages/local_auth

```dart
import 'package:flutter_screen_lock/flutter_screen_lock.dart';

showLockScreen(
  context: context,
  correctString: '1234',
  canBiometric: true,
  biometricAuthenticate: (context) async {
    final localAuth = LocalAuthentication();
    final didAuthenticate =
        await localAuth.authenticateWithBiometrics(
            localizedReason: 'Please authenticate');

    if (didAuthenticate) {
      return true;
    }

    return false;
  },
);
```

### Open biometric first & onUnlocked callback

add option showBiometricFirst.

```dart
showLockScreen(
  context: context,
  correctString: '1234',
  canBiometric: true,
  showBiometricFirst: true,
  biometricAuthenticate: (context) async {
    final localAuth = LocalAuthentication();
    final didAuthenticate =
        await localAuth.authenticateWithBiometrics(
            localizedReason: 'Please authenticate');

    if (didAuthenticate) {
      return true;
    }

    return false;
  },
  onUnlocked: () {
    print('Unlocked.');
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

### Verifycation passcode (v1.1.1)

use `showConfirmPasscode` function.

<img src="https://raw.githubusercontent.com/naoki0719/flutter_screen_lock/master/resources/flutter_screen_lock_confirm.gif" />

```dart
showConfirmPasscode(
  context: context,
  confirmTitle: 'This is the second input.',
  onCompleted: (context, verifyCode) {
    // verifyCode is verified passcode
    print(verifyCode);
    // Please close yourself
    Navigator.of(context).maybePop();
  },
)
```

### Customize your style (v1.1.2)

use `circleInputButtonConfig` option.

<img src="https://raw.githubusercontent.com/naoki0719/flutter_screen_lock/master/resources/customize_styles.png" />

```dart
showLockScreen(
  context: context,
  correctString: '1234',
  backgroundColor: Colors.grey.shade50,
  backgroundColorOpacity: 1,
  circleInputButtonConfig: CircleInputButtonConfig(
    textStyle: TextStyle(
      fontSize: MediaQuery.of(context).size.width * 0.1,
      color: Colors.white,
    ),
    backgroundColor: Colors.blue,
    backgroundOpacity: 0.5,
    shape: RoundedRectangleBorder(
      side: BorderSide(
        width: 1,
        color: Colors.blue,
        style: BorderStyle.solid,
      ),
    ),
  ),
)
```

## Help

### How to prevent the background from being transparent

Set the `backgroundColorOpacity` option to 1
