import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';

class HomeRoute extends StatefulWidget {
  const HomeRoute({Key? key}) : super(key: key);

  @override
  _HomeRouteState createState() => _HomeRouteState();
}

class _HomeRouteState extends State<HomeRoute> {

  Future<InitializationStatus> _initGoogleMobileAds(){
    return MobileAds.instance.initialize();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder<void>(
        future: _initGoogleMobileAds(),
        builder: (BuildContext context, AsyncSnapshot<void> snapshot){
          return Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text("Welcome to Admob"),
                SizedBox(height: 20,),
                if (snapshot.hasData)
                ElevatedButton(
                    onPressed: () => Navigator.of(context).pushNamed('/game'),
                    child: Text("Let\'s get Started"))
                else if (snapshot.hasError)
                  Icon(Icons.error_outline, color: Colors.red, size: 30,)
                else
                  CircularProgressIndicator()
              ],
            ),
          );
        },
      ),
    );
  }
}
