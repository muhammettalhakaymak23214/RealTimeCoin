import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class DateUtilsHelper {
  DateUtilsHelper._();

  static String today(BuildContext context) {
    final locale = Localizations.localeOf(context).toString();
    return DateFormat('EEEE, d MMMM y', locale).format(DateTime.now());
  }
}
