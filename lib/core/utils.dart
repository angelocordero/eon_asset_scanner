import 'dart:convert';

import 'package:crypto/crypto.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:intl/intl.dart';

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
