import 'package:eon_asset_scanner/core/providers.dart';
import 'package:eon_asset_scanner/widgets/item_info_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class HomeScreen extends ConsumerWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Eon Asset Scanner'),
        actions: [
          PopupMenuButton<String>(
            itemBuilder: (context) => <PopupMenuEntry<String>>[
              PopupMenuItem(
                child: const Text('Log Out'),
                onTap: () {
                  //
                },
              ),
            ],
          ),
        ],
      ),
      body: Center(
        child: ref.watch(itemProvider) == null ? Container() : ItemInfo(item: ref.watch(itemProvider)!),
      ),
      floatingActionButton: FloatingActionButton(
          child: const Icon(Icons.qr_code),
          onPressed: () {
            Navigator.pushNamed(context, 'scan');
          }),
    );
  }
}
