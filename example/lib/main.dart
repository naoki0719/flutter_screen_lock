import 'package:flutter/material.dart';
import 'package:flutter_screen_lock/flutter_screen_lock.dart';
import 'package:local_auth/local_auth.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Example',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  Future<void> localAuth(BuildContext context) async {
    final localAuth = LocalAuthentication();
    final didAuthenticate = await localAuth.authenticate(
      localizedReason: 'Please authenticate',
      biometricOnly: true,
    );
    if (didAuthenticate) {
      Navigator.pop(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Next Screen Lock'),
      ),
      body: SizedBox(
        width: double.infinity,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            ElevatedButton(
              onPressed: () => showDialog<void>(
                context: context,
                builder: (context) {
                  return const ScreenLock(correctString: '1234');
                },
              ),
              child: const Text('Manualy open'),
            ),
            ElevatedButton(
              onPressed: () => screenLock<void>(
                context: context,
                correctString: '1234',
                canCancel: false,
              ),
              child: const Text('Not cancelable'),
            ),
            ElevatedButton(
              onPressed: () {
                // Define it to control the confirmation state with its own events.
                final inputController = InputController();
                screenLock<void>(
                  context: context,
                  correctString: '',
                  confirmation: true,
                  inputController: inputController,
                  didConfirmed: (matchedText) {
                    print(matchedText);
                  },
                  footer: TextButton(
                    onPressed: () {
                      // Release the confirmation state and return to the initial input state.
                      inputController.unsetConfirmed();
                    },
                    child: const Text('Return enter mode.'),
                  ),
                );
              },
              child: const Text('Confirm mode'),
            ),
            ElevatedButton(
              onPressed: () => screenLock<void>(
                context: context,
                correctString: '1234',
                customizedButtonChild: const Icon(
                  Icons.fingerprint,
                ),
                customizedButtonTap: () async {
                  await localAuth(context);
                },
                didOpened: () async {
                  await localAuth(context);
                },
              ),
              child: const Text(
                'use local_auth \n(Show local_auth when opened)',
                textAlign: TextAlign.center,
              ),
            ),
            ElevatedButton(
              onPressed: () => screenLock<void>(
                context: context,
                correctString: '123456',
                canCancel: false,
                footer: Container(
                  padding: const EdgeInsets.only(top: 10),
                  child: OutlinedButton(
                    child: const Text('Cancel'),
                    onPressed: () => Navigator.pop(context),
                    style: OutlinedButton.styleFrom(
                      backgroundColor: Colors.transparent,
                    ),
                  ),
                ),
              ),
              child: const Text('Using footer'),
            ),
            ElevatedButton(
              onPressed: () {
                screenLock<void>(
                  context: context,
                  title: const Text('change title'),
                  confirmTitle: const Text('change confirm title'),
                  correctString: '',
                  confirmation: true,
                  screenLockConfig: const ScreenLockConfig(
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
                      build: (context, {required config, required enabled}) {
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
                            padding: const EdgeInsets.all(10),
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
                      textStyle: InputButtonConfig.getDefaultTextStyle(context)
                          .copyWith(
                        color: Colors.orange,
                        fontWeight: FontWeight.bold,
                      ),
                      buttonStyle: OutlinedButton.styleFrom(
                        shape: const RoundedRectangleBorder(),
                        backgroundColor: Colors.deepOrange,
                      ),
                      displayStrings: [
                        '零',
                        '壱',
                        '弐',
                        '参',
                        '肆',
                        '伍',
                        '陸',
                        '質',
                        '捌',
                        '玖'
                      ]),
                  cancelButton: const Icon(Icons.close),
                  deleteButton: const Icon(Icons.delete),
                );
              },
              child: const Text('Customize styles'),
            ),
          ],
        ),
      ),
    );
  }
}
