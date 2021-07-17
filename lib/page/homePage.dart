import 'package:flutter/material.dart';
import '../api/googleSignInApi.dart';
import 'playlistPage.dart';

class Home extends StatefulWidget {
  //making key nullable
  Home({Key? key}) : super(key: key);

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<Home> {

  final playlistvar = Playlist();
  
  final ButtonStyle elevatedButtonStyle = ElevatedButton.styleFrom(
  primary: Colors.yellow[300],
  padding: EdgeInsets.symmetric(horizontal: 16),
  shape: 
    const RoundedRectangleBorder(
      borderRadius: BorderRadius.all(Radius.circular(2)),
    ),
  );



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
            style: elevatedButtonStyle,
            onPressed: () => signIn(),
            child: Text('Connexion a Google'),
          ),
        ],
      )
    ); 
  }

  //signIn method
  Future signIn() async{
    //final user = await GoogleSignInApi.login();

    Navigator.of(context).pushReplacement(MaterialPageRoute(
      builder: (context) => playlistvar));
  }


  
}