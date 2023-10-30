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

class RewardedAdPage extends StatefulWidget {
  const RewardedAdPage({Key? key}) : super(key: key);

  @override
  State<RewardedAdPage> createState() => _RewardedAdPageState();
}

class _RewardedAdPageState extends State<RewardedAdPage> with TextLogger {
  final networks = NetworkProvider.instance.rewardedNetworks;

  late var adUnitId = networks.first.adUnitId;
  RewardedAd? _ad;
  late final Future<RewardedAdLoader> _adLoader = _createRewardedAdLoader();
  var adRequest = const AdRequest();
  late var _adRequestConfiguration = AdRequestConfiguration(adUnitId: adUnitId);
  var isLoading = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Rewarded ad'),
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
      await _showRewardedAd();
    } else {
      await _loadRewardedAd();
    }
  }

  Future<RewardedAdLoader> _createRewardedAdLoader() {
    return RewardedAdLoader.create(
      onAdLoaded: (RewardedAd rewardedAd) {
        setState(() => {_ad = rewardedAd, isLoading = false});
        logMessage('callback: rewarded ad loaded');
      },
      onAdFailedToLoad: (error) {
        setState(() => {_ad = null, isLoading = false});
        logMessage('callback: rewarded ad failed to load, '
            'code: ${error.code}, description: ${error.description}');
      },
    );
  }

  Future<void> _loadRewardedAd() async {
    final adLoader = await _adLoader;
    setState(() => isLoading = true);
    await adLoader.loadAd(adRequestConfiguration: _adRequestConfiguration);
    logMessage('async: load rewarded ad');
  }

  Future<void> _showRewardedAd() async {
    final ad = _ad;
    if (ad != null) {
      _setAdEventListener(ad);
      await ad.show();
      logMessage('async: shown rewarded ad');
      var reward = await ad.waitForDismiss();
      logMessage('async: dismissed rewarded ad, '
          'reward: ${reward?.amount} of ${reward?.type}');
      setState(() => _ad = null);
    }
  }

  void _setAdEventListener(RewardedAd ad) {
    ad.setAdEventListener(
        eventListener: RewardedAdEventListener(
            onAdShown: () => logMessage("callback: rewarded ad shown."),
            onAdFailedToShow: (error) => logMessage(
                "callback: rewarded ad failed to show: ${error.description}."),
            onAdDismissed: () => logMessage("callback: rewarded ad dismissed."),
            onAdClicked: () => logMessage("callback: rewarded ad clicked."),
            onAdImpression: (data) =>
                logMessage("callback: rewarded ad impression: ${data.getRawData()}"),
            onRewarded: (Reward reward) => logMessage(
                'callback: reward: ${reward.amount} of ${reward.type}')));
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
