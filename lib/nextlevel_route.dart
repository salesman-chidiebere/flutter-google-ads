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
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text("Welcome to the Next Level"),
            TextButton(
                onPressed: () => Navigator.of(context).pushNamed('/home'),
                child: Text("Restart"))

          ],
        ),
      ),
    );
  }
}
