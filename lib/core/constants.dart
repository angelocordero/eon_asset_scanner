// ignore_for_file: constant_identifier_names

import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';

import '../models/connection_settings_model.dart';

BorderRadius defaultBorderRadius = BorderRadius.circular(8);

Box settingsBox = Hive.box('settings');

ConnectionSettings globalConnectionSettings = ConnectionSettings.empty();

List<int> secureKey = [
  213,
  66,
  81,
  33,
  169,
  64,
  141,
  228,
  109,
  89,
  3,
  51,
  152,
  108,
  8,
  222,
  78,
  170,
  6,
  45,
  238,
  169,
  200,
  5,
  24,
  55,
  95,
  15,
  177,
  250,
  141,
  152
];