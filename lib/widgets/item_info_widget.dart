import 'package:eon_asset_scanner/core/utils.dart';
import 'package:flutter/material.dart';

import '../models/item_model.dart';

class ItemInfo extends StatelessWidget {
  const ItemInfo({super.key, required this.item});

  final Item item;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: 13,
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
              title: Text(priceToString(item.price)),
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
            if (item.description == null || item.description!.isEmpty) return Container();

            return Padding(
              padding: const EdgeInsets.all(10),
              child: TextFormField(
                minLines: null,
                maxLines: null,
                expands: false,
                initialValue: item.description ?? '',
                readOnly: true,
                decoration: const InputDecoration(
                  labelText: 'Item Description',
                  floatingLabelBehavior: FloatingLabelBehavior.always,
                  labelStyle: TextStyle(color: Colors.white),
                ),
              ),
            );

          case 11:
            if (item.remarks == null || item.remarks!.isEmpty) return Container();

            return Padding(
              padding: const EdgeInsets.all(10),
              child: TextFormField(
                minLines: null,
                maxLines: null,
                expands: false,
                initialValue: item.remarks ?? '',
                readOnly: true,
                decoration: const InputDecoration(
                  labelText: 'Remarks',
                  floatingLabelBehavior: FloatingLabelBehavior.always,
                  labelStyle: TextStyle(color: Colors.white),
                ),
              ),
            );
          default:
            return const SizedBox(
              height: 75,
            );
        }
      },
    );
  }
}
