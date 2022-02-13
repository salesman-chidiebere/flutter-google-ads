import 'package:adsense/adhelper.dart';
import 'package:flutter/material.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';

class GameRoute extends StatefulWidget {
  const GameRoute({Key? key}) : super(key: key);

  @override
  _GameRouteState createState() => _GameRouteState();
}

class _GameRouteState extends State<GameRoute> {

  late BannerAd _bannerAd;
  bool _isBannerAdReady = false;

  RewardedAd? _rewardedAd;
  bool _isRewardedAdReady = false;

  InterstitialAd? _interstitialAd;
  bool _isInterstitialAdReady = false;

  double rewardpoint = 0;

  void initState() {
    _bannerAd = BannerAd(
      adUnitId: AdHelper.bannerAdUnitId,
      request: AdRequest(),
      size: AdSize.banner,
      listener: BannerAdListener(
        onAdLoaded: (_) {
          setState(() {
            _isBannerAdReady = true;
          });
        },
        onAdFailedToLoad: (ad, err) {
          print('Failed to load a banner ad: ${err.message}');
          _isBannerAdReady = false;
          ad.dispose();
        }
      )
    );

    _bannerAd.load();

    _loadRewardedAd();

    _loadInterstitialAd();
  }

  @override
  void dispose() {
    _bannerAd.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Stack(
          children: [
            Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text("Ad banner will be displayed here"),

                  if (_isRewardedAdReady)
                    ElevatedButton(
                        onPressed: (){
                          _rewardedAd?.show(
                              onUserEarnedReward: (_, reward){
                                setState(() {
                                  rewardpoint = reward.amount.toDouble();
                                });
                                print("This is my reward $reward");
                              });
                        },
                        child: Text("Get Reward"),
                    ),

                  SizedBox(height: 40,),

                  if (_isInterstitialAdReady)
                    TextButton(
                      onPressed: () => _interstitialAd?.show(),
                      child: Text("Complete this level"))
                ],
              ),
            ),
            if (_isBannerAdReady)
              Align(
                alignment: Alignment.topCenter,
                child: Container(
                  width: _bannerAd.size.width.toDouble(),
                  height: _bannerAd.size.height.toDouble(),
                  child: AdWidget(ad: _bannerAd,),
                ),
              ),

          ],
        ),
      ),
    );
  }

  void _loadRewardedAd() {
    RewardedAd.load(
        adUnitId: AdHelper.rewardedAdUnitId,
        request: AdRequest(),
        rewardedAdLoadCallback: RewardedAdLoadCallback(
          onAdLoaded: (ad) {
            this._rewardedAd = ad;

            ad.fullScreenContentCallback = FullScreenContentCallback(
              onAdDismissedFullScreenContent: (ad) {
                setState(() {
                  _isRewardedAdReady = false;
                });
                _loadRewardedAd();
              },
              onAdShowedFullScreenContent: (reward){
                showDialog(
                    context: context,
                    builder: (context){
                      return AlertDialog(
                        title: Text("Reward"),
                        content: Text("You got $rewardpoint reward"),
                        actions: [
                          TextButton(
                              onPressed: () => Navigator.of(context).pop(),
                              child: Text("Close"))
                        ],
                      );
                    });
              }
            );
            setState(() {
              _isRewardedAdReady = true;
            });
          },
          onAdFailedToLoad: (err) {
            print('Failed to load a rewarded ad: ${err.message}');
            setState(() {
              _isRewardedAdReady = false;
            });
          },

        ),
    );
  }

  void _loadInterstitialAd() {
    InterstitialAd.load(
        adUnitId: AdHelper.interstitialAdUnitId,
        request: AdRequest(),
        adLoadCallback: InterstitialAdLoadCallback(
            onAdLoaded: (ad) {
              this._interstitialAd = ad;

              ad.fullScreenContentCallback = FullScreenContentCallback(
                onAdDismissedFullScreenContent: (ad) {
                  Navigator.of(context).pushNamed('/nextlevel');
                }
              );

              _isInterstitialAdReady = true;
            },
            onAdFailedToLoad: (err){
              print('Failed to load an interstitial ad: ${err.message}');
              _isInterstitialAdReady = false;
            },
        ),
    );
  }

}
