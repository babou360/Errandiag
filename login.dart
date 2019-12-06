import 'package:errandiaga/api/product_api.dart';
import 'package:errandiaga/model/user.dart';
import 'package:errandiaga/notifier/auth_notifier.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

enum AuthMode{SignUp,Login}

class Login extends StatefulWidget {
  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final GlobalKey<FormState> _formKey=GlobalKey<FormState>();
  final TextEditingController _passwordController=TextEditingController();
  AuthMode _authMode=AuthMode.Login;

  User _user=User();

  @override
  void initState() {
    AuthNotifier authNotifier=Provider.of<AuthNotifier>(context,listen: false);
    initializeCurrentUser(authNotifier);
    super.initState();
  }

  void _submitForm(){
    if(!_formKey.currentState.validate()){
      return;
    }
    _formKey.currentState.save();

    AuthNotifier authNotifier=Provider.of<AuthNotifier>(context,listen: false);

    if(_authMode==AuthMode.Login){
      login(_user,authNotifier);
    }else{
      signUp(_user,authNotifier);
    }
  }

  Widget _buildDiplayNameField(){
    return TextFormField(
      decoration: InputDecoration(
        labelText: 'Display Name',
        icon: Icon(Icons.account_circle)
      ),
      keyboardType: TextInputType.text,
      style: TextStyle(fontSize: 10),
      validator: (String value){
        if(value.isEmpty){
          return 'Display name is required';
        }
        if(value.length<5 || value.length>12){
          return 'Must be between 5 and 12';
        }else{
          return null;
        }
      },
      onSaved: (String value){
        _user.displayName=value;
      },
    );
  }
  Widget _buildEmailField(){
    return TextFormField(
      decoration: InputDecoration(
        labelText: 'Email',
        icon: Icon(Icons.email)
      ),
      //initialValue: 'Leebabou@gmail.com',
      keyboardType: TextInputType.emailAddress,
      style: TextStyle(fontSize: 10),
      validator: (String value){
        if(value.isEmpty){
          return 'Email is required';
        }
        if(!RegExp(
          r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$'
        ).hasMatch(value)){
          return 'Please enter a valid email address';
        }else{
          return null;
        }
      },
      onSaved: (String value){
        _user.email=value;
      },
    );
  }

  Widget _buildPasswordField(){
    return TextFormField(
      decoration: InputDecoration(
        labelText: 'Password',
        icon: Icon(Icons.lock)
      ),
      keyboardType: TextInputType.text,
      style: TextStyle(fontSize: 10),
      obscureText: true,
      controller: _passwordController,
      validator: (String value){
        if(value.isEmpty){
          return 'Password is required';
        }
        if(value.length<5 || value.length>20){
          return 'Must be between 5 and 20';
        }else{
          return null;
        }
      },
      onSaved: (String value){
        _user.password=value;
      },
    );
  }

  Widget _buildConfirmPasswordField(){
    return TextFormField(
      decoration: InputDecoration(
        labelText: 'Confirm Password',
        icon: Icon(Icons.lock)
      ),
      keyboardType: TextInputType.text,
      style: TextStyle(fontSize: 10),
      obscureText: true,
      //controller: _passwordController,
      validator: (String value){
        if(value.isEmpty){
          return 'Password is required';
        }
        if(value.length<5 || value.length>20){
          return 'Must be between 5 and 20';
        }if(_passwordController.text !=value){
          return 'Passwords do not match';
        }else{
          return null;
        }
      },
      onSaved: (String value){
        _user.password=value;
      },
    );
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
     body: Form(
       autovalidate: true,
       key: _formKey,
       child: SingleChildScrollView(
         child: Padding(
           padding: EdgeInsets.fromLTRB(32, 96, 32, 0),
           child: Column(
             children: <Widget>[
               Text(
                 "Please Sign in",
                 textAlign: TextAlign.center,
                 style: TextStyle(fontSize: 36),
                 ),
                 SizedBox(
                   height: 32,
                 ),
                 _authMode==AuthMode.SignUp? _buildDiplayNameField() : Container(),
                 _buildEmailField(),
                 _buildPasswordField(),
                 _authMode==AuthMode.SignUp? _buildConfirmPasswordField() : Container(),
                 SizedBox(height: 32,),
                 RaisedButton(
                   padding: EdgeInsets.all(10),
                   child: Text('switch to ${_authMode==AuthMode.Login? 'SignUp' : 'Login'}',
                   style: TextStyle(fontSize: 20),
                   ),
                   onPressed: (){
                     setState(() {
                       _authMode=_authMode==AuthMode.Login? AuthMode.SignUp: AuthMode.Login;
                     });
                   },
                 ),
                 SizedBox(height: 16,),
                 RaisedButton(
                   padding: EdgeInsets.all(10),
                   onPressed: ()=> _submitForm(),
                   child: Text(
                     _authMode==AuthMode.Login? 'Login':'SignUp',
                     style: TextStyle(fontSize: 20)
                   ),

                 )
             ],
           ),
         ),
       ),
     ), 
    );
  }
}