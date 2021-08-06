import 'package:flutter/material.dart';
import 'package:fitube/api/apiCalls.dart';
import 'playlistPage.dart';
//strange, why import it like this?
// ref: https://stackoverflow.com/a/56101133
import 'package:fitube/style/button.dart';

class Home extends StatefulWidget {
  //making key nullable
  Home({Key? key}) : super(key: key);

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<Home> {
  
  //signIn method
  Future signIn() async{
    var user;
    //app not responding after user quits the http popup by pressing around it, or using the return button  
    //while the popup is open (only in DEBUG MODE)
    user = await GoogleApi.login();

    if (user!=null) {
      //the user will not be able to return back to this screen
       Navigator.of(context).pushReplacement(
        MaterialPageRoute(
          builder: (context) => Playlist(
          // we pass the user data in the next page
          userPP : user
          )
        )
      );
    } else {
      //without debug([Run -> Run without Debugging] OR ["CTRL+F5"] ), the Snackbar message shows up and the app flow is not suddently unresponsive
      //shows a little bar with [Text] 2 seconds
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Sign In failed, please try again'),
          duration: Duration(seconds: 2)
        )
      );
    }
  }
 
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Bienvenue'),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Text("Veuillez vous connecter"),
          ElevatedButton(
            style: Button.elevatedButtonStyle,
            onPressed: () => signIn(),
            child: Text('Connexion a Google'),
          ),
        ],
      )
    ); 
  }




  
}