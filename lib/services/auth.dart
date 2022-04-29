import 'package:expresso/services/database.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:expresso/models/users.dart';

class AuthService{

  final FirebaseAuth _auth = FirebaseAuth.instance;

  //create user object based on firebase user
  MyUser? _userFromCredUser(User? user){
    return user != null ? MyUser(uid: user.uid) : null;
  }

  //auth change user stream
  Stream<MyUser?>get user {
    return _auth.authStateChanges().map(_userFromCredUser);
  }
  //underscore for private

  //sign in anonymously
  Future signInAnon() async{
    try{
      UserCredential userCredential = await FirebaseAuth.instance.signInAnonymously();
      User? user = userCredential.user;
      return _userFromCredUser(user!);
    }catch(e){
      print(e.toString());
      return null;
    }
  }
  

  //sign in email & pass
  Future signInWithEmailAndPassword(String email, String password) async{
    try{
      UserCredential userCredential = await FirebaseAuth.instance.signInWithEmailAndPassword(email: email, password: password);
      User? user = userCredential.user;
      //craete a new document for the user with the uid
      return _userFromCredUser(user!);
    }catch(e){
      print(e.toString());
      return null;
    }
  }

  //reg with email & pass
  Future registerWithEmailAndPassword(String email, String password) async{
    try{
      UserCredential userCredential = await FirebaseAuth.instance.createUserWithEmailAndPassword(email: email, password: password);
      User? user = userCredential.user;
      await DatabaseService(uid: user!.uid).updateUserData('0', 'new user', 100);
      return _userFromCredUser(user);
    }catch(e){
      print(e.toString());
      return null;
    }
  }

  //sign out
  Future signOut() async{
    try{
      return await _auth.signOut();
    }catch(e){
      print(e.toString());
      return null;
    }
  }
}
