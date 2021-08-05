import 'package:flutter/material.dart';

class Button{
  static ButtonStyle elevatedButtonStyle = ElevatedButton.styleFrom(
    primary: Colors.yellow[300],
    padding: EdgeInsets.symmetric(horizontal: 16),
    shape: 
      const RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(2)),
      )
  );

}