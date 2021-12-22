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
  
  
  late PlaylistItemListResponse playlistItem;

  late String pToken = "";
  
  late ScrollController _scrollController;
  
  @override
  void initState() {
    getItemsData();
    _scrollController = ScrollController();
    _scrollController.addListener(_scrollListener);
    super.initState();
  }

  //getting the playlist Information 
  Future<PlaylistItemListResponse> getItemsData([String? pageToken]) async {
    //we pass the playlistId in the API call to get only the items from the current playlist
    var data = await YoutubeData().getPlaylistItemsFromApi(widget.playlistId, pageToken);

    return data;
  }

  String getNextPageToken() {
    String pToken = playlistItem.nextPageToken.toString();
    
    return pToken;
  }

  
  _scrollListener() async {
    if ( _scrollController.offset >=  _scrollController.position.maxScrollExtent) { 
      setState(()  {  
        pToken = getNextPageToken();
      });
      print(pToken);
      playlistItem = await getItemsData(pToken);
      print(playlistItem);
    }
  }
  // TODO: Find a way to not show the playlistItemsResponse is Null error after getting at the end of the PlaylistItemsList
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
                future: getItemsData(pToken),
                builder: (BuildContext context, AsyncSnapshot snapshot) {
                  playlistItem = snapshot.data;
                  final List playlistItemName = playlistItem.items!.map((e) => e.snippet!.title).toList();
                  if (snapshot.hasData){
                      switch (snapshot.connectionState){ 
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
                          controller: _scrollController, 
                          itemCount: playlistItem.items!.length,
                          itemBuilder: (context, int index){
                            return GestureDetector(
                              onTap: () { 
                              },
                              child: Container(
                                height: 50,
                                child: Center(
                                  child: Text(
                                    index.toString() + " - " + playlistItemName[index],
                                    style: CustomTextStyle.playlistItemStyle
                                  )
                                ),
                              )
                            );
                          });
                        } 
                        //if no data is left to show, shows the following text in the screen
                        return Text ("No data left");
                        case ConnectionState.done:
                          return ListView.builder(
                            controller: _scrollController, 
                            itemCount: playlistItem.items!.length,
                            itemBuilder: (context, int index){
                              return GestureDetector(
                                onTap: () { 
                              },
                              child: Container(
                                height: 50,
                                child: Center(
                                  child: Text(
                                    index.toString() + " - " + playlistItemName[index],
                                    style: CustomTextStyle.playlistItemStyle
                                  )
                                ),
                              )
                            );
                          });
                        
                      }
                  }else {
                    return Text("No data left!");
                  } 
                })
          )  
          ])
    );
  }
}