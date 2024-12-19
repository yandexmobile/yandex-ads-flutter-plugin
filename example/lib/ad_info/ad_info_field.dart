/*
 * This file is a part of the Yandex Advertising Network
 *
 * Version for Flutter (C) 2022 YANDEX
 *
 * You may not use this file except in compliance with the License.
 * You may obtain a copy of the License at https://legal.yandex.com/partner_ch/
 */

import 'package:flutter/material.dart';
import 'package:yandex_mobileads/mobile_ads.dart';

import 'network.dart';

class AdInfoField extends StatefulWidget {
  final List<Network> networks;
  final void Function(String adUnitId, AdRequest adRequest)? onChanged;

  const AdInfoField({
    super.key,
    required this.networks,
    this.onChanged,
  });

  @override
  State<AdInfoField> createState() => _AdInfoFieldState();
}

class _AdInfoFieldState extends State<AdInfoField> {
  var adRequest = const AdRequest();
  var menuOpened = false;

  late TextEditingController controller;
  final fieldKey = GlobalKey();

  @override
  void initState() {
    super.initState();
    controller = TextEditingController(text: widget.networks.first.title);
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: TextField(
        key: fieldKey,
        controller: controller,
        keyboardType: TextInputType.none,
        showCursor: false,
        decoration: InputDecoration(
          icon: const Icon(Icons.ad_units_outlined),
          label: const Text('Network'),
          suffixIcon: menuOpened
              ? const Icon(Icons.arrow_drop_up_outlined)
              : const Icon(Icons.arrow_drop_down_outlined),
        ),
        onTap: showDropdownMenu,
      ),
    );
  }

  Future<void> showDropdownMenu() async {
    setState(() => menuOpened = true);
    final object = fieldKey.currentContext?.findRenderObject() as RenderBox?;
    if (object == null) return;
    final position = object.localToGlobal(Offset.zero).translate(40.0, 64.0);
    final result = await showMenu(
      context: context,
      position: RelativeRect.fromSize(
        Rect.fromPoints(position, position),
        object.size,
      ),
      elevation: 8.0,
      color: Theme.of(context).colorScheme.surfaceContainerHighest,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8.0),
      ),
      items: widget.networks.map((network) {
        return PopupMenuItem(
          value: network,
          child: Text(network.title),
        );
      }).toList(),
    );
    if (result != null) {
      controller.text = result.title;
      widget.onChanged?.call(result.adUnitId, result.adRequest);
    }
    setState(() => menuOpened = false);
  }
}
