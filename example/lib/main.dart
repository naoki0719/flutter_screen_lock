import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screen_lock/flutter_screen_lock.dart';
import 'package:local_auth/local_auth.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

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
  const MyHomePage({super.key});

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
        body: Padding(
          padding: const EdgeInsets.all(16),
          child: Center(
            child: ConstrainedBox(
              constraints: const BoxConstraints(
                maxWidth: 700,
              ),
              child: Wrap(
                spacing: 16,
                runSpacing: 16,
                alignment: WrapAlignment.start,
                children: [
                  ElevatedButton(
                    onPressed: () => showDialog<void>(
                      context: context,
                      builder: (context) {
                        return ScreenLock(
                          correctString: '1234',
                          onCancelled: Navigator.of(context).pop,
                          onUnlocked: Navigator.of(context).pop,
                        );
                      },
                    ),
                    child: const Text('Manually open'),
                  ),
                  ElevatedButton(
                    onPressed: () => screenLock(
                      context: context,
                      correctString: '1234',
                      canCancel: false,
                    ),
                    child: const Text('Not cancelable'),
                  ),
                  ElevatedButton(
                    onPressed: () {
                      // Define it to control the confirmation state with its own events.
                      final controller = InputController();
                      screenLockCreate(
                        context: context,
                        inputController: controller,
                        onConfirmed: (matchedText) =>
                            Navigator.of(context).pop(),
                        footer: TextButton(
                          onPressed: () {
                            // Release the confirmation state and return to the initial input state.
                            controller.unsetConfirmed();
                          },
                          child: const Text('Reset input'),
                        ),
                      );
                    },
                    child: const Text('Confirm mode'),
                  ),
                  ElevatedButton(
                    onPressed: () => screenLock(
                      context: context,
                      correctString: '1234',
                      customizedButtonChild: const Icon(
                        Icons.fingerprint,
                      ),
                      customizedButtonTap: () async => await localAuth(context),
                      onOpened: () async => await localAuth(context),
                    ),
                    child: const Text(
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
                        width: 68,
                        height: 68,
                        padding: const EdgeInsets.only(top: 10),
                        child: OutlinedButton(
                          child: const Padding(
                            padding: EdgeInsets.all(10),
                            child: Text('Cancel'),
                          ),
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
                      screenLockCreate(
                        context: context,
                        title: const Text('change title'),
                        confirmTitle: const Text('change confirm title'),
                        onConfirmed: (value) => Navigator.of(context).pop(),
                        config: const ScreenLockConfig(
                          backgroundColor: Colors.deepOrange,
                          titleTextStyle: TextStyle(fontSize: 24),
                        ),
                        secretsConfig: SecretsConfig(
                          spacing: 15, // or spacingRatio
                          padding: const EdgeInsets.all(40),
                          secretConfig: SecretConfig(
                            borderColor: Colors.amber,
                            borderSize: 2.0,
                            disabledColor: Colors.black,
                            enabledColor: Colors.amber,
                            size: 15,
                            builder: (context, config, enabled) => Container(
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
                              width: config.size,
                              height: config.size,
                            ),
                          ),
                        ),
                        keyPadConfig: KeyPadConfig(
                          buttonConfig: KeyPadButtonConfig(
                            buttonStyle: OutlinedButton.styleFrom(
                              textStyle: const TextStyle(
                                color: Colors.orange,
                                fontWeight: FontWeight.bold,
                              ),
                              shape: const RoundedRectangleBorder(),
                              backgroundColor: Colors.deepOrange,
                            ),
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
                            '玖',
                          ],
                        ),
                        cancelButton: const Icon(Icons.close),
                        deleteButton: const Icon(Icons.delete),
                      );
                    },
                    child: const Text('Customize styles'),
                  ),
                  ElevatedButton(
                    onPressed: () => screenLock(
                      context: context,
                      correctString: '1234',
                      onUnlocked: () {
                        Navigator.pop(context);
                        NextPage.show(context);
                      },
                    ),
                    child: const Text('Next page with unlock'),
                  ),
                  ElevatedButton(
                    onPressed: () => screenLock(
                      context: context,
                      correctString: '1234',
                      useBlur: false,
                      config: const ScreenLockConfig(
                        /// If you don't want it to be transparent, override the config
                        backgroundColor: Colors.black,
                        titleTextStyle: TextStyle(fontSize: 24),
                      ),
                    ),
                    child: const Text('Not blur'),
                  ),
                  ElevatedButton(
                    onPressed: () => screenLock(
                      context: context,
                      correctString: '1234',
                      maxRetries: 2,
                      retryDelay: const Duration(seconds: 3),
                      delayBuilder: (context, delay) => Text(
                        'Cannot be entered for ${(delay.inMilliseconds / 1000).ceil()} seconds.',
                      ),
                    ),
                    child: const Text('Delay next retry'),
                  ),
                  ElevatedButton(
                    onPressed: () => showDialog<void>(
                      context: context,
                      builder: (context) => ScreenLock(
                        correctString: '1234',
                        keyPadConfig: const KeyPadConfig(
                          clearOnLongPressed: true,
                        ),
                        onUnlocked: Navigator.of(context).pop,
                      ),
                    ),
                    child: const Text('Delete long pressed to clear input'),
                  ),
                  ElevatedButton(
                    onPressed: () => showDialog<void>(
                      context: context,
                      builder: (context) => ScreenLock(
                        correctString: '1234',
                        secretsBuilder: (
                          context,
                          config,
                          length,
                          input,
                          verifyStream,
                        ) =>
                            SecretsWithCustomAnimation(
                          verifyStream: verifyStream,
                          config: config,
                          input: input,
                          length: length,
                        ),
                        onUnlocked: Navigator.of(context).pop,
                      ),
                    ),
                    child: const Text('Secrets custom animation widget'),
                  ),
                  ElevatedButton(
                    onPressed: () => screenLock(
                      context: context,
                      correctString: '1234',
                      useLandscape: false,
                    ),
                    child: const Text('Disable landscape mode'),
                  ),
                  ElevatedButton(
                    onPressed: () => screenLock(
                      context: context,
                      correctString: 'x' * 4,
                      onValidate: (value) async => await Future<bool>.delayed(
                        const Duration(milliseconds: 500),
                        () => value == '1234',
                      ),
                    ),
                    child: const Text('Callback validation'),
                  ),
                ],
              ),
            ),
          ),
        ));
  }
}

