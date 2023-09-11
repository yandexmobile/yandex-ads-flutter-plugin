/*
 * This file is a part of the Yandex Advertising Network
 *
 * Version for Flutter (C) 2023  YANDEX
 *
 * You may not use this file except in compliance with the License.
 * You may obtain a copy of the License at https://legal.yandex.com/partner_ch/
 */

import 'package:flutter/material.dart';
import 'package:yandex_mobileads_sample/pages/app_open_ad_manager.dart';

class AppOpenAdPage extends StatefulWidget with WidgetsBindingObserver {
  const AppOpenAdPage({Key? key}) : super(key: key);

  @override
  State<AppOpenAdPage> createState() => _AppOpenAdPageState();
}

class _AppOpenAdPageState extends State<AppOpenAdPage>
    with WidgetsBindingObserver {
  final _appOpenAdManager = AppOpenAdManager()..loadAppOpenAd();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('App open ad'),
      ),
      body: const SafeArea(
        child: Center(
          child: Text('Collapse and open App from recent to view AppOpenAd.'),
        ),
      ),
    );
  }

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (state == AppLifecycleState.resumed && !AppOpenAdManager.isAdShowing) {
      _appOpenAdManager.showAdIfAvailable();
    }
  }
}
