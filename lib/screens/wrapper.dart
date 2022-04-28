import 'package:expresso/screens/authenticate/authenticate.dart';
import 'package:expresso/screens/home/home.dart';
import 'package:flutter/material.dart';
import 'package:expresso/screens/home/home.dart';
import 'package:provider/provider.dart';
import 'package:expresso/models/users.dart';

class Wrapper extends StatelessWidget {
  const Wrapper({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    final users = Provider.of<MyUser?>(context);
    //run either auth or home
    if(users == null){
      return Authenticate();
    }else{
      return Home();
    }
  }
}