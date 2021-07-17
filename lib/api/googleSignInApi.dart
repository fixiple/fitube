import 'package:google_sign_in/google_sign_in.dart';

class GoogleSignInApi{
  static final _googleSignIn = GoogleSignIn();

  //login method
  static Future<GoogleSignInAccount?> login() => _googleSignIn.signIn();

  //logout method
  static Future<GoogleSignInAccount?> logout() => _googleSignIn.signOut();

}