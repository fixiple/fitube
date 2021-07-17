import 'package:flutter/material.dart';
import 'playlistItemsPage.dart';

class PlaylistData {
  //class where we store the Data related to the playlists
  static String? playlistName;
  //Url? image;
  int? totalItems;


  PlaylistData([playlistName]);

  static void setName(String s){
    playlistName = s;
  }
}



class Playlist extends StatefulWidget {
  
  final user;
  
  //making key nullable
  Playlist({Key? key, this.user}) : super(key: key);

  @override
  _PlaylistState createState() => _PlaylistState();
}


class _PlaylistState extends State<Playlist>{
  
  final TextStyle titleStyle = TextStyle(
    color: Colors.black,
    fontSize: 30,
    fontFamily: "Arial",
  );

  final TextStyle playlistStyle = TextStyle(
    color: Colors.black54,
    fontSize: 20,
    fontFamily: "Arial",
  );
  

  List generatedPlaylist = List.generate(
    50, (int i) => 
    PlaylistData.setName("Playlist $i")
  );


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Playlists'),
      ),
      body:
        Column(
          children:[ 
            SizedBox(
              height: 50
           ),
            Text("Playlists Crées",
              style: titleStyle,
            ),
            SizedBox(
              height: 50
            ),
            SizedBox(
              height: 500,
              child: ListView.builder(
                itemCount: generatedPlaylist.length,
                itemBuilder: (BuildContext context, int index) {
                  return GestureDetector(
                    onTap: () { 
                      //Debug
                      //print(playlist[index]),
                      Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) => PlaylistItems(
                          playlistP : generatedPlaylist[index]
                        )
                      ));
                    },
                    child: Container(
                      height: 50,
                      child: Center(child: Text(
                        '${generatedPlaylist[index]}',
                        style: playlistStyle)
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