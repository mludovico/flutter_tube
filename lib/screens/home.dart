import 'package:flutter/material.dart';
import 'package:flutter_tube/delegates/search_delegate.dart';

class Home extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
              print(result);
            }
          )
        ],
      ),
    );
  }
}
