import 'dart:convert';

import 'package:crypto/crypto.dart';
import 'package:intl/intl.dart';

String hashPassword(String input) {
  return sha1.convert(utf8.encode(input)).toString();
}

String dateToString(DateTime dateTime) {
  return '${DateFormat.EEEE().format(dateTime)} ${DateFormat.yMMMd().format(dateTime)}';
}
