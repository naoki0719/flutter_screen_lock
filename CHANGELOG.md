# Changelog

## [9.0.0+1] - 2023-02-15

- Disable splash animation for hidden buttons.

## [9.0.0+1] - 2022-11-17

- Added change log.

## [9.0.0] - 2022-11-16

- Fixed allowing entering too many digits.
- Fixed ScreenLockConfig Title styling from ThemeData.

## [8.0.0] - 2022-10-27

- Change all callback names from `didSomething` to `onSomething`.
- Change `screenLock` with `confirm: true` to `screenLockCreate`.
- Change `ScreenLock` with `confirm: true` to `ScreenLock.create`.
- Replace `StyledInputConfig` with `KeyPadButtonConfig`.
- Replace `spacingRatio` with fixed value `spacing` in `Secrets`.

## [7.0.3] - 2022-07-21

- Added option for onValidate callback.
  - ⚠️There is a known bug where Secrets are not satisfied if the callback delays processing.

## [7.0.3] - 2022-07-19

- Added useLandscape property.

## [7.0.2] - 2022-06-11

- Unify all buttons. [#81](https://github.com/naoki0719/flutter_screen_lock/pull/81) by [@clragon](https://github.com/clragon)

## [7.0.1] - 2022-06-11

- Fixed setState running after screenlock dispose. [#80](https://github.com/naoki0719/flutter_screen_lock/pull/80) by [@clragon](https://github.com/clragon)

## [7.0.0] - 2022-06-09

- Property from `delayChild` to `delayBuilder`. This will disable input after a specified number of failed attempts and will be displayed by the Text Widget. [#78](https://github.com/naoki0719/flutter_screen_lock/pull/78) by [@clragon](https://github.com/clragon)

## [6.0.1] - 2022-06-06

- Fix didCancelled in screenLock [#69](https://github.com/naoki0719/flutter_screen_lock/pull/69) by [@clragon](https://github.com/clragon)
- Removed unnecessary imports [#70](https://github.com/naoki0719/flutter_screen_lock/pull/70) by [@clragon](https://github.com/clragon)

## [6.0.0] - 2022-05-31

- Available in Flutter 3.0 and above.
- Many options have been reconfigured. [#65](https://github.com/naoki0719/flutter_screen_lock/pull/65) by [@clragon](https://github.com/clragon)
- Navigator.pop is done at the user's own risk.
- For the aforementioned reasons, we provide situational callbacks.

## [5.0.12] - 2022-05-18

- Pass inputButtonConfig to all buttons in KeyPad [#59](https://github.com/naoki0719/flutter_screen_lock/pull/59) by [@clragon](https://github.com/clragon)

## [5.0.11+1] - 2022-04-14

- Corrected the year of the license.

## [5.0.11] - 2022-04-14

- Deleted debugging code.

## [5.0.10+1] - 2022-04-14

- Removed unused imports.

## [5.0.10] - 2022-04-14

- Fixed to completely discard inputController.

## [5.0.9+1] - 2022-04-12

- Updated pubspec for example.

## [5.0.9] - 2022-04-12

- Changed input processing from Stream to ValueListenable. Synchronization was added to alleviate input blocking problems.

## [5.0.8+2] - 2022-04-11

- Corrected image file extensions.

## [5.0.8+1] - 2022-04-11

- Added screenshots of landscape view to the Readme.

## [5.0.8] - 2022-04-11

- Changed widget placement on landscape devices.

## [5.0.7] - 2022-04-04

- Custom animations for "secrets" can now be created.

## [5.0.6+1] - 2022-03-01

- I have formatted the code properly.

## [5.0.6] - 2022-02-21

- Clear input chars on long pressed (#42).

## [5.0.5] - 2022-02-14

- Optimized Android example for Flutter 2.10 and above.
- Changed the return value of the screenLock function.

## [5.0.4] - 2022-01-12

- Disable input after exceeding number of attempts. (#36)

## [5.0.3] - 2022-01-11

- Fixed a bug that prevented proper display when using large size buttons. (#37)

## [5.0.2] - 2021-11-23

- Added an option to specify whether to blur the background.  
  You can optionally disable blur to deter performance degradation on some devices. (#34)

## [5.0.1] - 2021-11-16

- There was a spelling mistake, so I corrected it to "customizedButtonTap" (#31).

## [5.0.0] - 2021-11-05

- I put them together in a library to simplify importing.

## [4.0.4+4] - 2021-11-05

- Fixed examples with lengths other than 4.

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
