import 'package:eon_asset_scanner/eon_asset_scanner.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

void main() {
  runApp(
    const ProviderScope(
      child: EonAssetScanner(),
    ),
  );
}