class NextPage extends StatelessWidget {
  const NextPage({super.key});

  static show(BuildContext context) {
    Navigator.of(context)
        .push(MaterialPageRoute(builder: (context) => const NextPage()));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Next Page'),
      ),
    );
  }
}

class SecretsWithCustomAnimation extends StatefulWidget {
  const SecretsWithCustomAnimation({
    super.key,
    required this.config,
    required this.length,
    required this.input,
    required this.verifyStream,
  });

  final SecretsConfig config;
  final int length;
  final ValueListenable<String> input;
  final Stream<bool> verifyStream;

  @override
  State<SecretsWithCustomAnimation> createState() =>
      _SecretsWithCustomAnimationState();
}

class _SecretsWithCustomAnimationState extends State<SecretsWithCustomAnimation>
    with SingleTickerProviderStateMixin {
  late Animation<double> _animation;
  late AnimationController _animationController;

  @override
  void initState() {
    super.initState();

    widget.verifyStream.listen((valid) {
      if (!valid) {
        // scale animation.
        _animationController.forward();
      }
    });

    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 80),
    );

    _animation = Tween<double>(begin: 1, end: 2).animate(_animationController)
      ..addStatusListener(
        (status) {
          if (status == AnimationStatus.completed) {
            _animationController.reverse();
          }
        },
      );
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ScaleTransition(
      scale: _animation,
      child: Secrets(
        input: widget.input,
        length: widget.length,
        config: widget.config,
      ),
    );
  }
}
