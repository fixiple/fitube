import 'package:google_sign_in/google_sign_in.dart';
import 'package:googleapis/youtube/v3.dart';



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

}

