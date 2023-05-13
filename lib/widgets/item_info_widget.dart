import 'package:eon_asset_scanner/core/utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../models/item_model.dart';

class ItemInfo extends ConsumerWidget {
  const ItemInfo({super.key, required this.item});

  final Item item;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Padding(
      padding: const EdgeInsets.all(10),
      child: ListView.builder(
        itemCount: 12,
        itemBuilder: (context, index) {
          switch (index) {
            case 0:
              return ListTile(
                title: Text(item.assetID),
                subtitle: const Text('Asset ID'),
              );
            case 1:
              return ListTile(
                title: Text(item.name),
                subtitle: const Text('Item Name'),
              );
            case 2:
              return ListTile(
                title: Text(item.department),
                subtitle: const Text('Department'),
              );
            case 3:
              if (item.personAccountable == null) return Container();

              if (item.personAccountable!.isEmpty) return Container();

              return ListTile(
                title: Text(item.personAccountable ?? ''),
                subtitle: const Text('Person Accountable'),
              );

            case 4:
              return ListTile(
                title: Text(item.category),
                subtitle: const Text('Category'),
              );
            case 5:
              return ListTile(
                title: Text(item.status),
                subtitle: const Text('Status'),
              );
            case 6:
              if (item.unit.isEmpty) return Container();

              return ListTile(
                title: Text(item.unit),
                subtitle: const Text('Unit'),
              );
            case 7:
              if (item.price == null) return Container();

              return ListTile(
                title: Text(item.price?.toStringAsFixed(2) ?? ''),
                subtitle: const Text('Price'),
              );
            case 8:
              if (item.datePurchased == null) Container();

              return ListTile(
                title: Text(dateToString(item.datePurchased ?? DateTime.now())),
                subtitle: const Text('Date Purchased'),
              );
            case 9:
              return ListTile(
                title: Text(dateToString(item.dateReceived)),
                subtitle: const Text('Date Received'),
              );
            case 10:
              if (item.description == null) return Container();

              if (item.description!.isEmpty) return Container();

              return Padding(
                padding: const EdgeInsets.symmetric(vertical: 10),
                child: TextFormField(
                  minLines: 5,
                  maxLines: 10,
                  initialValue: item.description ?? '',
                  enabled: false,
                  decoration: const InputDecoration(
                    disabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.white),
                    ),
                    labelText: 'Item Description',
                    floatingLabelBehavior: FloatingLabelBehavior.always,
                    labelStyle: TextStyle(color: Colors.white),
                  ),
                ),
              );

            case 11:
              if (item.remarks == null) return Container();

              if (item.remarks!.isEmpty) return Container();

              return Padding(
                padding: const EdgeInsets.symmetric(vertical: 10),
                child: TextFormField(
                  minLines: 5,
                  maxLines: 10,
                  initialValue: item.remarks ?? '',
                  enabled: false,
                  decoration: const InputDecoration(
                    disabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.white),
                    ),
                    labelText: 'Remarks',
                    floatingLabelBehavior: FloatingLabelBehavior.always,
                    labelStyle: TextStyle(color: Colors.white),
                  ),
                ),
              );
            default:
              return Container();
          }
        },
      ),
    );
  }
}
