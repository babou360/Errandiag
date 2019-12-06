import 'package:errandiaga/notifier/auth_notifier.dart';
import 'package:errandiaga/screens/feed.dart';
import 'package:errandiaga/screens/login.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() => runApp(
  MultiProvider(providers: [
    ChangeNotifierProvider(builder: (context)=>AuthNotifier(),)
  ],
  child: MyApp(),)
);

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        //primarySwatch: Colors.blue,
        primarySwatch: Colors.yellow,
      ),
     home: Consumer<AuthNotifier>(
        builder: (context,notifier,child){
          return notifier.user !=null? Feed() : Login();
        }
     )
    );
  }
}

