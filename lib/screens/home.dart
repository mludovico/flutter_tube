import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:flutter/material.dart';
import 'package:flutter_tube/blocs/favourite_bloc.dart';
import 'package:flutter_tube/blocs/videos_bloc.dart';
import 'package:flutter_tube/delegates/search_delegate.dart';
import 'package:flutter_tube/widgets/video_tile.dart';

import 'favourites.dart';

class Home extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final videoBloc = BlocProvider.of<VideoBloc>(context);
    final favouriteBloc = BlocProvider.of<FavouriteBloc>(context);
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        title: Container(
          height: 25,
          child: Image.asset("images/youtube.png"),
        ),
        centerTitle: false,
        elevation: 0,
        backgroundColor: Colors.black87,
        actions: <Widget>[
          Align(
            alignment: Alignment.center,
            child: StreamBuilder(
              stream: favouriteBloc.outFav,
              initialData: {},
              builder: (context, snapshot){
                if(snapshot.hasData)
                  return Text("${snapshot.data.length}");
                else
                  return Text("0");
              }
            ),
          ),
          IconButton(
            icon: Icon(Icons.star),
            onPressed: (){
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context)=>Favourites()
                )
              );
            }
          ),
          IconButton(
            icon: Icon(Icons.search),
            onPressed: () async {
              String result = await showSearch(
                context: context,
                delegate: DataSearch()
              );
              if(result != null)
                videoBloc.inSearch.add(result);
            }
          )
        ],
      ),
      body: StreamBuilder(
        stream: videoBloc.outVideos,
          builder: (context, snapshot){
          if(!snapshot.hasData){
            return Container();
          }else {
            return ListView.builder(
              itemBuilder: (context, index){
                if(index < snapshot.data.length){
                  return VideoTile(snapshot.data[index]);
                }else if(index > 1){
                  videoBloc.inSearch.add(null);
                  return Container(
                    height: 40,
                    width: 40,
                    alignment: Alignment.center,
                    child: CircularProgressIndicator(
                      valueColor: AlwaysStoppedAnimation<Color>(Colors.red)
                    )
                  );
                }
                else{
                  return Container();
                }
              },
              itemCount: snapshot.data.length + 1,
            );
          }
        }
      ),
    );
  }
}
