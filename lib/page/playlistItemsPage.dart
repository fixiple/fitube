import 'package:fitube/style/text.dart';
import 'package:flutter/material.dart';


class PlaylistItemData {
  //class where we store the Data related to the playlists
  String? playlistItemName;
  //Url? image;
  int? totalItems;

  PlaylistItemData([this.playlistItemName]);

  static List setName(String s){
    List <String> playlistItemNameL = [];
    playlistItemNameL.add(s);
    
    return playlistItemNameL;
  }
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

  final List playlistItems = List.generate(
    50, (i) => 
    PlaylistItemData.setName("PlaylistItem $i")
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.playlistP),
      ),
      body:
        Column(
          children:[ 
            SizedBox(
              height: 700,
              child: ListView.builder(
                itemCount: playlistItems.length,
                itemBuilder: (BuildContext context, int index) {
                  return GestureDetector(
                    onTap: () { 
                    //Debug
                    //print(playlist[index]),
                    },
                    child: Container(
                      height: 50,
                      child: Center(
                        child: Text(
                          //TODO: REPLACE placeholder with real Items from API
                          '${playlistItems[index]}',
                          style: CustomTextStyle.playlistStyle
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