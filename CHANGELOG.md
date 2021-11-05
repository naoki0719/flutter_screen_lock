# Changelog

## [4.0.4+3] - 2021-11-04

- Added an example of transitioning to the next page by unlocking.

## [4.0.4+2] - 2021-09-17

- Run flutter format
- Changed to flutter_lints

## [4.0.4+1] - 2021-04-30

- Add inputController to the document

## [4.0.4] - 2021-04-30

- Implemented a function to return the confirmation state to the initial input state.

## [4.0.3] - 2021-03-30

- Fixed the problem of being able to back with physical keys even if canCancel is false.

## [4.0.2] - 2021-03-11

- Fixed a bug that caused Cancel text to be cut off on devices with narrow widths.

## [4.0.1] - 2021-03-04

- Prevented button size overflow by subtracting padding(horizontal: 50) from screen_lock.dart

## [4.0.0] - 2021-03-04

- Update to null safety.

## [3.0.1+1] - 2021-03-01

- Fixed the README.

## [3.0.1] - 2021-03-01

- Add missing parameters to screenLock.
- Make input button strings and input values customizable.
- Add API reference in README.md.

## [3.0.0+2] - 2021-02-28

- Change the size of the screenshot.

## [3.0.0+1] - 2021-02-28

- Change the image path in README to avoid caching.

## [3.0.0] - 2021-02-28

- Version 3.0.0 was released with improved customizability.
- The method and function names have been unified to match the package names.
- The properties have been reviewed and are no longer backward compatible.
- It recognizes the size and orientation of the device and optimizes the size of the keypad.
- ⚠We will try to maintain compatibility in this version as much as possible, but disruptive changes may be made.
- ⚠️We have not been able to fully confirm this on Android.

## [1.2.9] - 2021-02-22

- `didMaxRetries` and `onError` are not handled by biometric.

## [1.2.8+1] - 2021-02-22

- Fixed the README.

## [1.2.8] - 2021-02-22

- Add the `onError` event when input fails.

## [1.2.7+1] - 2021-02-22

- Fixed the README.

## [1.2.7] - 2021-02-22

- Added the ability to limit the maximum retries.

## [1.2.6] - 2021-01-03

- Fixed to pop after biometric authentication and then call the unlocked function.

## [1.2.5] - 2021-01-02

- Fixed to center the screen content.

## [1.2.4] - 2020-07-29

- Fixed an exception when deleting input.

## [1.2.3] - 2020-07-29

- Fix a missing exception in onUnlocked.

## [1.2.2] - 2020-07-28

- Fix exception for onUnlocked.

## [1.2.1] - 2020-07-08

- Added custom biometric button.

## [1.2.0] - 2020-07-08

- Added unlocked callback function.
- Deprecate biometricFunction. Instead, we have a biometricAuthenticate.
- If you return true with biometricAuthenticate, you can set onUnlocked to Callback. Also, Navigation.pop is now automatic.

## [1.1.2] - 2020-05-10

- Added the ability to customize buttons and backgrounds.

## [1.1.1] - 2020-05-10

- Fix to call showBiometricFunction when the animation is complete

## [1.1.0+1] - 2020-03-03

- Added video for confirm screen

## [1.1.0] - 2020-02-28

- New feature in verification passcode

## [1.0.0+2] - 2020-02-18

- Change example readme

## [1.0.0+1] - 2020-02-17

- Fix readme

## [1.0.0] - 2020-02-16

- First release

### Features

- Any number of digits can be specified
- You can change `Cancel` and `Delete` text
- The UI expands and contracts according to the size of the device
- You can disable cancellation
- You can use biometrics
- Biometrics can be displayed on first launch
- Verification passcode
- Unlocked callback
