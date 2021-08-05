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
    final user;
  
    user = await GoogleApi.login();
    
    Navigator.of(context).pushReplacement(MaterialPageRoute(
      builder: (context) => Playlist(
        // we pass the user data in the next page
        userPP : user
      )));
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