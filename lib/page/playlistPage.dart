import 'package:flutter/material.dart';
import 'package:fitube/api/apiCalls.dart';
import 'package:fitube/page/playlistItemsPage.dart';
import 'package:fitube/style/button.dart';
import 'package:fitube/style/text.dart';
import 'package:fitube/page/homePage.dart';
import 'package:google_sign_in/google_sign_in.dart';

class PlaylistData {
  //class where we store the Data related to the playlists
  static String? playlistName;
  //Url? image;
  int? totalItems;


  PlaylistData([playlistName]);

  static List setName(String s){
    List <String> playlistNameL = [];
    playlistNameL.add(s);
    
    return playlistNameL;
  }

  static String? getName(){
    
    return playlistName;
  }
}


class Playlist extends StatefulWidget {

  final GoogleSignInAccount userPP;
  
  //making key nullable
  Playlist({Key? key, required this.userPP}) : super(key: key);

  @override
  _PlaylistState createState() => _PlaylistState();
}


class _PlaylistState extends State<Playlist>{

  List generatedPlaylist = List.generate(
    50, (int i) => 
    PlaylistData.setName("Playlist $i")
  );

  //logout method/function
  Future<void>? logOut() { 
    GoogleApi.logout();
    
    //shows a little bar with "Disconnected" for 2 seconds
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Disconnected'),
        duration: Duration(seconds: 2)
      )
    );

    Navigator.of(context).pushReplacement(MaterialPageRoute(
      builder: (context) => Home()
    ));
  }

  @override
  Widget build(BuildContext context) {
    //we assign a variable to the passed userPP from the other screen
    final user = widget.userPP;
    
    return Scaffold(
      appBar: AppBar(
        title: Text('Playlists'),
      ),
      body:
        Column(
          children:[ 
            SizedBox(
              height: 50,
              child: 
                Text('Welcome ' + user.displayName! + ' !'),
            ),
            Text("Playlists Crées",
              style: CustomTextStyle.titleStyle,
            ),
            SizedBox(
              //some space
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
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children:[ 
                          Expanded(
                            child: Text(
                            //resolved the "type 'List<String>' is not a subtype of type 'String' " error (aka: do a .toString() cast)
                              generatedPlaylist[index].toString(),
                              style: CustomTextStyle.playlistStyle
                            )
                          ),
                        ],
                      )
                    )
                  );
                }
              ),
            ),
            ElevatedButton(
            style: Button.elevatedButtonStyle,
            onPressed: () => logOut(),
            child: Text('Disconnect'),
          )
        ]
      )
    );
  }  

}