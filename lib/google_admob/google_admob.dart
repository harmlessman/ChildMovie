import 'dart:convert';

import 'package:flutter/services.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:flutter/material.dart';

class AdMob {
  // test bannerAdUnitId
  static String bannerAdUnitId='';

  // test rewardAdUnitId
  static String rewardAdUnitId='';

  // test exitAdUnitId
  static String exitAdUnitId='';

  static BannerAd? anchoredAdaptiveAd;

  static RewardedAd? rewardedAd;

  static BannerAd? exitAd;

  static Future<void> setAdUnitId() async {

    // app_config 에서 admob id 가져옴
    String jsonString = await rootBundle.loadString('assets/app_config.json');

    Map<String, dynamic> jsonData = json.decode(jsonString);

    bannerAdUnitId = jsonData["bannerAdUnitId"];
    rewardAdUnitId = jsonData["rewardAdUnitId"];
    exitAdUnitId = jsonData["exitAdUnitId"];

  }

  static Future<BannerAd?> loadBannerAd(BuildContext context) async {
    //Get an AnchoredAdaptiveBannerAdSize before loading the ad.
    AnchoredAdaptiveBannerAdSize? size =
        await AdSize.getCurrentOrientationAnchoredAdaptiveBannerAdSize(
            MediaQuery.of(context).size.width.truncate());

    anchoredAdaptiveAd = BannerAd(
      adUnitId: bannerAdUnitId,
      request: const AdRequest(),
      size: size ?? AdSize.banner,
      listener: BannerAdListener(
        onAdLoaded: (Ad ad) {
          print('$ad loaded: ${ad.responseInfo}');
        },
        onAdFailedToLoad: (Ad ad, LoadAdError error) {
          print('Anchored adaptive banner failedToLoad: $error');
          ad.dispose();
        },
      ),
    )..load();
    return anchoredAdaptiveAd;
  }

  static Container showBannerAd() {
    Container ad = Container(
      decoration: const BoxDecoration(
        color: Colors.white,
      ),
      child: Align(
        alignment: Alignment.bottomCenter,
        child: SafeArea(
          child: SizedBox(
            width: anchoredAdaptiveAd!.size.width.toDouble(),
            height: anchoredAdaptiveAd!.size.height.toDouble(),
            child: AdWidget(ad: anchoredAdaptiveAd!),
          ),
        ),
      ),
    );

    return ad;
  }

  static void loadRewardAd() {
    RewardedAd.load(
        adUnitId: rewardAdUnitId,
        request: const AdRequest(),
        rewardedAdLoadCallback: RewardedAdLoadCallback(
          // Called when an ad is successfully received.
          onAdLoaded: (ad) {
            debugPrint('$ad loaded.');
            // Keep a reference to the ad so you can show it later.
            rewardedAd = ad;
            //ad.show(onUserEarnedReward: (AdWithoutView ad, RewardItem reward) {  });
          },

          // Called when an ad request failed.
          onAdFailedToLoad: (LoadAdError error) {
            debugPrint('RewardedAd failed to load: $error');
          },
        ));

  }

  static void loadExitAd(int width, int height){
    exitAd = BannerAd(
      adUnitId: exitAdUnitId,
      request: const AdRequest(),
      size:  AdSize(width: width, height: height),
      listener: BannerAdListener(
        onAdLoaded: (Ad ad) {
          print('$ad loaded: ${ad.responseInfo}');
        },
        onAdFailedToLoad: (Ad ad, LoadAdError error) {
          print('Anchored adaptive banner failedToLoad: $error');
          ad.dispose();
        },
      ),
    )..load();
  }

  static Widget showExitAd(){
    print('############################');
    print(exitAd!.size.width.toDouble());
    print(exitAd!.size.height.toDouble());
    Widget ad = SizedBox(
      width: exitAd!.size.width.toDouble(),
      height: exitAd!.size.height.toDouble(),
      child: AdWidget(ad: exitAd!),
    );
    return ad;
  }
}
