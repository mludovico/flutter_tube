import 'dart:convert';

import 'package:http/http.dart' as http;

import 'models/video.dart';

const API_KEY = "AIzaSyCx4YxKsxbKBvMi2xNIbNjKYZOlJBeOrI0";

class Api{
  //String SEARCH_URL = "https://www.googleapis.com/youtube/v3/search?part=snippet&q=$search&type=video&key=$API_KEY&maxResults=10";

  //String SEARCH_TOKEN_URL = "https://www.googleapis.com/youtube/v3/search?part=snippet&q=$_search&type=video&key=$API_KEY&maxResults=10&pageToken=$_nextToken";

  //String SUGGESTED_URL = "http://suggestqueries.google.com/complete/search?hl=en&ds=yt&client=youtube&hjson=t&cp=1&q=$search&format=5&alt=json";


  search(String search) async {
    http.Response response = await http.get(
        "https://www.googleapis.com/youtube/v3/search?"
            "part=snippet&"
            "q=$search&"
            "type=video&"
            "key=$API_KEY&"
            "maxResults=10"
    );
    return decodeJson(response);
  }

  List<Video> decodeJson(http.Response response){
    if(response.statusCode == 200){
      var decoded = json.decode(response.body);

      List<Video> videos = decoded["items"].map<Video>((map){
        return Video.fromJson(map);
      }).toList();
      //print(videos);
      return videos;
    }else{
      throw Exception("Falha ao carregar videos");
    }
  }
}