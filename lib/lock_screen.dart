import 'dart:async';
import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'dot_secret_ui.dart';
import 'circle_input_button.dart';

Future showLockScreen({
  @required BuildContext context,
  String correctString,
  String title = 'Please enter passcode.',
  String cancelText = 'Cancel',
  String deleteText = 'Delete',
  Widget leftSideButton,
  int digits = 4,
  DotSecretConfig dotSecretConfig = const DotSecretConfig(),
  bool canCancel = true,
  void Function(BuildContext, String) onCompleted,
}) {
  return Navigator.of(context).push(
    PageRouteBuilder(
      opaque: false,
      pageBuilder: (
        BuildContext context,
        Animation<double> animation,
        Animation<double> secodaryAnimation,
      ) {
        return LockScreen(
          correctString: correctString,
          title: title,
          leftSideButton: leftSideButton,
          digits: digits,
          dotSecretConfig: dotSecretConfig,
          onCompleted: onCompleted,
          canCancel: canCancel,
          cancelText: cancelText,
          deleteText: deleteText,
        );
      },
      transitionsBuilder: (
        BuildContext context,
        Animation<double> animation,
        Animation<double> secondaryAnimation,
        Widget child,
      ) {
        return SlideTransition(
          position: Tween<Offset>(
            begin: const Offset(0.0, 2.4),
            end: Offset.zero,
          ).animate(animation),
          child: SlideTransition(
            position: Tween<Offset>(
              begin: Offset.zero,
              end: const Offset(0.0, 2.4),
            ).animate(secondaryAnimation),
            child: child,
          ),
        );
      },
    ),
  );
}

class LockScreen extends StatefulWidget {
  final String correctString;
  final String title;
  final Widget rightSideButton;
  final Widget leftSideButton;
  final int digits;
  final DotSecretConfig dotSecretConfig;
  final bool canCancel;
  final String cancelText;
  final String deleteText;
  final void Function(BuildContext, String) onCompleted;

  LockScreen({
    this.correctString,
    this.title = 'Please enter passcode.',
    this.digits = 4,
    this.dotSecretConfig = const DotSecretConfig(),
    this.rightSideButton,
    this.leftSideButton,
    this.canCancel = true,
    this.cancelText,
    this.deleteText,
    this.onCompleted,
  });

  @override
  _LockScreenState createState() => _LockScreenState();
}

class _LockScreenState extends State<LockScreen> {
  // receive from circle input button
  final StreamController<String> enteredStream = StreamController<String>();
  final StreamController<void> removedStreamController =
      StreamController<void>();
  final StreamController<int> enteredLengthStream =
      StreamController<int>.broadcast();
  final StreamController<bool> validateStreamController =
      StreamController<bool>();

  List<String> enteredValues = List<String>();

  _removedStreamListener() {
    if (removedStreamController.hasListener) {
      return;
    }

    removedStreamController.stream.listen((_) {
      enteredValues.removeLast();
      enteredLengthStream.add(enteredValues.length);
    });
  }

  _enteredStreamListener() {
    if (enteredStream.hasListener) {
      return;
    }

    enteredStream.stream.listen((value) {
      // add list entered value
      enteredValues.add(value);
      enteredLengthStream.add(enteredValues.length);

      // the same number of digits was entered.
      if (enteredValues.length == widget.digits) {
        StringBuffer buffer = StringBuffer();
        enteredValues.forEach((value) {
          buffer.write(value);
        });
        _verifyCorrectString(buffer.toString());
      }
    });
  }

