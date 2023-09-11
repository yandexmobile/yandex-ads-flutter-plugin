import 'package:flutter/foundation.dart';
import 'package:yandex_mobileads/mobile_ads.dart';

import 'network.dart';

abstract class NetworkProvider {
  static final NetworkProvider instance = _createInstance();

  abstract final List<Network> bannerNetworks;
  abstract final List<Network> interstitialNetworks;
  abstract final List<Network> rewardedNetworks;

  static NetworkProvider _createInstance() {
    switch (defaultTargetPlatform) {
      case TargetPlatform.android:
        return _AndroidNetworkProvider();
      case TargetPlatform.iOS:
        return _IosNetworkProvider();
      default:
        throw UnsupportedError('The Yandex Mobile Ads SDK is only supported'
            ' on Android and iOS.');
    }
  }
}

class _AndroidNetworkProvider extends NetworkProvider {
  @override
  final List<Network> bannerNetworks = const [
    Network(title: 'Yandex', adUnitId: 'demo-banner-yandex'),
    Network(title: 'AdColony', adUnitId: 'demo-banner-adcolony'),
    Network(title: 'AdMob', adUnitId: 'demo-banner-admob'),
    Network(title: 'AppLovin', adUnitId: 'demo-banner-applovin'),
    Network(title: 'Chartboost', adUnitId: 'demo-banner-chartboost'),
    Network(title: 'Mintegral', adUnitId: 'demo-banner-mintegral'),
    Network(title: 'MyTarget', adUnitId: 'demo-banner-mytarget'),
    Network(title: 'StartApp', adUnitId: 'demo-banner-startapp'),
    Network(title: 'Vungle', adUnitId: 'demo-banner-vungle'),
    Network(title: 'InMobi', adUnitId: 'demo-banner-inmobi'),
    Network(
      title: 'AdFox',
      adUnitId: 'R-M-243655-8',
      adRequest: AdRequest(
        parameters: {
          'adf_ownerid': '270901',
          'adf_p1': 'cqtgh',
          'adf_p2': 'fkbd',
        },
      ),
    ),
  ];

  @override
  final List<Network> interstitialNetworks = const [
    Network(title: 'Yandex', adUnitId: 'demo-interstitial-yandex'),
    Network(title: 'AdColony', adUnitId: 'demo-interstitial-adcolony'),
    Network(title: 'AdMob', adUnitId: 'demo-interstitial-admob'),
    Network(title: 'AppLovin', adUnitId: 'demo-interstitial-applovin'),
    Network(title: 'Chartboost', adUnitId: 'demo-interstitial-chartboost'),
    Network(title: 'Mintegral', adUnitId: 'demo-interstitial-mintegral'),
    Network(title: 'MyTarget', adUnitId: 'demo-interstitial-mytarget'),
    Network(title: 'IronSource', adUnitId: 'demo-interstitial-ironsource'),
    Network(title: 'Pangle', adUnitId: 'demo-interstitial-pangle'),
    Network(title: 'StartApp', adUnitId: 'demo-interstitial-startapp'),
    Network(title: 'Tapjoy', adUnitId: 'demo-interstitial-tapjoy'),
    Network(title: 'Unity Ads', adUnitId: 'demo-interstitial-unityads'),
    Network(title: 'Vungle', adUnitId: 'demo-interstitial-vungle'),
    Network(title: 'InMobi', adUnitId: 'demo-interstitial-inmobi'),
    Network(
      title: 'AdFox',
      adUnitId: 'R-M-243655-9',
      adRequest: AdRequest(
        parameters: {
          'adf_ownerid': '270901',
          'adf_p1': 'cqtgg',
          'adf_p2': 'fhlx',
        },
      ),
    ),
  ];

