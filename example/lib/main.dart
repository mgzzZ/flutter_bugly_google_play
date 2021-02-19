import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bugly/flutter_bugly.dart';

void main() => INFlutterBugly.postCatchedException(
      () => runApp(MyApp()),
    );

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  String _platformVersion = 'Unknown';

  @override
  void initState() {
    super.initState();
    INFlutterBugly.init(
      androidAppId: "your android id",
      iOSAppId: "your app id",
    ).then((_result) {
      setState(() {
        _platformVersion = _result.message;
        print(_result.appId);
      });
    });
    INFlutterBugly.setUserId("user id");
    INFlutterBugly.putUserData(key: "key", value: "value");
    int tag = 9527;
    INFlutterBugly.setUserTag(tag);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Plugin example app'),
      ),
      body: GestureDetector(
        onTap: () {
          if (Platform.isAndroid) {
            // todo
          }
        },
        child: Center(
          child: Text('init result: $_platformVersion\n'),
        ),
      ),
    );
  }
}