  void _verifyCorrectString(String enteredValue) {
    Future.delayed(Duration(milliseconds: 150), () {
      if (enteredValue == widget.correctString) {
        // send valid status to DotSecretUI
        validateStreamController.add(true);
        enteredValues.clear();
        enteredLengthStream.add(enteredValues.length);

        if (widget.onCompleted != null) {
          // call user function
          widget.onCompleted(context, enteredValue);
        } else {
          Navigator.of(context).maybePop();
        }
      } else {
        // send invalid status to DotSecretUI
        validateStreamController.add(false);
        enteredValues.clear();
        enteredLengthStream.add(enteredValues.length);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    _enteredStreamListener();
    _removedStreamListener();
    double _rowMarginSize = MediaQuery.of(context).size.width * 0.025;
    double _columnMarginSize = MediaQuery.of(context).size.width * 0.065;

    return Scaffold(
      backgroundColor: Colors.white.withOpacity(0.5),
      body: SafeArea(
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 3.5, sigmaY: 3.5),
          child: Column(
            children: <Widget>[
              _buildTitle(),
              DotSecretUI(
                validateStream: validateStreamController.stream,
                dots: widget.digits,
                config: widget.dotSecretConfig,
                enteredLengthStream: enteredLengthStream.stream,
              ),
              Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: _columnMarginSize,
                ),
                child: Column(
                  children: <Widget>[
                    Container(
                      margin: EdgeInsets.symmetric(vertical: _rowMarginSize),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: <Widget>[
                          _buildNumberTextButton(context, '1'),
                          _buildNumberTextButton(context, '2'),
                          _buildNumberTextButton(context, '3'),
                        ],
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.symmetric(vertical: _rowMarginSize),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: <Widget>[
                          _buildNumberTextButton(context, '4'),
                          _buildNumberTextButton(context, '5'),
                          _buildNumberTextButton(context, '6'),
                        ],
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.symmetric(vertical: _rowMarginSize),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: <Widget>[
                          _buildNumberTextButton(context, '7'),
                          _buildNumberTextButton(context, '8'),
                          _buildNumberTextButton(context, '9'),
                        ],
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.symmetric(vertical: _rowMarginSize),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: <Widget>[
                          _buildBothSidesButton(context, _leftSideButton()),
                          _buildNumberTextButton(context, '0'),
                          _buildBothSidesButton(context, _rightSideButton()),
                        ],
                      ),
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildNumberTextButton(
    BuildContext context,
    String number,
  ) {
    final buttonSize = MediaQuery.of(context).size.width * 0.215;
    return Container(
      width: buttonSize,
      height: buttonSize,
      child: CircleInputButton(
        enteredSink: enteredStream.sink,
        text: number,
      ),
    );
  }

  Widget _buildBothSidesButton(BuildContext context, Widget button) {
    final buttonSize = MediaQuery.of(context).size.width * 0.215;
    return Container(
      width: buttonSize,
      height: buttonSize,
      child: button,
    );
  }

  Widget _buildTitle() {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 20),
      child: Text(
        widget.title,
        style: TextStyle(fontSize: 20.0),
      ),
    );
  }

  Widget _leftSideButton() {
    if (widget.leftSideButton != null) return widget.leftSideButton;

    return null;
  }

  Widget _rightSideButton() {
    if (widget.rightSideButton != null) return widget.rightSideButton;

    return StreamBuilder<int>(
        stream: enteredLengthStream.stream,
        builder: (context, snapshot) {
          String buttonText;
          if (snapshot.hasData && snapshot.data > 0) {
            buttonText = widget.deleteText;
          } else if (widget.canCancel) {
            buttonText = widget.cancelText;
          } else {
            return Container();
          }

          return FlatButton(
            padding: EdgeInsets.all(0),
            child: Text(
              buttonText,
              style: TextStyle(
                fontSize: MediaQuery.of(context).size.width * 0.055,
              ),
              softWrap: false,
              textAlign: TextAlign.center,
            ),
            onPressed: () {
              if (snapshot.hasData && snapshot.data > 0) {
                removedStreamController.sink.add(null);
              } else {
                if (widget.canCancel) {
                  Navigator.of(context).maybePop();
                }
              }
            },
            shape: CircleBorder(
              side: BorderSide(
                color: Colors.transparent,
                style: BorderStyle.solid,
              ),
            ),
            color: Colors.transparent,
          );
        });
  }

  @override
  void dispose() {
    enteredStream.close();
    enteredLengthStream.close();
    validateStreamController.close();
    removedStreamController.close();
    super.dispose();
  }
}
