import 'package:eon_asset_scanner/models/connection_settings_model.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../models/item_model.dart';
import '../models/user_model.dart';

final sqlSettingsProvider = StateProvider<ConnectionSettings?>((ref) => null);

final userProvider = StateProvider<User?>((ref) => null);

final itemProvider = StateProvider<Item?>((ref) => null);
