// ignore_for_file: depend_on_referenced_packages, prefer_interpolation_to_compose_strings

import 'package:intl/intl.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:meta/meta_meta.dart';

import '../../../app/core/services/logger_service.dart';

@Target({TargetKind.classType})
class CustomDateTimeConverter implements JsonConverter<DateTime, String> {
  CustomDateTimeConverter();

  @override
  DateTime fromJson(String? str) {
    String tmp = DateTime.now().toIso8601String();
    tmp = tmp.substring(0, tmp.indexOf("."));

    log("Convirtiendo fecha: $str");

    if (str == null || str == '') return DateTime.parse(tmp);

    //valid for "1985-11-18";
    if (RegExp(
      CustomDateTime.regRegExp2,
      caseSensitive: false,
      multiLine: false,
    ).hasMatch(str)) {
      DateFormat df = DateFormat("yyyy-MM-dd");
      log("Convirtiendo fecha=$str con patrón:'yyyy-MM-dd'");
      final date = df.parse(str);
      log("Se ha convertido a:${date.toString()}");
      return date;
    }

    //valid for "Tue Sep 13 19:51:02 UTC 2022";
    if (RegExp(
      CustomDateTime.regRegExp1,
      caseSensitive: false,
      multiLine: false,
    ).hasMatch(str)) {
      DateFormat df = DateFormat("EEE MMM d hh:mm:ss yyyy", 'en_US');
      log("Convirtiendo fecha=${str.replaceAll("UTC", "")} con patrón:'EEE MMM d hh:mm:ss yyyy'");
      final date = df.parse(str.replaceAll("UTC ", ""));
      log("Se ha convertido a:${date.toString()}");
      return date;
    }

    //valid for "2022-01-01 09:40" (YYYY-MM-DD hh:mm:ss.mmmmmm);
    if (RegExp(
      r"^[0-9]{4}-[0-9]{2}-[0-9]{2} [0-9]{2}:[0-9]{2}:[0-9]{2}.[0-9]{1,6}",
      caseSensitive: false,
      multiLine: false,
    ).hasMatch(str)) {
      return DateTime.parse(str);
    }
    //valid for "2022-01-01 09:40" (YYYY-MM-DD hh:mm);
    else if (RegExp(
      r"^[0-9]{4}-[0-9]{2}-[0-9]{2}-[0-9]{2}:[0-9]{2}",
      caseSensitive: false,
      multiLine: false,
    ).hasMatch(str)) {
      str = str.substring(0, 10);
      return DateTime.parse(str);
    }
    //valid for "04-08-1987-04:00" (DD-MM-YYYY-min-seg);
    else if (RegExp(
      r"^[0-9]{2}-[0-9]{2}-[0-9]{4}-[0-9]{2}:[0-9]{2}",
      caseSensitive: false,
      multiLine: false,
    ).hasMatch(str)) {
      str = str.substring(0, 10);
      return DateTime.parse(str);
    }
    //valid for "29-08-1987 04:00" (DD-MM-YYYY min-seg);
    else if (RegExp(
      r"^[0-9]{2}/[0-9]{2}/[0-9]{4} [0-9]{2}:[0-9]{2}",
      caseSensitive: false,
      multiLine: false,
    ).hasMatch(str)) {
      str = str.substring(0, 10);
      return DateTime.parse(str);
    } else if (RegExp(
      r"^[0-9]{2}/[0-9]{2}/[0-9]{4}",
      caseSensitive: false,
      multiLine: false,
    ).hasMatch(str)) {
      str = str.replaceAll("/", "-") + " 00:00:00";
      return DateFormat('dd-MM-yyyy').parse(str);
    } else if (RegExp(
      r"^[0-9]{2}-[0-9]{2}-[0-9]{4}",
      caseSensitive: false,
      multiLine: false,
    ).hasMatch(str)) {
      //str = str.replaceAll("/", "-") + " 00:00:00";
      return DateFormat('dd-MM-yyyy').parse(str);
    }
    return DateTime.parse(str);
  }

  DateTime toDMYUntilSecound(String? str) => DateFormat('dd-MM-yyyy HH:mm')
      .parse(CustomDateTimeConverter().fromJson(str).toIso8601String());

  @override
  String toJson(DateTime time) => time.toIso8601String();

  static DateTime from(String? str) => CustomDateTimeConverter().fromJson(str);

  static DateTime toDMY(String? str) => DateFormat('dd-MM-yyyy HH:mm')
      .parse(CustomDateTimeConverter().fromJson(str).toIso8601String());
}

extension CustomDateTime on DateTime {
  static Map<String, int> get getDaysByMonths {
    final year = DateTime.now().year;
    return {
      "Jan": 31,
      "Feb": year % 4 == 0 ? 29 : 28,
      "Mar": 31,
      "Apr": 30,
      "May": 31,
      "Jun": 30,
      "Jul": 30,
      "Aug": 31,
      "Sep": 30,
      "Oct": 31,
      "Nov": 30,
      "Dec": 31,
    };
  }

  static Map<String, String> get getDaysOfWeek {
    return {
      "Mon": "Monday",
      "Tue": "Tuesday",
      "Wed": "Wednesday",
      "Thu": "Thursday",
      "Fri": "Friday",
      "Sat": "Saturday",
      "Sun": "Sunday",
    };
  }

  static Map<String, String> get getMonths {
    return {
      "Jan": "January",
      "Feb": "February",
      "Mar": "March",
      "Apr": "April",
      "May": "May",
      "Jun": "June",
      "Jul": "July",
      "Aug": "August",
      "Sep": "September",
      "Oct": "October",
      "Nov": "November",
      "Dec": "December",
    };
  }

  static List<String> get getZones => ["UTC", "GMT"];

  //valid for "Tue Sep 13 19:51:02 UTC 2022";
  static String get regRegExp1 {
    final days = "(${getDaysOfWeek.keys.join("|")})";
    final months = "(${getMonths.keys.join("|")})";
    final daysOfMonths =
        "(${List.generate(31, (int index) => index).map((e) => e < 10 ? "0$e" : e.toString()).toList().join("|")})";
    final hrsOfDay =
        "(${List.generate(24, (int index) => index).map((e) => e < 10 ? "0$e" : e.toString()).toList().join("|")})";
    final mmss =
        "(${List.generate(60, (int index) => index).map((e) => e < 10 ? "0$e" : e.toString()).toList().join("|")})";
    final zones = "(${getZones.join("|")})";
    return "$days $months $daysOfMonths $hrsOfDay:$mmss:$mmss $zones [0-9]{4}";
  }

  static String get regRegExp2 {
    return "[0-9]{4}-[0-9]{2}-[0-9]{2}";
  }
}
