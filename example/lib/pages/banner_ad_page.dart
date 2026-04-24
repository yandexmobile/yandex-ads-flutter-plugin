/*
 * This file is a part of the Yandex Advertising Network
 *
 * Version for Flutter (C) 2023  YANDEX
 *
 * You may not use this file except in compliance with the License.
 * You may obtain a copy of the License at https://legal.yandex.com/partner_ch/
 */

import 'dart:async';

import 'package:flutter/material.dart';
import 'package:yandex_mobileads/mobile_ads.dart';
import 'package:yandex_mobileads_sample/ad_info/load_button.dart';
import 'package:yandex_mobileads_sample/ad_info/network_provider.dart';

import '../ad_info/ad_info_field.dart';
import '../constants.dart';
import '../logging/log_tile.dart';
import '../logging/text_logger.dart';

class BannerAdPage extends StatefulWidget {
  final String title;
  final bool isSticky;

  const BannerAdPage({
    super.key,
    required this.title,
    this.isSticky = false,
  });

  @override
  State<BannerAdPage> createState() => _BannerAdPageState();
}

class _BannerAdPageState extends State<BannerAdPage> with TextLogger {
  final networks = NetworkProvider.instance.bannerNetworks;

  late var adUnitId = networks.first.adUnitId;
  Map<String, String>? _parameters;
  var isLoading = false;

  BannerAd? _banner;
  StreamSubscription<BannerAdLoadState>? _loadStateSubscription;
  StreamSubscription<BannerAdEvent>? _eventsSubscription;

  @override
  void dispose() {
    _loadStateSubscription?.cancel();
    _eventsSubscription?.cancel();
    _banner?.destroy();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: SafeArea(
        child: Column(
          children: [
            Widgets.verticalSpace,
            AdInfoField(
              networks: networks,
              onChanged: (network) => setState(() {
                isLoading = false;
                adUnitId = network.adUnitId;
                _parameters = network.parameters;
                _loadStateSubscription?.cancel();
                _eventsSubscription?.cancel();
                _banner?.destroy();
                _banner = null;
              }),
            ),
            Widgets.verticalSpace,
            Expanded(
              child: LogTile(
                log: log,
                button: LoadButton(
                  isLoading: isLoading,
                  onPressed: _loadBanner,
                ),
              ),
            ),
            SafeArea(
              child: Align(
                alignment: Alignment.bottomCenter,
                child: _banner != null ? AdWidget(bannerAd: _banner!) : null,
              ),
            ),
          ],
        ),
      ),
    );
  }

  AdRequest _createAdRequest() {
    return AdRequest(
      adUnitId: adUnitId,
      parameters: _parameters,
    );
  }

  Future<void> _loadBanner() async {
    final windowSize = MediaQuery.of(context).size;
    setState(() => isLoading = true);

    if (_banner == null) {
      final adSize = widget.isSticky
          ? BannerAdSize.sticky(width: windowSize.width.toInt())
          : BannerAdSize.inline(
              width: windowSize.width.toInt(),
              maxHeight: windowSize.height ~/ 3,
            );
      var calculatedBannerSize = await adSize.getCalculatedBannerAdSize();
      logMessage('calculatedBannerSize: ${calculatedBannerSize.toString()}');

      final banner = BannerAd(adSize: adSize);
      _subscribeToBanner(banner);
      setState(() {
        _banner = banner;
      });
    }

    _banner!.load(_createAdRequest());
  }

  void _subscribeToBanner(BannerAd banner) {
    _loadStateSubscription?.cancel();
    _eventsSubscription?.cancel();

    _loadStateSubscription = banner.loadStateStream.listen((state) {
      if (state is BannerAdLoadStateLoaded) {
        setState(() => isLoading = false);
        logMessage('callback: banner ad loaded '
            '(${state.width}x${state.height})');
      } else if (state is BannerAdLoadStateError) {
        setState(() => isLoading = false);
        logMessage('callback: banner ad failed to load, '
            'code: ${state.error.code}, '
            'description: ${state.error.description}');
      } else if (state is BannerAdLoadStateLoading) {
        logMessage('callback: banner ad loading');
      }
    });

    _eventsSubscription = banner.events.listen((event) {
      if (event is BannerAdClickedEvent) {
        logMessage('callback: banner ad clicked');
      } else if (event is BannerAdImpressionEvent) {
        logMessage(
            'callback: impression: ${event.impressionData.getRawData()}');
      }
    });
  }
}
