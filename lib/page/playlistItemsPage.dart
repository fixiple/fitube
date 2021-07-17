import 'package:flutter/material.dart';
import 'PlaylistPage.dart';


class PlaylistItemData {
  //class where we store the Data related to the playlists
  String? playlistItemName;
  //Url? image;
  int? totalItems;

  PlaylistItemData([this.playlistItemName]);
}

class PlaylistItems extends StatefulWidget {
  
  final playlistP;
  
  //making key nullable
  PlaylistItems({Key? key, this.playlistP}) : super(key: key);

  @override
  _PlaylistItemsState createState() => _PlaylistItemsState();
}



class _PlaylistItemsState extends State<PlaylistItems>{
  
  
  final TextStyle playlistItemStyle = TextStyle(
    color: Colors.black,
    fontSize: 25,
    fontFamily: "Arial",
  );



  final playlistItems = List<PlaylistItemData>.generate(
    50,
    (i) => PlaylistItemData("PlaylistItem $i")
  );

  Playlist playlist = Playlist();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: widget.playlistP.Playlistname,
      ),
      body:
        Column(
          children:[ 
            SizedBox(
              height: 500,
              child: ListView.builder(
                itemCount: playlistItems.length,
                itemBuilder: (BuildContext context, int index) {
                  return GestureDetector(
                    onTap: () { 
                    //Debug
                    //print(playlist[index]),
                  
                    },
                    child: Container( //TO DO: change to Listview
                      height: 50,
                      child: Center(
                        child: Text(
                          '${playlistItems[index]}',
                          style: playlistItemStyle
                        )
                      ),
                    )
                  );
                }
              ),
            ),
          ]
        )
    );
  }  

}