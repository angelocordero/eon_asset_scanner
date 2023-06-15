import 'package:eon_asset_scanner/core/utils.dart';

import '../core/database_api.dart';
import 'package:eon_asset_scanner/core/providers.dart';
import 'package:eon_asset_scanner/widgets/overlay.dart';
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
        title: const Text('Scan QR Code'),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          _scanner(context),
          _manualScan(context),
        ],
      ),
    );
  }

  Visibility _scanner(BuildContext context) {
    double width = MediaQuery.of(context).size.width / 2;
    double height = MediaQuery.of(context).size.height / 4 * 3 / 2;
    double scanArea = width * 1.3;

    return Visibility(
      visible: MediaQuery.of(context).viewInsets.bottom == 0,
      child: Expanded(
        child: Stack(
          children: [
            MobileScanner(
              scanWindow: Rect.fromCenter(
                center: Offset(width, height),
                width: scanArea + 50,
                height: scanArea + 50,
              ),
              controller: controller,
              onDetect: (BarcodeCapture capture) async {
                EasyLoading.show();

                await controller.stop();

                final Barcode code = capture.barcodes.first;
                // ignore: use_build_context_synchronously
                _scanProduct(context, code.rawValue);
              },
            ),
            QRScannerOverlay(
              overlayColour: Colors.black.withOpacity(0.5),
              scanArea: scanArea,
            ),
          ],
        ),
      ),
    );
  }

  Widget _manualScan(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MediaQuery.of(context).viewInsets.bottom == 0 ? MainAxisAlignment.spaceAround : MainAxisAlignment.start,
        children: [
          const Text('Trouble scanning QR code?'),
          const SizedBox(height: 20),
          const Text('Enter Asset ID manually.'),
          const SizedBox(height: 20),
          Center(
            child: TextField(
              controller: _manualScanController,
              decoration: const InputDecoration(
                isDense: true,
                contentPadding: EdgeInsets.all(8.0),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.all(
                    Radius.circular(8.0),
                  ),
                ),
              ),
            ),
          ),
          const SizedBox(height: 20),
          Center(
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
              onPressed: () async {
                String assetID = _manualScanController.text.trim();

                if (assetID.isEmpty) return;

                try {
                  EasyLoading.show();
                  await Future.delayed(const Duration(milliseconds: 500));

                  Item? item = await DatabaseAPI.getItem(assetID);

                  ref.read(itemProvider.notifier).state = item;

                  EasyLoading.dismiss();
                  // ignore: use_build_context_synchronously
                  Navigator.pushReplacementNamed(context, 'home');
                } catch (e, st) {
                  showErrorAndStacktrace(e, st);
                }
              },
              child: const Text('Scan'),
            ),
          ),
        ],
      ),
    );
  }

  Future<void> _scanProduct(BuildContext context, String? assetID) async {
    if (assetID == null) return;

    try {
      await Future.delayed(const Duration(milliseconds: 500));

      Item? item = await DatabaseAPI.getItem(assetID);

      ref.read(itemProvider.notifier).state = item;

      await EasyLoading.dismiss();
      // ignore: use_build_context_synchronously
      Navigator.pop(context);
//Navigator.pushReplacementNamed(context, 'home');
    } catch (e, st) {
      showErrorAndStacktrace(e, st);
    }
  }

  @override
  Future<void> dispose() async {
    _manualScanController.clear();

    controller.dispose();
    super.dispose();
  }
}
