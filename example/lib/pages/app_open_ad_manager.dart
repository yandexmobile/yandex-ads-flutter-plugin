/*
 * This file is a part of the Yandex Advertising Network
 *
 * Version for Flutter (C) 2023 YANDEX
 *
 * You may not use this file except in compliance with the License.
 * You may obtain a copy of the License at https://legal.yandex.com/partner_ch/
 */

import 'package:yandex_mobileads/mobile_ads.dart';

class AppOpenAdManager {
  final _adUnitId = 'demo-appopenad-yandex';
  var _loadingInProgress = false;
  late final _adRequestConfiguration =
      AdRequestConfiguration(adUnitId: _adUnitId);
  AppOpenAd? _appOpenAd;
  late final Future<AppOpenAdLoader> _appOpenAdLoader =
      _createAppOpenAdLoader();

  static var isAdShowing = false;

  bool get isLoaded => _appOpenAd != null;

  Future<void> loadAppOpenAd() async {
    // load new Ad if there is no loaded Ad and new ad isn't loading
    if (_loadingInProgress == false) {
      _loadingInProgress = true;
      final adLoader = await _appOpenAdLoader;
      adLoader.loadAd(adRequestConfiguration: _adRequestConfiguration);
    }
  }

  Future<void> showAdIfAvailable() async {
    var appOpenAd = _appOpenAd;
    if (appOpenAd != null && !isAdShowing) {
      _setAdEventListener(appOpenAd: appOpenAd);
      await appOpenAd.show();
      await appOpenAd.waitForDismiss();
    } else {
      loadAppOpenAd();
    }
  }

  void clearAppOpenAd() {
    _appOpenAd?.destroy();
    _appOpenAd = null;
  }

  void _setAdEventListener({required AppOpenAd appOpenAd}) {
    appOpenAd.setAdEventListener(
        eventListener: AppOpenAdEventListener(onAdShown: () {
      // Called when an app open ad has been shown
      isAdShowing = true;
    }, onAdFailedToShow: (error) {
      // Called when an app open ad failed to show
    }, onAdDismissed: () {
      // Called when an app open ad has been dismissed
      isAdShowing = false;
      clearAppOpenAd();
      loadAppOpenAd();
    }, onAdClicked: () {
      // Called when user clicked on the ad
    }, onAdImpression: (data) {
      // Called when an impression was observed
    }));
  }

  Future<AppOpenAdLoader> _createAppOpenAdLoader() {
    return AppOpenAdLoader.create(
      onAdLoaded: (AppOpenAd appOpenAd) {
        _appOpenAd = appOpenAd;
        _loadingInProgress = false;
      },
      onAdFailedToLoad: (error) {
        _loadingInProgress = false;
      },
    );
  }
}
