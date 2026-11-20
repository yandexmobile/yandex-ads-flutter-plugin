/*
 * This file is a part of the Yandex Advertising Network
 *
 * Version for Flutter (C) 2026 YANDEX
 *
 * You may not use this file except in compliance with the License.
 * You may obtain a copy of the License at https://legal.yandex.com/partner_ch/
 */

import 'package:flutter/material.dart';
import 'package:yandex_mobileads/mobile_ads.dart';

class AdAudioPage extends StatefulWidget {
  const AdAudioPage({super.key});

  @override
  State<AdAudioPage> createState() => _AdAudioPageState();
}

class _AdAudioPageState extends State<AdAudioPage> {
  final _controller = YandexAds.adVolumeController;
  double _volume = 1.0;
  bool _busy = false;
  String? _error;

  Future<void> _update(Future<void> Function() update) async {
    setState(() => _busy = true);
    try {
      await update();
      if (mounted) setState(() => _error = null);
    } catch (error) {
      if (mounted) setState(() => _error = error.toString());
    } finally {
      if (mounted) setState(() => _busy = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Ad audio')),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          const Text(
            'Sets the initial sound for native video ads when playback is '
            'prepared.',
          ),
          if (_error != null) Text(_error!),
          ElevatedButton(
            onPressed:
                _busy ? null : () => _update(() => _controller.setMuted(true)),
            child: const Text('Mute ads'),
          ),
          ElevatedButton(
            onPressed:
                _busy ? null : () => _update(() => _controller.setMuted(false)),
            child: const Text('Unmute ads'),
          ),
          Text('Set ad volume: ${(_volume * 100).round()}%'),
          Slider(
            value: _volume,
            divisions: 100,
            onChanged:
                _busy ? null : (value) => setState(() => _volume = value),
          ),
          ElevatedButton(
            onPressed: _busy
                ? null
                : () => _update(() => _controller.setVolume(_volume)),
            child: const Text('Apply volume'),
          ),
          const Text('Volume is preserved while muted.'),
        ],
      ),
    );
  }
}
