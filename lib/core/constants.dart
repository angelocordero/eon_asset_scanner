// ignore_for_file: constant_identifier_names

import 'package:flutter/material.dart';
import 'package:mysql_client/mysql_client.dart';

BorderRadius defaultBorderRadius = BorderRadius.circular(8);

Future<MySQLConnection> createSqlConn() async {
  try {
    return await MySQLConnection.createConnection(
      host: '192.168.61.17',
      port: 3306,
      userName: 'jekoy',
      password: 'jekoyp@\$\$w0rd',
      databaseName: 'eon',
      secure: true,
    );
  } catch (e, st) {
    return Future.error(e, st);
  }
}
