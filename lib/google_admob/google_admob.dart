import 'dart:io';

import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:flutter/material.dart';

class AdMob {
  // test bannerAdUnitId
  static final bannerAdUnitId = Platform.isAndroid
      ? 'ca-app-pub-3940256099942544/6300978111'
      : 'ca-app-pub-3940256099942544/2934735716';

  // test rewardAdUnitId
  static final rewardAdUnitId = Platform.isAndroid
      ? 'ca-app-pub-3940256099942544/5224354917'
      : 'ca-app-pub-3940256099942544/1712485313';


  static BannerAd? anchoredAdaptiveAd;

  static RewardedAd? rewardedAd;

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
}
