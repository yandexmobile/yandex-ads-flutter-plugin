/*
 * This file is a part of the Yandex Advertising Network
 *
 * Version for Flutter (C) 2023 YANDEX
 *
 * You may not use this file except in compliance with the License.
 * You may obtain a copy of the License at https://legal.yandex.com/partner_ch/
 */

import 'package:flutter/material.dart';
import 'package:yandex_mobileads_sample/pages/app_open_ad_page.dart';
import 'package:yandex_mobileads_sample/policies/policies_page.dart';

import 'pages/banner_ad_page.dart';
import 'pages/home_page.dart';
import 'pages/interstitial_ad_page.dart';
import 'pages/rewarded_ad_page.dart';

void main() => runApp(const YandexMobileAdsApp());

class YandexMobileAdsApp extends StatelessWidget {
  static const colorSchemeSeed = Colors.green;
  static const inputDecorationTheme = InputDecorationTheme(
    border: OutlineInputBorder(),
  );
  static const listTileTheme = ListTileThemeData(
    horizontalTitleGap: 12.0,
  );

  const YandexMobileAdsApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Yandex Mobile Ads',
      theme: ThemeData(
        useMaterial3: true,
        colorSchemeSeed: colorSchemeSeed,
        inputDecorationTheme: inputDecorationTheme,
        listTileTheme: listTileTheme,
      ),
      darkTheme: ThemeData(
        useMaterial3: true,
        brightness: Brightness.dark,
        colorSchemeSeed: colorSchemeSeed,
        inputDecorationTheme: inputDecorationTheme,
        listTileTheme: listTileTheme,
      ),
      routes: {
        '/': (context) => const HomePage(),
        '/app_open': (context) => const AppOpenAdPage(),
        '/banner_sticky': (context) {
          return const BannerAdPage(
            title: 'Sticky banner ad',
            isSticky: true,
          );
        },
        '/banner_inline': (context) {
          return const BannerAdPage(
            title: 'Inline banner ad',
          );
        },
        '/interstitial': (context) => const InterstitialAdPage(),
        '/rewarded': (context) => const RewardedAdPage(),
        '/policies': (context) => const PoliciesPage(),
      },
    );
  }
}
