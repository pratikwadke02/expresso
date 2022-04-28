import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:expresso/models/brew.dart';
import 'package:expresso/models/brew.dart';
import 'package:expresso/models/users.dart';

class DatabaseService {

  final String? uid;
  DatabaseService({required this.uid});

  //collection reference
  final CollectionReference eXpressoCollection = FirebaseFirestore.instance.collection('eXpresso');

  Future updateUserData (String sugars, String name, int strength) async {
    return await eXpressoCollection.doc(uid).set({
      'sugars': sugars,
      'name': name,
      'strength': strength,
    });
  }


  //brew list from snapshot
  List<Brew> _brewListFromSnapshot(QuerySnapshot snapshot){
    return snapshot.docs.map((doc) {
      return Brew(
        name: doc.get('name')??" ",
        strength: doc.get('strength')?? 0,
        sugars: doc.get('sugars')??'0',
      );
    }).toList();
  }

  //get expresso stream
  Stream<List<Brew>> get brews {
    return eXpressoCollection.snapshots().map(_brewListFromSnapshot);
  } 

  //user data from doc snapshot
  UserData _userDataFromSnapshot(DocumentSnapshot snapshot){
    return UserData(
      uid: uid,
      name: snapshot.get('name')??" ",
      sugars: snapshot.get('sugars')??'0',
      strength: snapshot.get('strength')?? 0,
    );
  }

  //get user doc stream
  Stream<UserData?> get myUserData {
    return eXpressoCollection.doc(uid).snapshots().map(_userDataFromSnapshot);
  }

}