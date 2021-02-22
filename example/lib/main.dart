import 'package:example/second_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screen_lock/circle_input_button.dart';
import 'package:flutter_screen_lock/lock_screen.dart';
import 'package:local_auth/local_auth.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Example',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(title: 'Flutter Demo Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);
  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              RaisedButton(
                child: Text('Open Lock Screen'),
                onPressed: () => showLockScreen(
                  context: context,
                  correctString: '1234',
                  onCompleted: (context, result) {
                    // if you specify this callback,
                    // you must close the screen yourself
                    Navigator.of(context).maybePop();
                  },
                  onUnlocked: () => print('Unlocked.'),
                ),
              ),
              RaisedButton(
                child: Text('6 Digits'),
                onPressed: () => showLockScreen(
                  context: context,
                  digits: 6,
                  correctString: '123456',
                ),
              ),
              RaisedButton(
                child: Text('Use local_auth'),
                onPressed: () => showLockScreen(
                  context: context,
                  correctString: '1234',
                  canBiometric: true,
                  // biometricButton is default Icon(Icons.fingerprint)
                  // When you want to change the icon with `BiometricType.face`, etc.
                  biometricButton: Icon(Icons.face),
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
                ),
              ),
              RaisedButton(
                child: Text('Open biometric first'),
                onPressed: () => showLockScreen(
                  context: context,
                  correctString: '1234',
                  canBiometric: true,
                  showBiometricFirst: true,
                  // biometricFunction: (context) async {
                  //   final localAuth = LocalAuthentication();
                  //   final didAuthenticate =
                  //       await localAuth.authenticateWithBiometrics(
                  //           localizedReason: 'Please authenticate');

                  //   if (didAuthenticate) {
                  //     Navigator.of(context).pop();
                  //   }
                  // },
                  biometricAuthenticate: (_) async {
                    final localAuth = LocalAuthentication();
                    final didAuthenticate =
                        await localAuth.authenticateWithBiometrics(
                            localizedReason: 'Please authenticate');

                    if (didAuthenticate) {
                      return true;
                    }

                    return false;
                  },
                  onUnlocked: () => print('Unlocked.'),
                ),
              ),
              RaisedButton(
                child: Text('Go to another page after unlocked biometrics'),
                onPressed: () => showLockScreen(
                  context: context,
                  correctString: '1234',
                  canBiometric: true,
                  showBiometricFirst: true,
                  biometricAuthenticate: (_) async {
                    final localAuth = LocalAuthentication();
                    final didAuthenticate =
                        await localAuth.authenticateWithBiometrics(
                            localizedReason: 'Please authenticate');

                    if (didAuthenticate) {
                      return true;
                    }

                    return false;
                  },
                  onUnlocked: () async => Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => SecondPage(),
                    ),
                  ),
                ),
              ),
              RaisedButton(
                child: Text('Can\'t cancel'),
                onPressed: () => showLockScreen(
                  context: context,
                  correctString: '1234',
                  canCancel: false,
                ),
              ),
              RaisedButton(
                child: Text('Customize text'),
                onPressed: () => showLockScreen(
                  context: context,
                  correctString: '1234',
                  cancelText: 'Close',
                  deleteText: 'Remove',
                ),
              ),
              RaisedButton(
                child: Text('Confirm mode.'),
                onPressed: () => showConfirmPasscode(
                  context: context,
                  onCompleted: (context, verifyCode) {
                    print(verifyCode);
                    Navigator.of(context).maybePop();
                  },
                ),
              ),
              RaisedButton(
                child: Text('Change styles.'),
                onPressed: () => showLockScreen(
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
                ),
              ),
              RaisedButton(
                child: Text('Max retries / Incorrect event'),
                onPressed: () => showLockScreen(
                  context: context,
                  correctString: '1234',
                  maxRetries: 1,
                  onError: (retries) {
                    print(retries);
                  },
                  didMaxRetries: () {
                    Navigator.pop(context);
                    showAboutDialog(
                      context: context,
                      children: [
                        Text('The maximum number of retries has been reached.'),
                      ],
                    );
                  },
                  biometricAuthenticate: (_) async {
                    final localAuth = LocalAuthentication();
                    final didAuthenticate =
                        await localAuth.authenticateWithBiometrics(
                            localizedReason: 'Please authenticate');

                    if (didAuthenticate) {
                      return true;
                    }

                    return false;
                  },
                  canBiometric: true,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
