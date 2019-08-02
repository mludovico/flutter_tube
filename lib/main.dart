import 'package:flutter/material.dart';
import 'package:flutter_tube/screens/home.dart';

import 'api.dart';

void main(){
  Api api = Api();
  api.search("eletro");

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Flutter Tube",
      debugShowCheckedModeBanner: false,
      home: Home(),
    );
  }
}
