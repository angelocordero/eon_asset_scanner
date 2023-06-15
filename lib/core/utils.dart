import 'dart:convert';
import 'dart:io';

import 'package:crypto/crypto.dart';
import 'package:eon_asset_scanner/core/constants.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:intl/intl.dart';
import 'package:mysql_client/mysql_client.dart';

String hashPassword(String input) {
  return sha1.convert(utf8.encode(input)).toString();
}

String dateToString(DateTime dateTime) {
  return '${DateFormat.EEEE().format(dateTime)} ${DateFormat.yMMMd().format(dateTime)}';
}

String priceToString(double? price) {
  return price == null ? '' : NumberFormat.currency(symbol: '₱ ', decimalDigits: 2).format(price);
}

void showErrorAndStacktrace(Object e, StackTrace? st) {
  EasyLoading.showError(e.toString());
  debugPrint(e.toString());
  debugPrintStack(label: e.toString(), stackTrace: st);
}

Future<MySQLConnection> createSqlConn() async {
  try {
    return await MySQLConnection.createConnection(
      host: globalConnectionSettings.ip,
      port: globalConnectionSettings.port,
      userName: globalConnectionSettings.username,
      password: globalConnectionSettings.password,
      databaseName: globalConnectionSettings.databaseName,
      secure: Platform.isWindows ? true : false,
    ).timeout(
      const Duration(seconds: 3),
      onTimeout: () async => await Future.error(const SocketException('Can\'t connect to database')),
    );
  } catch (e, st) {
    return await Future.error(e, st);
  }
}
