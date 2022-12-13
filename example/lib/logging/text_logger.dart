/*
 * This file is a part of the Yandex Advertising Network
 *
 * Version for Flutter (C) 2022 YANDEX
 *
 * You may not use this file except in compliance with the License.
 * You may obtain a copy of the License at https://legal.yandex.com/partner_ch/
 */

import 'package:flutter/material.dart';

mixin TextLogger<T extends StatefulWidget> on State<T> {
  var log = '';

  void logMessage(String message) => setState(() => log += '$message\n');
}
