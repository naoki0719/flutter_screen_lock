import 'package:flutter/material.dart';
import 'package:flutter_driver/driver_extension.dart';
import 'package:flutter_screen_lock/lock_screen.dart';

void main() {
  enableFlutterDriverExtension();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Example',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(title: 'Flutter Demo Home Page'),
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
      body: Container(
        child: Center(
          child: Column(
            children: <Widget>[
              RaisedButton(
                child: Text('Open showLockScreen'),
                onPressed: () {
                  showLockScreen(
                    context: context,
                    correctString: '1234',
                  );
                },
              ),
            child: Text('Open'),
            onPressed: () {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) {
                    return LockScreen(
                      correctString: '1234',
                      onCompleted: (context, enteredValue) {
                        print('OK' + enteredValue);
                        Navigator.of(context).maybePop();
                      },
                    );
                  },
                  fullscreenDialog: true,
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}
