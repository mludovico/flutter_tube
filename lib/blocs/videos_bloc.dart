import 'dart:async';
import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:flutter_tube/models/video.dart';
import '../api.dart';

class VideoBloc extends BlocBase{
  Api api;
  List<Video> videos;

  final StreamController<List<Video>> _videosController = StreamController<List<Video>>();
  Stream get outVideos => _videosController.stream;

  final StreamController<String> _searchController = StreamController<String>();
  Sink get inSearch => _searchController.sink;

  VideoBloc(){
    api = Api();
    _searchController.stream.listen(_search);

  }

  void _search(String search) async {
    if(search != null)
      videos = await api.search(search);
    else
      videos += await api.nextPage();
    print(videos);
    _videosController.sink.add(videos);
  }

  @override
  void dispose() {
    _videosController.close();
    _searchController.close();
  }


}