  @override
  final List<Network> rewardedNetworks = const [
    Network(title: 'Yandex', adUnitId: 'demo-rewarded-yandex'),
    Network(title: 'AdColony', adUnitId: 'demo-rewarded-adcolony'),
    Network(title: 'AdMob', adUnitId: 'demo-rewarded-admob'),
    Network(title: 'AppLovin', adUnitId: 'demo-rewarded-applovin'),
    Network(title: 'Chartboost', adUnitId: 'demo-rewarded-chartboost'),
    Network(title: 'Mintegral', adUnitId: 'demo-rewarded-mintegral'),
    Network(title: 'MyTarget', adUnitId: 'demo-rewarded-mytarget'),
    Network(title: 'IronSource', adUnitId: 'demo-rewarded-ironsource'),
    Network(title: 'Pangle', adUnitId: 'demo-rewarded-pangle'),
    Network(title: 'StartApp', adUnitId: 'demo-rewarded-startapp'),
    Network(title: 'Tapjoy', adUnitId: 'demo-rewarded-tapjoy'),
    Network(title: 'Unity Ads', adUnitId: 'demo-rewarded-unityads'),
    Network(title: 'Vungle', adUnitId: 'demo-rewarded-vungle'),
    Network(title: 'InMobi', adUnitId: 'demo-rewarded-inmobi'),
  ];
}

class _IosNetworkProvider extends NetworkProvider {
  @override
  final List<Network> bannerNetworks = const [
    Network(title: 'Yandex', adUnitId: 'demo-banner-yandex'),
    Network(title: 'AdMob', adUnitId: 'demo-banner-admob'),
    Network(title: 'Mintegral', adUnitId: 'demo-banner-mintegral'),
    Network(title: 'MyTarget', adUnitId: 'demo-banner-mytarget'),
    Network(title: 'InMobi', adUnitId: 'demo-banner-inmobi'),
    Network(
      title: 'AdFox',
      adUnitId: 'R-M-243655-8',
      adRequest: AdRequest(
        parameters: {
          'adf_ownerid': '270901',
          'adf_p1': 'cqtgh',
          'adf_p2': 'fkbd',
        },
      ),
    ),
  ];

  @override
  final List<Network> interstitialNetworks = const [
    Network(title: 'Yandex', adUnitId: 'demo-interstitial-yandex'),
    Network(title: 'AdMob', adUnitId: 'demo-interstitial-admob'),
    Network(title: 'AppLovin', adUnitId: 'demo-interstitial-applovin'),
    Network(title: 'Mintegral', adUnitId: 'demo-interstitial-mintegral'),
    Network(title: 'MyTarget', adUnitId: 'demo-interstitial-mytarget'),
    Network(title: 'InMobi', adUnitId: 'demo-interstitial-inmobi'),
    Network(title: 'IronSource', adUnitId: 'demo-interstitial-ironsource'),
    Network(title: 'Unity Ads', adUnitId: 'demo-interstitial-unityads'),
    Network(
      title: 'AdFox',
      adUnitId: 'R-M-243655-9',
      adRequest: AdRequest(
        parameters: {
          'adf_ownerid': '270901',
          'adf_p1': 'cqtgg',
          'adf_p2': 'fhlx',
        },
      ),
    ),
  ];

  @override
  final List<Network> rewardedNetworks = const [
    Network(title: 'Yandex', adUnitId: 'demo-rewarded-yandex'),
    Network(title: 'AdMob', adUnitId: 'demo-rewarded-admob'),
    Network(title: 'AppLovin', adUnitId: 'demo-rewarded-applovin'),
    Network(title: 'Mintegral', adUnitId: 'demo-rewarded-mintegral'),
    Network(title: 'MyTarget', adUnitId: 'demo-rewarded-mytarget'),
    Network(title: 'InMobi', adUnitId: 'demo-rewarded-inmobi'),
    Network(title: 'IronSource', adUnitId: 'demo-rewarded-ironsource'),
    Network(title: 'Unity Ads', adUnitId: 'demo-rewarded-unityads'),
  ];
}
