import 'dart:convert';

import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:flutter_tube/models/video.dart';
import 'dart:async';

import 'package:shared_preferences/shared_preferences.dart';

class FavouriteBloc implements BlocBase{
  Map<String, Video> _favourites = {};

  final StreamController<Map<String, Video>> _favController = StreamController<Map<String, Video>>.broadcast();
  Stream<Map<String, Video>> get outFav => _favController.stream;

  FavouriteBloc(){
    SharedPreferences.getInstance().then((prefs){
      if(prefs.getKeys().contains("favourites")){
        _favourites = json.decode(prefs.getString("favourites")).map(
            (k, v){
              return MapEntry(k, Video.fromJson(v));
            }
        ).cast<String, Video>();
      }
    });
  }

  void toggleFavourite(Video video){
    if(_favourites.containsKey(video.id)) _favourites.remove(video.id);
    else _favourites[video.id] = video;

    _favController.sink.add(_favourites);
  }

  @override
  void dispose() {
    _favController.close();
  }


}