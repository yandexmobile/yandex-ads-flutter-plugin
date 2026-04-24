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
  final _adLoader = AppOpenAdLoader();
  AppOpenAd? _appOpenAd;

  static var isAdShowing = false;

  bool get isLoaded => _appOpenAd != null;

  Future<void> loadAppOpenAd() async {
    // load new Ad if there is no loaded Ad and new ad isn't loading
    if (_loadingInProgress == false) {
      _loadingInProgress = true;
      try {
        final ad = await _adLoader.loadAd(
          adRequest: AdRequest(adUnitId: _adUnitId),
        );
        _appOpenAd = ad;
        _loadingInProgress = false;
      } on AdRequestError catch (_) {
        _loadingInProgress = false;
      }
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
}
