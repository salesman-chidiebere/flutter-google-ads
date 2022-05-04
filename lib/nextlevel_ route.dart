import 'package:flutter/material.dart';

class NextLevel extends StatefulWidget {
  const NextLevel({Key? key}) : super(key: key);

  @override
  _NextLevelState createState() => _NextLevelState();
}

class _NextLevelState extends State<NextLevel> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
     body: Center(
       child: TextButton(
         onPressed: () => Navigator.of(context).pushNamed('/home'),
         child: Text("Restart"),
       ),
     ),
    );
  }
}
