import 'package:eon_asset_scanner/core/utils.dart';
import 'package:mysql_client/mysql_client.dart';

import '../models/item_model.dart';
import '../models/user_model.dart';

class DatabaseAPI {
  DatabaseAPI();

  static Future<User?> authenticateUser(String username, String passwordHash) async {
    MySQLConnection? conn;

    try {
      conn = await createSqlConn();

      await conn.connect();

      IResultSet result = await conn.execute('SELECT * FROM `users` WHERE `username`= :username and `password_hash`= :password', {
        "username": username,
        "password": passwordHash,
      });

      if (result.isNotEmpty) {
        ResultSetRow row = result.rows.first;

        return User(
          userID: row.colAt(0) ?? '',
          username: row.colAt(1) ?? '',
          isAdmin: row.typedColAt<int>(2) == 1 ? true : false,
        );
      } else {
        return null;
      }
    } catch (e, st) {
      showErrorAndStacktrace(e, st);
    } finally {
      await conn?.close();
    }
    return null;
  }

  static Future<Item?> getItem(String assetID) async {
    MySQLConnection? conn;

    try {
      conn = await createSqlConn();

      await conn.connect();

      IResultSet result = await conn.execute(''' 
        SELECT a.*, c.category_name, d.department_name  FROM `assets` AS a
        JOIN `categories` AS c ON a.category_id = c.category_id
        JOIN `departments` AS d ON a.department_id = d.department_id
        WHERE a.asset_id = :assetID
        AND c.is_enabled = 1
        AND d.is_enabled = 1;''', {
        "assetID": assetID,
      });

      if (result.rows.isEmpty) {
        return await Future.error('No result');
      }

      ResultSetRow row = result.rows.first;

      Item item = Item(
        assetID: row.colByName('asset_id').toString(),
        department: row.colByName('department_name').toString(),
        personAccountable: row.colByName('person_accountable').toString(),
        name: row.colByName('item_name').toString(),
        description: row.colByName('item_description').toString(),
        unit: row.colByName('unit').toString(),
        price: double.tryParse(row.colByName('price') ?? ''),
        datePurchased: DateTime.tryParse(row.colByName('date_purchased') ?? ''),
        dateReceived: DateTime.parse(row.colByName('date_received') ?? ''),
        status: row.colByName('status').toString(),
        category: row.colByName('category_name').toString(),
        remarks: row.colByName('remarks').toString(),
      );

      return item;
    } catch (e) {
      return await Future.error(e);
    } finally {
      await conn?.close();
    }
  }
}
