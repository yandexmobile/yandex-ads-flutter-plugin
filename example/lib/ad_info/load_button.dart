/*
 * This file is a part of the Yandex Advertising Network
 *
 * Version for Flutter (C) 2023 YANDEX
 *
 * You may not use this file except in compliance with the License.
 * You may obtain a copy of the License at https://legal.yandex.com/partner_ch/
 */

import 'package:flutter/material.dart';

class LoadButton extends StatelessWidget {
  final bool isLoading;
  final bool? adLoaded;
  final void Function()? onPressed;

  const LoadButton(
      {Key? key, required this.isLoading, this.adLoaded, this.onPressed})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (isLoading) {
      return ElevatedButton.icon(
        icon: Transform.scale(
          scale: 0.4,
          child: const CircularProgressIndicator(),
        ),
        label: const Text('Loading'),
        onPressed: null,
      );
    } else if (adLoaded ?? false) {
      return ElevatedButton.icon(
        icon: const Icon(Icons.play_arrow_outlined),
        label: const Text('Show ad'),
        onPressed: onPressed,
      );
    } else {
      return ElevatedButton.icon(
        icon: const Icon(Icons.play_arrow_outlined),
        label: const Text('Load ad'),
        onPressed: onPressed,
      );
    }
  }
}
