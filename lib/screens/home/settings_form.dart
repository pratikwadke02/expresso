import 'package:expresso/models/users.dart';
import 'package:expresso/services/database.dart';
import 'package:expresso/shared/loading.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:expresso/shared/constants.dart';
import 'package:provider/provider.dart';

class SettingsForm extends StatefulWidget {
  const SettingsForm({Key? key}) : super(key: key);

  @override
  State<SettingsForm> createState() => _SettingsFormState();
}

class _SettingsFormState extends State<SettingsForm> {
  final _formKey = GlobalKey<FormState>();
  final List<String> sugars = ['0', '1', '2', '3', '4'];

  String? _currentName;
  String? _currentSugars;
  int? _currentStrength;

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<MyUser>(context);
    return StreamBuilder<UserData?>(
        stream: DatabaseService(uid: user.uid).myUserData,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            UserData? userData = snapshot.data;
            return Form(
              key: _formKey,
              child: Column(
                children: [
                  Text(
                    'Update your brew settings',
                    style: Theme.of(context).textTheme.headline6,
                  ),
                  SizedBox(height: 20),
                  TextFormField(
                    initialValue: userData?.name,
                    decoration: textInputDecoration.copyWith(hintText: 'Name'),
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Please enter a name';
                      }
                      return null;
                    },
                    onChanged: (value) {
                      _currentName = value;
                    },
                  ),
                  SizedBox(height: 20),
                  // dropdown
                  DropdownButtonFormField(
                    decoration: textInputDecoration.copyWith(
                        hintText: 'How much sugar?'),
                    value: _currentSugars ?? userData!.sugars,
                    items: sugars.map((sugar) {
                      return DropdownMenuItem(
                        value: sugar,
                        child: Text('$sugar sugars'),
                      );
                    }).toList(),
                    onChanged: (value) {
                      _currentSugars = value.toString();
                    },
                  ),
                  SizedBox(height: 20),

                  // slider
                  Slider(
                    value: (_currentStrength ?? userData!.strength ?? 100)
                        .toDouble(),
                    activeColor: Colors
                        .brown[_currentStrength ?? userData!.strength ?? 100],
                    inactiveColor: Colors
                        .brown[_currentStrength ?? userData!.strength ?? 100],
                    min: 100.0,
                    max: 900.0,
                    divisions: 8,
                    onChanged: (value) {
                      setState(() {
                        _currentStrength = value.round();
                      });
                    },
                  ),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      primary: Colors.pink[400],
                    ),
                    child: Text(
                      'Update',
                      style: TextStyle(color: Colors.white),
                    ),
                    onPressed: () async {
                      print(_currentName);
                      print(_currentStrength);
                      print(_currentSugars);

                      if (_formKey.currentState!.validate()) {
                        await DatabaseService(uid: user.uid).updateUserData(
                          _currentSugars ?? userData!.sugars ?? '0',
                          _currentName ?? userData!.name ?? '',
                          _currentStrength ?? userData!.strength ?? 100,
                        );
                        Navigator.pop(context);
                      }
                    },
                  ),
                ],
              ),
            );
          }
          return Loading();
        });
  }
}
// class SettingsForm extends StatefulWidget {
//   const SettingsForm({ Key? key }) : super(key: key);

//   @override
//   State<SettingsForm> createState() => _SettingsFormState();
// }

// class _SettingsFormState extends State<SettingsForm> {

//   final _formKey = GlobalKey<FormState>();
//   final List<String> sugars = ['0', '1', '2', '3', '4'];

//   //from values
//   String? _currentName;
//   String? _currentSugars;
//   int? _currentStrength;

//   @override
//   Widget build(BuildContext context) {

    
//    final user = Provider.of<MyUser>(context);
//    return StreamBuilder<UserData?>(
//      stream: DatabaseService(uid:user.uid).UserData,
//      builder: (context, snapshot) {
//        if(snapshot.hasData){

//          UserData? userData = snapshot.data;

//          return Form(
//          key: _formKey,
//          child: Column(
//            children: [
//            Text('Update your eXpresso settings',
//             style: TextStyle(fontSize: 18.0)),
//             SizedBox(height: 20.0,),
//             TextFormField(
//               initialValue: userData?.name,
//               decoration: textInputDecoration('Enter Name'),
//               validator: (String? value){
//                 if(value != null && value.isEmpty){
//                   return 'Please enter a name';
//                 }
//                 return null;
//               },
//               onChanged: (val){
//                 setState(() {
//                   _currentName = val;
//                 });
//               },
//             ),
//             SizedBox(height: 20.0,),
//             //dropdown
//             DropdownButtonFormField<String>(
//               decoration: textInputDecoration('Sugars'),
//               value: _currentSugars = userData?.sugars,
//               items: sugars.map((sugar){
//                 return DropdownMenuItem(
//                   value: sugar,
//                   child: Text('$sugar sugars'),
//                 );
//               }).toList(),
//               onChanged: (val){
//                 setState(() {
//                   _currentSugars = val!;
//                 });
//               },
//             ),
//             //slider
//             SizedBox(height: 20.0,),
//             Slider(
//               value: (_currentStrength ?? userData!.strength).toDouble(),
//               activeColor: Colors.brown[_currentStrength ?? 100],
//               inactiveColor: Colors.brown[_currentStrength ?? 100],
//               min: 100.0,
//               max: 900.0,
//               divisions: 8,
//               onChanged: (val){
//                 setState(() {
//                   _currentStrength = val.round();
//                 });
//               },
//             ),
//             RaisedButton(
//               color: Colors.pink[400],
//               child: Text('Update',
//               style: TextStyle(color: Colors.white),
//               ),
//               onPressed: () async{
//                 print(_currentName);
//                 print(_currentSugars);
//                 print(_currentStrength);
//               },
//             )
//          ],
//          ),
   
//        );
//        }else{
//          return Loading();
//        }
       
//      }
//    );
//   }
// }