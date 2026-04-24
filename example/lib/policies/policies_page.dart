import 'package:flutter/material.dart';
import 'package:yandex_mobileads/mobile_ads.dart';

import 'coppa_dialog.dart';
import 'gdpr_dialog.dart';
import 'location_dialog.dart';

class PoliciesPage extends StatefulWidget {
  const PoliciesPage({super.key});

  @override
  State<PoliciesPage> createState() => _PoliciesPageState();
}

class _PoliciesPageState extends State<PoliciesPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Policies'),
        ),
        body: ListView(
          children: [
            ListTile(
              leading: const Icon(Icons.handshake_outlined),
              title: YandexAds.userConsent
                  ? const Text('User consent enabled')
                  : const Text('User consent disabled'),
              trailing: ElevatedButton(
                child: const Text('Open dialog'),
                onPressed: () async {
                  final bool result = await showDialog(
                    context: context,
                    builder: (context) => const GdprDialog(),
                  );
                  YandexAds.setUserConsent(result);
                  setState(() {});
                },
              ),
            ),
            ListTile(
              leading: const Icon(Icons.place_outlined),
              title: YandexAds.locationTracking
                  ? const Text('Location consent enabled')
                  : const Text('Location consent disabled'),
              trailing: ElevatedButton(
                child: const Text('Open dialog'),
                onPressed: () async {
                  final bool result = await showDialog(
                    context: context,
                    builder: (context) => const LocationDialog(),
                  );
                  YandexAds.setLocationTracking(result);
                  setState(() {});
                },
              ),
            ),
            ListTile(
              leading: const Icon(Icons.child_care_outlined),
              title: YandexAds.ageRestricted
                  ? const Text('User is age restricted')
                  : const Text('User is not age restricted'),
              trailing: ElevatedButton(
                child: const Text('Open dialog'),
                onPressed: () async {
                  final bool result = await showDialog(
                    context: context,
                    builder: (context) => const CoppaDialog(),
                  );
                  YandexAds.setAgeRestricted(result);
                  setState(() {});
                },
              ),
            ),
          ],
        ));
  }
}
