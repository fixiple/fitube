import 'package:flutter/material.dart';
import 'package:fitube/api/apiCalls.dart';
import 'package:fitube/page/playlistItemsPage.dart';
import 'package:fitube/style/button.dart';
import 'package:fitube/style/text.dart';
import 'package:fitube/page/homePage.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:googleapis/youtube/v3.dart';


class PlaylistPage extends StatefulWidget {

  final GoogleSignInAccount userPP;
  
  //making key nullable
  PlaylistPage({Key? key, required this.userPP}) : super(key: key);

  @override
  _PlaylistState createState() => _PlaylistState();
}


class _PlaylistState extends State<PlaylistPage>{
  String pageToken = "";

  //getting the playlist Information 
  Future<PlaylistListResponse> getPlaylistData() async {

    var data = await YoutubeData().getplaylistsfromApi(pageToken: pageToken);

    return data;
  }

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
              height: 30
            ),
            SizedBox(
              height: 500,
              child: FutureBuilder(
                future: getPlaylistData(),
                builder: (BuildContext context, AsyncSnapshot snapshot){
                //VARIABLES
                final PlaylistListResponse playlist = snapshot.data;
                final List playlistName = playlist.items!.map((e) => e.snippet!.title).toList();
                final List playlistId = playlist.items!.map((e) => e.id).toList();
                pageToken = playlist.nextPageToken.toString();
                //--------------------------------------------------------------------------------
                switch (snapshot.connectionState) {
                  case ConnectionState.none:
                    return Text('State has no data...');
                  case ConnectionState.waiting:
                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Center(
                          child: CircularProgressIndicator()
                        ),
                        Center(
                          child: Text('Please have patience...')
                        ),
                      ]
                    );
                  case ConnectionState.active:
                    if (snapshot.hasData){
                    return ListView.builder(
                      itemCount: playlist.items!.length,
                      itemBuilder: (BuildContext context, int index) {
                        return GestureDetector(
                          onTap: () { 
                            //Debug
                            //print(playlist[index]),
                            Navigator.of(context).push(MaterialPageRoute(
                              builder: (context) => PlaylistItems(
                                playlistName : playlistName[index],
                                playlistId : playlistId[index],
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
                                    playlistName[index],
                                    style: CustomTextStyle.playlistStyle
                                  )
                                ),
                              ],
                            )
                          )
                        );
                      });
                    } else {
                      return Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Center(
                          child: CircularProgressIndicator()
                        ),
                        Center(
                          child: Text('No Data! Try creating a youtube playlist')
                        ),
                      ]
                    );
                    }
                  case ConnectionState.done:
                    return ListView.builder(
                      itemCount: playlist.items!.length,
                      itemBuilder: (BuildContext context, int index) {
                        return GestureDetector(
                          onTap: () { 
                            //Debug
                            //print(playlist[index]),
                            Navigator.of(context).push(MaterialPageRoute(
                              builder: (context) => PlaylistItems(
                                playlistName : playlistName[index],
                                playlistId : playlistId[index],
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
                                    playlistName[index],
                                    style: CustomTextStyle.playlistStyle
                                  )
                                ),
                              ],
                            )
                          )
                        );
                      });   
                }
              })
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