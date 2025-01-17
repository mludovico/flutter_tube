import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:flutter/material.dart';
import 'package:flutter_tube/blocs/favourite_bloc.dart';
import 'package:flutter_tube/models/video.dart';
import 'package:flutter_youtube/flutter_youtube.dart';

import '../api.dart';

class Favourites extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final bloc = BlocProvider.of<FavouriteBloc>(context);

    return Scaffold(
      appBar: AppBar(
        title: Text("Favoritos"),
        centerTitle: true,
        backgroundColor: Colors.black87,
      ),
      backgroundColor: Colors.black87,
      body: StreamBuilder<Map<String, Video>>(
        stream: bloc.outFav,
        builder: (context, snapshot){
          if(snapshot.hasData)
            return ListView(
              children: snapshot.data.values.map((v){
                return InkWell(
                  onTap: (){
                    FlutterYoutube.playYoutubeVideoById(
                      apiKey: API_KEY,
                      videoId: v.id
                    );
                  },
                  onLongPress: (){
                    bloc.toggleFavourite(v);
                  },
                  child: Row(
                    children: <Widget>[
                      Container(
                        width: 150,
                        height: 50,
                        child: Image.network(v.thumb),
                      ),
                      Expanded(
                        child: Text(
                          v.title,
                          style: TextStyle(
                            color: Colors.white70,
                          ),
                          maxLines: 2,
                        )
                      )
                    ],
                  ),
                );
              }).toList()
            );
          else
            return Container(
              height: 50,
              width: 50,
              alignment: Alignment.center,
              child: CircularProgressIndicator()
            );
        }
      ),
    );
  }
}
