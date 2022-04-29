import 'package:expresso/models/brew.dart';
import 'package:expresso/models/users.dart';
import 'package:expresso/screens/home/settings_form.dart';
import 'package:expresso/services/auth.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:expresso/services/database.dart';
import 'package:provider/provider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:expresso/screens/home/eXpressoList.dart';
import 'package:expresso/models/brew.dart';

class Home extends StatelessWidget {
  Home({Key? key}) : super(key: key);

  final AuthService _auth = AuthService();

  @override
  Widget build(BuildContext context) {

    final user = Provider.of<MyUser?>(context);

    void _showSettingsPanel() {
      showModalBottomSheet(
        context: context,
         builder: (context) {
           return Container(
             padding: EdgeInsets.symmetric(vertical: 20.0, horizontal: 60.0),
             child: SettingsForm(),
           );
      });
    }
      return StreamProvider<List<Brew>?>.value(

      value: DatabaseService(uid: user!.uid).brews,
      initialData: null,
      child: Scaffold(
        backgroundColor: Colors.brown[50],
        appBar: AppBar(
          backgroundColor: Colors.brown[400],
          elevation: 0.0,
          title: Text('eXpresso'),
          actions: [
            FlatButton.icon(
              onPressed: ()async{
                await _auth.signOut();
            },
            icon: Icon(Icons.person),
            label: Text('logout'),
            ),
            FlatButton.icon(
              icon: Icon(Icons.settings),
              label: Text('settings'),
              onPressed: (){
                _showSettingsPanel();
              },
              )
          ],
        ),
        body: Container(
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage('assets/coffee_bg.png'),
              fit: BoxFit.cover,
            ),
          ),
          child: eXpressoList()
          ),
      ),
    );
  }
}
