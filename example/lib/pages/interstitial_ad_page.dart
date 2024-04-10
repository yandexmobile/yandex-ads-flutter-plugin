/*
 * This file is a part of the Yandex Advertising Network
 *
 * Version for Flutter (C) 2023 YANDEX
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
  const InterstitialAdPage({super.key});

  @override
  State<InterstitialAdPage> createState() => _InterstitialAdPageState();
}

class _InterstitialAdPageState extends State<InterstitialAdPage>
    with TextLogger {
  final networks = NetworkProvider.instance.interstitialNetworks;

  late var adUnitId = networks.first.adUnitId;
  InterstitialAd? _ad;
  late final Future<InterstitialAdLoader> _adLoader =
      _createInterstitialAdLoader();
  var adRequest = const AdRequest();
  late var _adRequestConfiguration = AdRequestConfiguration(adUnitId: adUnitId);
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
                _ad = null;
                adUnitId = id;
                adRequest = request;
                _updateAdRequestConfiguration(id, request);
              }),
            ),
            Widgets.verticalSpace,
            Expanded(
              child: LogTile(
                log: log,
                button: LoadButton(
                  isLoading: isLoading,
                  adLoaded: _ad != null,
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
    if (_ad != null) {
      await _showInterstitialAd();
    } else {
      await _loadInterstitialAd();
    }
  }

  Future<void> _loadInterstitialAd() async {
    final adLoader = await _adLoader;
    setState(() => isLoading = true);
    await adLoader.loadAd(adRequestConfiguration: _adRequestConfiguration);
    logMessage('async: load interstitial ad');
  }

  Future<void> _showInterstitialAd() async {
    final ad = _ad;
    if (ad != null) {
      _setAdEventListener(ad);
      await ad.show();
      logMessage('async: shown interstitial ad');
      await ad.waitForDismiss();
      logMessage('async: dismissed interstitial ad');
      setState(() => _ad = null);
    }
  }

  void _setAdEventListener(InterstitialAd ad) {
    ad.setAdEventListener(
        eventListener: InterstitialAdEventListener(
      onAdShown: () => logMessage('callback: interstitial ad shown'),
      onAdFailedToShow: (error) {
        logMessage(
            'callback: interstitial ad failed to load, description: ${error.description}');
      },
      onAdClicked: () => logMessage('callback: interstitial ad clicked'),
      onAdDismissed: () {
        logMessage('callback: interstitial ad dismissed');
      },
      onAdImpression: (data) =>
          logMessage('callback: impression: ${data.getRawData()}'),
    ));
  }

  Future<InterstitialAdLoader> _createInterstitialAdLoader() {
    return InterstitialAdLoader.create(
      onAdLoaded: (InterstitialAd interstitialAd) {
        setState(() {
          _ad = interstitialAd;
          isLoading = false;
        });
        logMessage('callback: interstitial ad loaded');
      },
      onAdFailedToLoad: (error) {
        setState(() {
          _ad = null;
          isLoading = false;
        });
        logMessage('callback: interstitial ad failed to load, '
            'code: ${error.code}, description: ${error.description}');
      },
    );
  }

  void _updateAdRequestConfiguration(String adUnitId, AdRequest configuration) {
    _adRequestConfiguration = AdRequestConfiguration(
        adUnitId: adUnitId,
        age: configuration.age,
        contextQuery: configuration.contextQuery,
        contextTags: configuration.contextTags,
        gender: configuration.gender,
        location: configuration.location,
        parameters: configuration.parameters,
        preferredTheme: configuration.preferredTheme);
  }
}
