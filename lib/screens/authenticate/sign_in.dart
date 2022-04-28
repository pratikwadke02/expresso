import 'package:expresso/services/auth.dart';
import 'package:expresso/shared/constants.dart';
import 'package:flutter/material.dart';

import '../../shared/loading.dart';

class SignIn extends StatefulWidget {

  final Function toggleView;
  SignIn({required this.toggleView});

  @override
  _SignInState createState() => _SignInState();
}

class _SignInState extends State<SignIn> {

  final AuthService _auth = AuthService();
  final _formKey = GlobalKey<FormState>();
  bool loading = false;

  //text field state
  String email = '';
  String password = '';
  String error = '';


  @override
  Widget build(BuildContext context) {
    return loading ? Loading() : Scaffold(
      backgroundColor: Colors.brown[100],
      appBar: AppBar(
        backgroundColor: Colors.brown[400],
        elevation: 0.0,
        title: Text('Sign in to eXpresso'),
        actions: [
          FlatButton.icon(
            icon:Icon(Icons.person),
            label: Text('Register'),
            onPressed: (){
              widget.toggleView();
            },
          )
        ],
      ),
      body: Container(
        padding: EdgeInsets.symmetric(vertical: 20.0, horizontal: 50.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              SizedBox(height: 20.0,),
              TextFormField(
                validator:(String? value){
                  if(value != null && value.isEmpty){
                    return 'Please enter an email';
                  }
                  return null;
                },
                onChanged: (val){
                  setState(() {
                    email = val;
                  });
                },
                decoration: textInputDecoration.copyWith(hintText: 'Email'),
              ),
              SizedBox(height: 20.0,),
              TextFormField(
                obscureText: true,
                 validator: (String? value){
                  if(value != null && value.isEmpty){
                    if(value.length < 6){
                      return 'Please enter a password';
                    }else{
                      return null;
                    }
                  }else{
                    if(value != null && value.length < 6){
                      return 'Please enter password with 6 or more characters';
                    }else{
                    return null;
                    }
                  }
                },
                onChanged: (val){
                  setState(() {
                    password = val;
                  });
                },
                decoration: textInputDecoration.copyWith(hintText: 'Password'),
              ),
              SizedBox(height: 20.0,),
              RaisedButton(
                onPressed: ()async{
                   if(_formKey.currentState!.validate()){
                     setState(() {
                       loading = true;
                     });
                    print('valid');
                    dynamic result = await _auth.signInWithEmailAndPassword(email, password);
                    if(result == null){
                      setState(() {
                        error = 'Wrong credentials';
                        loading = false;
                      });
                    }else{
                      print('success');
                    }
                }
                },
                color: Colors.pink[400],
                child: Text('Sign in',
                  style: TextStyle(color: Colors.white),
                ),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10.0),
                ),
              ),
              SizedBox(height: 12.0,),
              Text(
                error,
                style: TextStyle(color: Colors.red, fontSize: 14.0),
              ),
            ]),
            )
        ),
      );
  }
}
