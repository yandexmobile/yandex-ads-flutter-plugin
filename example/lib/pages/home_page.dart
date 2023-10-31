/*
 * This file is a part of the Yandex Advertising Network
 *
 * Version for Flutter (C) 2023  YANDEX
 *
 * You may not use this file except in compliance with the License.
 * You may obtain a copy of the License at https://legal.yandex.com/partner_ch/
 */

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'network_warning_dialog.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    _showNetworkWarning(context);
    return Scaffold(
      appBar: AppBar(
        title: const Text('Yandex Mobile Ads'),
      ),
      body: ListView(
        children: [
          ListTile(
            leading: const Icon(Icons.fullscreen_outlined),
            title: const Text('App open ad'),
            trailing: const Icon(Icons.chevron_right),
            onTap: () => Navigator.pushNamed(context, '/app_open'),
          ),
          ListTile(
            leading: const Icon(Icons.ad_units_outlined),
            title: const Text('Sticky banner'),
            trailing: const Icon(Icons.chevron_right),
            onTap: () => Navigator.pushNamed(context, '/banner_sticky'),
          ),
          ListTile(
            leading: const Icon(Icons.aspect_ratio_outlined),
            title: const Text('Inline banner'),
            trailing: const Icon(Icons.chevron_right),
            onTap: () => Navigator.pushNamed(context, '/banner_inline'),
          ),
          ListTile(
            leading: const Icon(Icons.fullscreen_outlined),
            title: const Text('Interstitial'),
            trailing: const Icon(Icons.chevron_right),
            onTap: () => Navigator.pushNamed(context, '/interstitial'),
          ),
          ListTile(
            leading: const Icon(Icons.video_collection_outlined),
            title: const Text('Rewarded'),
            trailing: const Icon(Icons.chevron_right),
            onTap: () => Navigator.pushNamed(context, '/rewarded'),
          ),
          ListTile(
            leading: const Icon(Icons.contact_page_outlined),
            title: const Text('Policies'),
            trailing: const Icon(Icons.chevron_right),
            onTap: () => Navigator.pushNamed(context, '/policies'),
          ),
        ],
      ),
    );
  }

  Future<void> _showNetworkWarning(BuildContext context) async {
    const key = 'isWarningShown';
    final prefs = await SharedPreferences.getInstance();
    final isWarningShown = prefs.getBool(key) ?? false;
    if (!isWarningShown && context.mounted) {
      await showDialog(
          context: context,
          builder: (context) => const NetworkWarningDialog()
      );
    }
    prefs.setBool(key, true);
  }
}
