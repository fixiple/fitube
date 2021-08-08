import 'package:google_sign_in/google_sign_in.dart';
import 'package:extension_google_sign_in_as_googleapis_auth/extension_google_sign_in_as_googleapis_auth.dart';
import 'package:googleapis/youtube/v3.dart';

//refs : https://flutter.dev/docs/development/data-and-backend/google-apis#overview

class GoogleApi{
  static final _googleSignIn = GoogleSignIn(
    scopes : [YouTubeApi.youtubeReadonlyScope]
  );

  //login method
  static Future<GoogleSignInAccount?> login() => _googleSignIn.signIn();

  //logout method
  //static Future<GoogleSignInAccount?> logout() => _googleSignIn.signOut();

  //disconnects totally from account
  //see : https://pub.dev/documentation/google_sign_in/latest/google_sign_in/GoogleSignIn/disconnect.html
  static Future<GoogleSignInAccount?> logout() => _googleSignIn.disconnect();
}


class YoutubeData{
  //here we will be making the API calls


  Future<List> getplaylists() async{
    
    //refs: https://youtu.be/z4MsuZiEezY?t=248
    //and https://pub.dev/packages/extension_google_sign_in_as_googleapis_auth
    final _authClient = await GoogleApi._googleSignIn.authenticatedClient();
    final _youtubeApi = YouTubeApi(_authClient!);// why '!' at the end as a solution of error below
                                               //"The argument type 'AuthClient?' can't be assigned to the parameter type 'Client' " ??
    
    // we retrieve the snippets of our account only
    final playlists = await _youtubeApi.playlists.list(['snippet'], mine: true);

    //will store a list of titles retrieved from Api connection inside a variable
    final _playlistsToList = playlists.items!.map((e) => 
    e).toList(); 
    return _playlistsToList;
  }



}

