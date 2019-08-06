import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:flutter/material.dart';
import 'package:flutter_tube/blocs/videos_bloc.dart';
import 'package:flutter_tube/delegates/search_delegate.dart';
import 'package:flutter_tube/widgets/video_tile.dart';

class Home extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final bloc = BlocProvider.of<VideoBloc>(context);
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
            child: Text("0"),
          ),
          IconButton(
            icon: Icon(Icons.star),
            onPressed: (){}
          ),
          IconButton(
            icon: Icon(Icons.search),
            onPressed: () async {
              String result = await showSearch(
                context: context,
                delegate: DataSearch()
              );
              if(result != null)
                bloc.inSearch.add(result);
            }
          )
        ],
      ),
      body: StreamBuilder(
        stream: bloc.outVideos,
          builder: (context, snapshot){
          if(!snapshot.hasData){
            return Container();
          }else{
            return ListView.builder(
              itemBuilder: (context, index){
                if(index < snapshot.data.length){
                  return VideoTile(snapshot.data[index]);
                }else{
                  bloc.inSearch.add(null);
                  return Container(
                    height: 40,
                    width: 40,
                    alignment: Alignment.center,
                    child: CircularProgressIndicator(
                      valueColor: AlwaysStoppedAnimation<Color>(Colors.red)
                    )
                  );
                }
              },
              itemCount: snapshot.data.length,
            );
          }
        }
      ),
    );
  }
}
