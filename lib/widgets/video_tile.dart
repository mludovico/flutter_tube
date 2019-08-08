import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:flutter/material.dart';
import 'package:flutter_tube/blocs/favourite_bloc.dart';
import 'package:flutter_tube/models/video.dart';
import 'package:flutter_youtube/flutter_youtube.dart';

import '../api.dart';

class VideoTile extends StatelessWidget {
  final Video video;
  VideoTile(this.video);

  @override
  Widget build(BuildContext context) {
    final bloc = BlocProvider.of<FavouriteBloc>(context);
    return GestureDetector(
      onTap: (){
        FlutterYoutube.playYoutubeVideoById(
          apiKey: API_KEY,
          videoId: video.id
        );
      },
      child: Container(
        margin: EdgeInsets.symmetric(vertical: 4.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            AspectRatio(
              aspectRatio: 16.0/9.0,
              child: Image.network(
                video.thumb,
                fit: BoxFit.cover,
              ),
            ),
            Row(
              children: <Widget>[
                Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Padding(
                          padding: EdgeInsets.all(8.0),
                          child: Text(
                            video.title,
                            style: TextStyle(
                                fontSize: 16,
                                color: Colors.white
                            ),
                            maxLines: 2,
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.all(8.0),
                          child: Text(
                            video.channel,
                            style: TextStyle(
                                fontSize: 14,
                                color: Colors.white
                            ),
                          ),
                        ),
                      ],
                    )
                ),
                StreamBuilder<Map<String, Video>>(
                  stream: bloc.outFav,
                  builder: (context, snapshot){
                    if(snapshot.hasData)
                      return IconButton(
                          icon: Icon(snapshot.data.containsKey(video.id)?
                          Icons.star:
                          Icons.star_border),
                          color: Colors.white,
                          iconSize: 30,
                          onPressed: (){
                            bloc.toggleFavourite(video);
                          }
                      );
                    else{
                      return CircularProgressIndicator();
                    }
                  },
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
