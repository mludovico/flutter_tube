import 'dart:convert';
import 'package:http/http.dart' as http;
import 'models/video.dart';

const API_KEY = "AIzaSyCx4YxKsxbKBvMi2xNIbNjKYZOlJBeOrI0";

class Api{

  String _search;
  String _nextToken;

  Future<List> search(String search) async {
    _search = search;
    http.Response response = await http.get(
        "https://www.googleapis.com/youtube/v3/search?"
          "part=snippet&"
          "q=$search&"
          "type=video&"
          "key=$API_KEY&"
          "maxResults=10&"
    );
    return decodeJson(response);
  }

  Future<List> nextPage() async {
    http.Response response = await http.get(
        "https://www.googleapis.com/youtube/v3/search?"
            "part=snippet&"
            "q=$_search&"
            "type=video&"
            "key=$API_KEY&"
            "maxResults=10&"
            "pageToken=$_nextToken"
    );
    return decodeJson(response);
  }

  List<Video> decodeJson(http.Response response){
    if(response.statusCode == 200){
      var decoded = json.decode(response.body);
      _nextToken = decoded["nextPageToken"];
      List<Video> videos = decoded["items"].map<Video>((map){
        return Video.fromJson(map);
      }).toList();
      return videos;
    }else{
      throw Exception("Falha ao carregar videos");
    }
  }
}