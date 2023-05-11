import 'package:eon_asset_scanner/core/database_api.dart';
import 'package:eon_asset_scanner/core/providers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mobile_scanner/mobile_scanner.dart';

import '../models/item_model.dart';

class ScanScreen extends ConsumerStatefulWidget {
  const ScanScreen({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _ScanScreenState();
}

class _ScanScreenState extends ConsumerState<ScanScreen> {
  late final TextEditingController _manualScanController;

  late final MobileScannerController controller;

  @override
  void initState() {
    _manualScanController = TextEditingController();
    controller = MobileScannerController(
      formats: [BarcodeFormat.qrCode],
      detectionSpeed: DetectionSpeed.noDuplicates,
    );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Scan Product'),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          _scanner(context, ref),
          _manualScan(context, ref),
        ],
      ),
    );
  }

  Visibility _scanner(BuildContext context, WidgetRef ref) {
    return Visibility(
      visible: MediaQuery.of(context).viewInsets.bottom == 0,
      child: Flexible(
        flex: 2,
        child: MobileScanner(
          controller: controller,
          // allowDuplicates: false,
          onDetect: (BarcodeCapture capture) async {
            await controller.stop();
            final Barcode code = capture.barcodes.first;
            // ignore: use_build_context_synchronously
            await _scanProduct(context, ref, code.rawValue);
          },
        ),
      ),
    );
  }

  Widget _manualScan(BuildContext context, WidgetRef ref) {
    return Flexible(
      flex: 2,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text('Trouble scanning QR code?'),
            const Text('Enter product ID manually.'),
            Expanded(
              flex: 1,
              child: Center(
                child: TextField(
                  controller: _manualScanController,
                  decoration: const InputDecoration(
                    isDense: true,
                    contentPadding: EdgeInsets.all(8.0),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.all(
                        Radius.circular(12.0),
                      ),
                    ),
                  ),
                ),
              ),
            ),
            Expanded(
              flex: 2,
              child: Center(
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  onPressed: () async {
                    _scanProduct(
                      context,
                      ref,
                      _manualScanController.text.trim(),
                    );
                  },
                  child: const Text('Enter'),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _scanProduct(BuildContext context, WidgetRef ref, String? assetID) async {
    if (assetID == null) return;

    try {
      Item? item = await DatabaseAPI(ref.read(sqlSettingsProvider)).getItem(assetID);
      ref.read(itemProvider.notifier).state = item;

      // await dispose();

      // ignore: use_build_context_synchronously
      Navigator.pop(context);
    } catch (e) {
      EasyLoading.showError(e.toString());
    }
  }

  @override
  Future<void> dispose() async {
    _manualScanController.clear();

    controller.dispose();
    super.dispose();
  }
}
