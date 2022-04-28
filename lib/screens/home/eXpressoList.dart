import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:provider/provider.dart';
import 'brew_tile.dart';

import '../../models/brew.dart';

class eXpressoList extends StatefulWidget {
  const eXpressoList({ Key? key }) : super(key: key);

  @override
  State<eXpressoList> createState() => _eXpressoListState();
}

class _eXpressoListState extends State<eXpressoList> {

  @override
  Widget build(BuildContext context) {
    final brews = Provider.of<List<Brew>>(context);

  // print(brews.documents);
    brews.forEach((brew) {
      print(brew.name);
      print(brew.sugars);
      print(brew.strength);
    });

    return ListView.builder(
      itemCount: brews.length,
      itemBuilder: (context, index) {
        return BrewTile(brew: brews[index]);
      },
    );
  }
}