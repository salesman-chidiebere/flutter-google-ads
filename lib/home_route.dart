import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:flutter/material.dart';

class HomeRoute extends StatefulWidget {
  const HomeRoute({Key? key}) : super(key: key);

  @override
  _HomeRouteState createState() => _HomeRouteState();
}

class _HomeRouteState extends State<HomeRoute> {
  @override

  Future<InitializationStatus> _initGoogleMobileAds() {
    return MobileAds.instance.initialize();
  }

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
                Text("Awesome drawing quiz", style: TextStyle(fontSize: 32),
                textAlign: TextAlign.center,),
                SizedBox(height: 40,),
                if (snapshot.hasData)
                  ElevatedButton(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 42.0, vertical: 12),
                      child: Text("Let\'s get started"),
                    ),
                    onPressed: () => Navigator.of(context).pushNamed('/game'),
                  )
                else if (snapshot.hasError)
                  Icon(Icons.error_outline, color: Colors.red,size: 32,)
                else
                  CircularProgressIndicator(),
              ],
            ),
          );
        },
      )
    );
  }
}
