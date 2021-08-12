import 'package:fitube/api/apiCalls.dart';
import 'package:fitube/style/text.dart';
import 'package:flutter/material.dart';
import 'package:googleapis/youtube/v3.dart';


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
  
  final playlistName;
  final playlistId;
  
  //making key nullable
  PlaylistItems({Key? key, this.playlistName, this.playlistId}) : super(key: key);

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

    //getting the playlist Information 
  Future<PlaylistItemListResponse> getItemsData() async {

    //we pass the playlistId in the API call to get only the items from the current playlist
    var data = await YoutubeData().getPlaylistItemsFromApi(widget.playlistId);

    return data;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.playlistName),
      ),
      body:
        Column(
          children:[ 
            SizedBox(
              height: 700,
              child: FutureBuilder(
                future: getItemsData(),
                builder: (BuildContext context, AsyncSnapshot snapshot){
                  //VARIABLES
                  final PlaylistItemListResponse playlistItem = snapshot.data;
                  final List playlistItemName = playlistItem.items!.map((e) => e.snippet!.title).toList();
                  //--------------------------------
                return ListView.builder(
                  itemCount: playlistItem.items!.length,
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
                            playlistItemName[index],
                            style: CustomTextStyle.playlistStyle
                          )
                        ),
                      )
                    );
                  });
              }),
            ),
          ]
        )
    );
  }  

}