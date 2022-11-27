import 'package:dartx/dartx.dart';
import 'package:intl/intl.dart';
import 'package:timezone/data/latest.dart' as tz;
import 'package:timezone/timezone.dart' as tz;

import '../../shared.dart';

class DateTimeUtils {
  DateTimeUtils._();

  static int daysBetween(DateTime from, DateTime to) {
    from = DateTime(from.year, from.month, from.day);
    to = DateTime(to.year, to.month, to.day);

    return (to.difference(from).inHours / 24).round();
  }

  static int timezoneOffset() {
    return DateTime.now().timeZoneOffset.inHours;
  }

  static DateTime toLocalFromTimestamp({required int utcTimestampMillis}) {
    return DateTime.fromMillisecondsSinceEpoch(utcTimestampMillis, isUtc: true).toLocal();
  }

  static DateTime toUtcFromTimestamp(int localTimestampMillis) {
    return DateTime.fromMillisecondsSinceEpoch(localTimestampMillis, isUtc: false).toUtc();
  }

  static DateTime startTimeOfDate() {
    final now = DateTime.now();

    return DateTime(
      now.year,
      now.month,
      now.day,
    );
  }

  static DateTime? toDateTime(String dateTimeString, {bool isUtc = false}) {
    final dateTime = DateTime.tryParse(dateTimeString);
    if (dateTime != null) {
      if (isUtc) {
        return DateTime.utc(
          dateTime.year,
          dateTime.month,
          dateTime.day,
          dateTime.hour,
          dateTime.minute,
          dateTime.second,
          dateTime.millisecond,
          dateTime.microsecond,
        );
      }

      return dateTime;
    }

    return null;
  }

  static DateTime? toNormalizeDateTime(String dateTimeString, {bool isUtc = false}) {
    final dateTime = DateTime.tryParse('-123450101 $dateTimeString');
    if (dateTime != null) {
      if (isUtc) {
        return DateTime.utc(
          dateTime.year,
          dateTime.month,
          dateTime.day,
          dateTime.hour,
          dateTime.minute,
          dateTime.second,
          dateTime.millisecond,
          dateTime.microsecond,
        );
      }

      return dateTime;
    }

    return null;
  }

  static DateTime? tryParse({
    String? date,
    String? format,
    String locale = LocaleConstants.defaultLocale,
  }) {
    if (date == null) {
      return null;
    }

    if (format == null) {
      return DateTime.tryParse(date);
    }

    final DateFormat dateFormat = DateFormat(format, locale);
    try {
      return dateFormat.parse(date);
    } catch (e) {
      return null;
    }
  }
}

extension DateTimeExtensions on DateTime {
  String toStringWithFormat(String format) {
    return DateFormat(format).format(this);
  }

  DateTime get lastDateOfMonth {
    return DateTime(year, month + 1, 0);
  }
}

extension DateTimeTimezoneExtension on DateTime {
  Map<String, tz.Location> get getTimeZoneDatabase {
    tz.initializeTimeZones();

    return tz.timeZoneDatabase.locations;
  }

  int _getESTtoUTCDifference(String locationName) {
    tz.initializeTimeZones();
    final locationNY = tz.getLocation(locationName);
    final tz.TZDateTime nowNY = tz.TZDateTime.now(locationNY);

    return nowNY.timeZoneOffset.inHours;
  }

  DateTime toESTzone(String locationName) {
    DateTime result = toUtc(); // local time to UTC
    result =
        result.add(Duration(hours: _getESTtoUTCDifference(locationName))); // convert UTC to EST

    return result;
  }

  DateTime fromESTzone(String locationName) {
    DateTime result =
        subtract(Duration(hours: _getESTtoUTCDifference(locationName))); // convert EST to UTC

    String dateTimeAsIso8601String = result.toIso8601String();
    dateTimeAsIso8601String +=
        dateTimeAsIso8601String.characters.last.equalsIgnoreCase('Z') ? '' : 'Z';
    result = DateTime.parse(dateTimeAsIso8601String); // make isUtc to be true

    result = result.toLocal(); // convert UTC to local time

    return result;
  }
}
