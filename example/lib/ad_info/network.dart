/*
 * This file is a part of the Yandex Advertising Network
 *
 * Version for Flutter (C) 2022 YANDEX
 *
 * You may not use this file except in compliance with the License.
 * You may obtain a copy of the License at https://legal.yandex.com/partner_ch/
 */

import 'package:yandex_mobileads/mobile_ads.dart';

class Network {
  final String title;
  final String adUnitId;
  final AdRequest adRequest;

  const Network({
    required this.title,
    required this.adUnitId,
    this.adRequest = const AdRequest(),
  });
}
