import 'package:eon_asset_scanner/core/providers.dart';
import 'package:eon_asset_scanner/widgets/item_info_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../models/item_model.dart';

class HomeScreen extends ConsumerWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    Item? item = ref.watch(itemProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Eon Asset Scanner'),
        actions: [
          Tooltip(
            message: 'Log Out',
            triggerMode: TooltipTriggerMode.longPress,
            child: IconButton.outlined(
              onPressed: () {
                showConfirmLogoutDialog(context);
              },
              icon: const Icon(Icons.logout),
            ),
          ),
        ],
      ),
      body: Center(
        child: item == null ? Container() : ItemInfo(item: item),
      ),
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.qr_code),
        onPressed: () {
          Navigator.pushNamed(context, 'scan');
        },
      ),
    );
  }

  Future<dynamic> showConfirmLogoutDialog(
    BuildContext context,
  ) async {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Confirm log out?'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: const Text('Cancel'),
            ),
            TextButton(
              onPressed: () {
                Navigator.pop(context);
                Navigator.pushReplacementNamed(context, '/');
              },
              child: const Text('Confirm'),
            ),
          ],
        );
      },
    );
  }
}
