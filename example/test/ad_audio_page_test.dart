/*
 * This file is a part of the Yandex Advertising Network
 *
 * Version for Flutter (C) 2026 YANDEX
 *
 * You may not use this file except in compliance with the License.
 * You may obtain a copy of the License at https://legal.yandex.com/partner_ch/
 */

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:yandex_mobileads_sample/pages/ad_audio_page.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  const channel = MethodChannel('yandex_mobileads.mobileAds');
  final messenger =
      TestDefaultBinaryMessengerBinding.instance.defaultBinaryMessenger;

  tearDown(() => messenger.setMockMethodCallHandler(channel, null));

  testWidgets('opening settings makes no calls; buttons apply chosen settings',
      (tester) async {
    final calls = <MethodCall>[];
    messenger.setMockMethodCallHandler(channel, (call) async {
      calls.add(call);
      return null;
    });

    await tester.pumpWidget(const MaterialApp(home: AdAudioPage()));
    await tester.pumpAndSettle();
    expect(calls, isEmpty);

    await tester.tap(find.text('Mute ads'));
    await tester.pumpAndSettle();
    await tester.tap(find.text('Unmute ads'));
    await tester.pumpAndSettle();
    tester.widget<Slider>(find.byType(Slider)).onChanged!(0.375);
    await tester.pump();
    await tester.tap(find.text('Apply volume'));
    await tester.pumpAndSettle();

    expect(calls.map((call) => call.method),
        ['setAdMuted', 'setAdMuted', 'setAdVolume']);
    expect(calls.map((call) => call.arguments), [true, false, 0.375]);
  });
}
