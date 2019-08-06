import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:flutter/material.dart';
import 'package:flutter_tube/screens/home.dart';
import 'blocs/favourite_bloc.dart';
import 'blocs/videos_bloc.dart';

void main(){
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      bloc: VideoBloc(),
      child: BlocProvider(
        bloc: FavouriteBloc(),
        child: MaterialApp(
          title: "Flutter Tube",
          debugShowCheckedModeBanner: false,
          home: Home(),
        ),
      )
    );
  }
}
