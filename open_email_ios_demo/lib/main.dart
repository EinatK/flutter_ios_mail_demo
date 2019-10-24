import 'dart:io';
import 'package:url_launcher/url_launcher.dart';

import 'package:flutter/material.dart';
import 'package:flutter_appavailability/flutter_appavailability.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatelessWidget {
  void _openMailWithUrlLauncher() async {
    const url = 'mailto:foo@bar.com';
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }

  void _openMailWithAppAvailablility(BuildContext context) {
    try {
      AppAvailability.launchApp(
              Platform.isIOS ? "mailto:foo@bar.com" : "com.google.android.gm")
          .then((_) {
        print("App Email launched!");
      }).catchError((err) {
        Scaffold.of(context)
            .showSnackBar(SnackBar(content: Text("App Email not found!")));
        print(err);
      });
    } catch (e) {
      Scaffold.of(context)
          .showSnackBar(SnackBar(content: Text("Email App not found!")));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Open mail demo'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Padding(
              padding: EdgeInsets.all(16.0),
              child: ButtonTheme(
                minWidth: MediaQuery.of(context).size.width,
                height: 50,
                buttonColor: Colors.blue,
                child: RaisedButton(
                  child: Text(
                    'Open email app with app url launcher package',
                    style: TextStyle(fontSize: 18, color: Colors.white),
                    textAlign: TextAlign.center,
                  ),
                  onPressed: _openMailWithUrlLauncher,
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.all(16.0),
              child: ButtonTheme(
                minWidth: MediaQuery.of(context).size.width,
                height: 50,
                buttonColor: Colors.blue,
                child: RaisedButton(
                  child: Text(
                    'Open email app with app availablility package',
                    style: TextStyle(fontSize: 18, color: Colors.white),
                    textAlign: TextAlign.center,
                  ),
                  onPressed: () {
                    _openMailWithAppAvailablility(context);
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
