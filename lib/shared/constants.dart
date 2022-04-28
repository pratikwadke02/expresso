import 'package:flutter/material.dart';

const textInputDecoration = InputDecoration(
  fillColor: Colors.white,
  filled: true,
  enabledBorder: OutlineInputBorder(
    borderSide: BorderSide(color: Colors.white),
  ),
  focusedBorder: OutlineInputBorder(
    borderSide: BorderSide(color: Colors.brown, width: 2),
  ),
  errorBorder: OutlineInputBorder(
    borderSide: BorderSide(color: Colors.red, width: 2),
  ),
  focusedErrorBorder: OutlineInputBorder(
    borderSide: BorderSide(color: Colors.red, width: 2),
  ),
);
// import 'package:flutter/material.dart';

// InputDecoration textInputDecoration(){
//   return InputDecoration(
//     hintText: hintText,
//     hintStyle: TextStyle(
//       color: Colors.grey,
//     ),
//     fillColor: Colors.white,
//     filled: true,
//     border: OutlineInputBorder(
//       borderRadius: BorderRadius.circular(10.0),
//     ),
//     // focusedBorder: UnderlineInputBorder(
//     //   borderRadius: BorderRadius.circular(10.0),
//     //   borderSide: BorderSide(
//     //     color: Colors.brown,
//     //   ),
//     // ),
//     // enabledBorder: UnderlineInputBorder(
//     //   borderRadius: BorderRadius.circular(10.0),
//     //   borderSide: BorderSide(
//     //     color: Colors.brown,
//     //   ),
//     // ),
//   );
// }

//  InputDecoration(
//                   hintText: 'Password',
//                   fillColor: Colors.white,
//                   filled: true,
//                   border: OutlineInputBorder(
//                     borderRadius: BorderRadius.circular(10.0),
//                   ),
//                 ),