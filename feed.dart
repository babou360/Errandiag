import 'package:errandiaga/api/product_api.dart';
import 'package:errandiaga/notifier/auth_notifier.dart';
import 'package:errandiaga/screens/product_form.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Feed extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    AuthNotifier authNotifier=Provider.of<AuthNotifier>(context,listen: false);
    return Scaffold(
      appBar: AppBar(
        title: Text(authNotifier.user!=null? authNotifier.user.displayName : "Feed"
        ,style: TextStyle(fontSize: 30,color: Colors.black),),
        backgroundColor: Colors.white,
        elevation: 1.5,
        centerTitle: true,
        actions: <Widget>[
          FlatButton(
            onPressed: ()=> signOut(authNotifier),
            child: Text('Logout',style:TextStyle(color: Colors.black)),
          )
        ],
      ),
      body: Container(
        color: Colors.white,
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: (){
          Navigator.of(context).push(
            MaterialPageRoute(builder: (BuildContext context)=>ProductForm()) );
        },
        backgroundColor: Colors.black38,
        child: Icon(Icons.add_a_photo),
        foregroundColor: Colors.white,
      ),
    );
  }
}