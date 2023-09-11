/*
 * This file is a part of the Yandex Advertising Network
 *
 * Version for Flutter (C) 2023  YANDEX
 *
 * You may not use this file except in compliance with the License.
 * You may obtain a copy of the License at https://legal.yandex.com/partner_ch/
 */

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
    Key? key,
    required this.title,
    this.isSticky = false,
  }) : super(key: key);

  @override
  State<BannerAdPage> createState() => _BannerAdPageState();
}

class _BannerAdPageState extends State<BannerAdPage> with TextLogger {
  final networks = NetworkProvider.instance.bannerNetworks;

  late var adUnitId = networks.first.adUnitId;
  var adRequest = const AdRequest();
  var isLoading = false;
  var isBannerAlreadyCreated = false;

  late BannerAd banner;

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
              onChanged: (id, request) => setState(() {
                isLoading = false;
                adUnitId = id;
                adRequest = request;
                isBannerAlreadyCreated = false;
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
                child:
                    isBannerAlreadyCreated ? AdWidget(bannerAd: banner) : null,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _loadBanner() async {
    final windowSize = MediaQuery.of(context).size;
    setState(() => isLoading = true);
    if (isBannerAlreadyCreated) {
      banner.loadAd(adRequest: adRequest);
    } else {
      final adSize = widget.isSticky
          ? BannerAdSize.sticky(width: windowSize.width.toInt())
          : BannerAdSize.inline(
              width: windowSize.width.toInt(),
              maxHeight: windowSize.height ~/ 3,
            );
      banner = _createBanner(adSize);
      setState(() {
        isBannerAlreadyCreated = true;
      });
    }
  }

  BannerAd _createBanner(BannerAdSize adSize) {
    return BannerAd(
      adUnitId: adUnitId,
      adSize: adSize,
      adRequest: adRequest,
      onAdLoaded: () {
        setState(() {
          isLoading = false;
        });
        logMessage('callback: banner ad loaded');
      },
      onAdFailedToLoad: (error) {
        setState(() => isLoading = false);
        logMessage('callback: banner ad failed to load, '
            'code: ${error.code}, description: ${error.description}');
      },
      onAdClicked: () => logMessage('callback: banner ad clicked'),
      onLeftApplication: () => logMessage('callback: left app'),
      onReturnedToApplication: () => logMessage('callback: returned to app'),
      onImpression: (data) =>
          logMessage('callback: impression: ${data.getRawData()}'),
    );
  }
}
