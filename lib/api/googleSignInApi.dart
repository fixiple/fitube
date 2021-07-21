import 'package:google_sign_in/google_sign_in.dart';
// to access youtube Data
import 'package:googleapis/youtube/v3.dart';

class GoogleSignInApi{
  static final _googleSignIn = GoogleSignIn();

  //login method
  static Future<GoogleSignInAccount?> login() => _googleSignIn.signIn();

  //logout method
  static Future<GoogleSignInAccount?> logout() => _googleSignIn.signOut();

}


class YoutubeData{
  //here we will be making the API calls

}