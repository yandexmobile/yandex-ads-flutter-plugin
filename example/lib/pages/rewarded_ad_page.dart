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

class RewardedAdPage extends StatefulWidget {
  const RewardedAdPage({Key? key}) : super(key: key);

  @override
  State<RewardedAdPage> createState() => _RewardedAdPageState();
}

class _RewardedAdPageState extends State<RewardedAdPage> with TextLogger {
  final networks = NetworkProvider.instance.rewardedNetworks;

  late var adUnitId = networks.first.adUnitId;
  late RewardedAd? _ad;
  var adRequest = const AdRequest();
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
    _ad = await _createRewardedAd();
    logMessage('async: created rewarded ad');
    await _showRewardedAd();
  }

  Future<RewardedAd> _createRewardedAd() {
    return RewardedAd.create(
      adUnitId: adUnitId,
      onAdLoaded: () {
        setState(() => isLoading = false);
        logMessage('callback: rewarded ad loaded');
      },
      onAdFailedToLoad: (error) {
        setState(() => isLoading = false);
        logMessage('callback: rewarded ad failed to load, '
            'code: ${error.code}, description: ${error.description}');
      },
      onAdShown: () => logMessage('callback: rewarded ad shown'),
      onAdClicked: () => logMessage('callback: rewarded ad clicked'),
      onRewarded: (reward) {
        logMessage('callback: reward: '
            '${reward.amount} of ${reward.type}');
      },
      onAdDismissed: () {
        _ad = null;
        logMessage('callback: rewarded ad dismissed');
      },
      onLeftApplication: () => logMessage('callback: left app'),
      onReturnedToApplication: () => logMessage('callback: returned to app'),
      onImpression: (data) => logMessage('callback: impression: $data'),
    );
  }

  Future<void> _showRewardedAd() async {
    final ad = _ad;
    if (ad != null) {
      setState(() => isLoading = true);
      await ad.load(adRequest: adRequest);
      logMessage('async: loaded rewarded ad');
      await ad.show();
      logMessage('async: shown rewarded ad');
      var reward = await ad.waitForDismiss();
      logMessage('async: dismissed rewarded ad, '
          'reward: ${reward?.amount} of ${reward?.type}');
    }
  }
}
