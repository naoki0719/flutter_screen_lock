import 'package:flutter/material.dart';
import 'package:flutter_screen_lock/configurations/input_button_config.dart';
import 'package:flutter_screen_lock/configurations/screen_lock_config.dart';
import 'package:flutter_screen_lock/configurations/secret_config.dart';
import 'package:flutter_screen_lock/configurations/secrets_config.dart';
import 'package:flutter_screen_lock/functions.dart';
import 'package:flutter_screen_lock/screen_lock.dart';
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
  Future<void> localAuth(BuildContext context) async {
    final localAuth = LocalAuthentication();
    final didAuthenticate = await localAuth.authenticateWithBiometrics(
        localizedReason: 'Please authenticate');
    if (didAuthenticate) {
      Navigator.pop(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Next Screen Lock'),
      ),
      body: Container(
        width: double.infinity,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            ElevatedButton(
              onPressed: () => showDialog(
                context: context,
                child: ScreenLock(
                  correctString: '1234',
                ),
              ),
              child: Text('Manualy open'),
            ),
            ElevatedButton(
              onPressed: () => screenLock(
                context: context,
                correctString: '1234',
                canCancel: false,
              ),
              child: Text('Not cancelable'),
            ),
            ElevatedButton(
              onPressed: () => screenLock(
                context: context,
                correctString: '',
                confirmation: true,
                didConfirmed: (matchedText) {
                  print(matchedText);
                },
              ),
              child: Text('Confirm mode'),
            ),
            ElevatedButton(
              onPressed: () => screenLock(
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
              ),
              child: Text(
                'use local_auth \n(Show local_auth when opened)',
                textAlign: TextAlign.center,
              ),
            ),
            ElevatedButton(
              onPressed: () => screenLock(
                context: context,
                correctString: '123456',
                canCancel: false,
                footer: Container(
                  padding: EdgeInsets.only(
                    top: 10,
                  ),
                  child: OutlinedButton(
                    child: Text('Cancel'),
                    onPressed: () => Navigator.pop(context),
                    style: OutlinedButton.styleFrom(
                      backgroundColor: Colors.transparent,
                    ),
                  ),
                ),
              ),
              child: Text('Using footer'),
            ),
            ElevatedButton(
              onPressed: () {
                screenLock(
                  context: context,
                  title: Text('change title'),
                  confirmTitle: Text('change confirm title'),
                  correctString: '',
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
                      textStyle: InputButtonConfig.getDefaultTextStyle(context)
                          .copyWith(
                        color: Colors.orange,
                        fontWeight: FontWeight.bold,
                      ),
                      buttonStyle: OutlinedButton.styleFrom(
                        shape: RoundedRectangleBorder(),
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
              child: Text('Customize styles'),
            ),
          ],
        ),
      ),
    );
  }
}
