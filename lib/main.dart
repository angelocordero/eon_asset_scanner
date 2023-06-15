import 'package:eon_asset_scanner/eon_asset_scanner.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:path_provider/path_provider.dart';

import 'core/constants.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  Hive.init(await getApplicationSupportDirectory().then((value) => value.path));
  await Hive.openBox('settings', encryptionCipher: HiveAesCipher(secureKey));

  runApp(
    const ProviderScope(
      child: EonAssetScanner(),
    ),
  );
}
