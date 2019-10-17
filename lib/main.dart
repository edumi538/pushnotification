import 'package:flutter/material.dart';
import 'package:firebase_messaging/firebase_messaging.dart';

void main() => runApp(new MyApp());

class MyApp extends StatefulWidget {
  @override 
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  String textValue = 'Hello World';
  FirebaseMessaging firebaseMessaging = new FirebaseMessaging();

  @override
  void initState(){
    firebaseMessaging.configure(
      onLaunch: (Map<String, dynamic>msg){
        print("OnLauch called");
      },
      onResume: (Map<String, dynamic>msg){
        print("OnResume called");
      },
      onMessage: (Map<String, dynamic> msg){
        print("OnMessage called");
      }
    );
    firebaseMessaging.requestNotificationPermissions(
      const IosNotificationSettings(
        sound: true,
        alert: true,
        badge: true
      )
    );
    firebaseMessaging.onIosSettingsRegistered.listen((IosNotificationSettings setting){

      print('IOS Setting Registed');

    });
    firebaseMessaging.getToken().then((token){

      update(token);

      });
    }
    update(String token){
      print(token);
      textValue = token;
      setState(() {
        
      });
    }
        @override 
        Widget build(BuildContext context){
          return new MaterialApp(
            home: new Scaffold(
              appBar: new AppBar(
                title: new Text('Push Notification'),
              ),
              body: new Center(
                child: new Text(
                  textValue,
                ),
              ),
            ),
          );
        }
} 