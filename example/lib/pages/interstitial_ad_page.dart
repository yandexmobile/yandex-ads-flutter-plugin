/*
 * This file is a part of the Yandex Advertising Network
 *
 * Version for Flutter (C) 2022 YANDEX
 *
 * You may not use this file except in compliance with the License.
 * You may obtain a copy of the License at https://legal.yandex.com/partner_ch/
 */

import 'package:flutter/material.dart';
import 'package:yandex_mobileads/mobile_ads.dart';
import 'package:yandex_mobileads_sample/ad_info/network_provider.dart';

import '../ad_info/ad_info_field.dart';
import '../ad_info/load_button.dart';
import '../constants.dart';
import '../logging/log_tile.dart';
import '../logging/text_logger.dart';

class InterstitialAdPage extends StatefulWidget {
  const InterstitialAdPage({Key? key}) : super(key: key);

  @override
  State<InterstitialAdPage> createState() => _InterstitialAdPageState();
}

class _InterstitialAdPageState extends State<InterstitialAdPage>
    with TextLogger {
  final networks = NetworkProvider.instance.interstitialNetworks;

  late var adUnitId = networks.first.adUnitId;
  late InterstitialAd? _ad;
  var adRequest = const AdRequest();
  var isLoading = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Interstitial ad'),
      ),
      body: SafeArea(
        child: Column(
          children: [
            Widgets.verticalSpace,
            AdInfoField(
              networks: networks,
              onChanged: (id, request) => setState(() {
                isLoading = false;
                adUnitId = id;
                adRequest = request;
              }),
            ),
            Widgets.verticalSpace,
            Expanded(
              child: LogTile(
                log: log,
                button: LoadButton(
                  isLoading: isLoading,
                  onPressed: _onLoadClicked,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _onLoadClicked() async {
    _ad = await _createInterstitialAd();
    logMessage('async: created interstitial ad');
    await _showInterstitialAd();
  }

  Future<InterstitialAd> _createInterstitialAd() {
    return InterstitialAd.create(
      adUnitId: adUnitId,
      onAdLoaded: () {
        setState(() => isLoading = false);
        logMessage('callback: interstitial ad loaded');
      },
      onAdFailedToLoad: (error) {
        setState(() => isLoading = false);
        logMessage('callback: interstitial ad failed to load, '
            'code: ${error.code}, description: ${error.description}');
      },
      onAdShown: () => logMessage('callback: interstitial ad shown'),
      onAdClicked: () => logMessage('callback: interstitial ad clicked'),
      onAdDismissed: () {
        _ad = null;
        logMessage('callback: interstitial ad dismissed');
      },
      onLeftApplication: () => logMessage('callback: left app'),
      onReturnedToApplication: () => logMessage('callback: returned to app'),
      onImpression: (data) => logMessage('callback: impression: $data'),
    );
  }

  Future<void> _showInterstitialAd() async {
    final ad = _ad;
    if (ad != null) {
      setState(() => isLoading = true);
      await ad.load(adRequest: adRequest);
      logMessage('async: loaded interstitial ad');
      await ad.show();
      logMessage('async: shown interstitial ad');
      await ad.waitForDismiss();
      logMessage('async: dismissed interstitial ad');
    }
  }
}
