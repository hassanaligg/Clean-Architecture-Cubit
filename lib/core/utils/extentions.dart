import 'package:dawaa24/core/data/enums/order_list_status_enum.dart';
import 'package:dawaa24/core/data/enums/order_list_type_enum.dart';
import 'package:dawaa24/core/utils/parse_helpers/failure_parser.dart';
import 'package:dawaa24/core/utils/parse_helpers/field_failure_parser/field_failure_parser.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

import '../../di/injection.dart';
import '../../features/auth/presentation/cubits/authentication/authentication_cubit.dart';

import '../data/enums/payment_method_enum.dart';
import '../presentation/blocs/theme_bloc/theme_bloc.dart';
import 'failures/base_failure.dart';
import 'failures/field_failure/field_failure.dart';

extension ContextMethods on BuildContext {
  /// Parse General Failure To String Message
  String failureParser(Failure failure) =>
      FailureParser.mapFailureToString(failure: failure, context: this);

  /// Parse Field Failure To String Message or Return null if failure null
  String? fieldFailureParser(FieldFailure? failure) => failure == null
      ? null
      : FieldFailureParser.mapFieldFailureToErrorMessage(
          failure: failure,
        );

  ThemeData get theme => Theme.of(this);

  TextTheme get textTheme => Theme.of(this).textTheme;

  bool get isDark => getIt<ThemeBloc>().isDark;

  bool get isAuth => getIt<AuthenticationCubit>().getAuthState();

  bool get isArabic => locale.languageCode == 'ar';

  bool get isTablet => MediaQuery.of(this).size.width > 768;
}

extension DoubleMethods on double {
  double roundTo2DigitsAfterDecimalPoint() => double.parse(toStringAsFixed(2));
}

extension FromMillisecondsSinceEpoch on int {
  String fromMillisecondsSinceEpochGetDate(String local) {
    DateTime temp =
        DateTime.fromMillisecondsSinceEpoch(this * 1000, isUtc: false);
    return temp.formatDateOnlyWithLocal(local);
  }

  String fromMillisecondsSinceEpochGetDateWithHour(String local) {
    DateTime temp =
        DateTime.fromMillisecondsSinceEpoch(this * 1000, isUtc: false);
    return temp.monthDayYear(local);
  }

  String toReadableDate() {
    var dateTime = DateTime.fromMillisecondsSinceEpoch(this, isUtc: false);
    if (dateTime.year < 2024) {
       dateTime =
          DateTime.fromMillisecondsSinceEpoch(this * 1000, isUtc: false);

    } else {
      dateTime = DateTime.fromMillisecondsSinceEpoch(this, isUtc: false);

    }
    final formatter = DateFormat('yyyy-MM-dd HH:mm:ss');
    return formatter.format(dateTime);
  }
}

extension StringMethods on String {
  bool get isValidEmail => contains(RegExp(
      r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$'));
}

extension PhoneNumberFormatter on String {
  String formatPhone() {
    String digitsOnly = replaceAll(RegExp(r'\D'), '');

    if (digitsOnly.length >= 10) {
      String country = digitsOnly.substring(0, 3);
      String area = digitsOnly.substring(3, 5);
      String firstPart = digitsOnly.substring(5, 9);
      String secondPart = digitsOnly.substring(9, digitsOnly.length);

      return '($country) $area-$firstPart-$secondPart';
    } else {
      return this;
    }
  }
}

extension HexColor on Color {
  static Color fromHex(String hexString) {
    final buffer = StringBuffer();
    if (hexString.length == 6 || hexString.length == 7) buffer.write('ff');
    buffer.write(hexString.replaceFirst('#', ''));
    return Color(int.parse(buffer.toString(), radix: 16));
  }

  /// Prefixes a hash sign if [leadingHashSign] is set to `true` (default is `true`).
  String toHex({bool leadingHashSign = true}) => '${leadingHashSign ? '#' : ''}'
      '${alpha.toRadixString(16).padLeft(2, '0')}'
      '${red.toRadixString(16).padLeft(2, '0')}'
      '${green.toRadixString(16).padLeft(2, '0')}'
      '${blue.toRadixString(16).padLeft(2, '0')}';
}

extension ShowToast on String {
  void showToast({ToastGravity toastGravity = ToastGravity.BOTTOM}) {
    Fluttertoast.showToast(
      msg: this,
      toastLength: Toast.LENGTH_SHORT,
      gravity: toastGravity,
      timeInSecForIosWeb: 3,
      backgroundColor: Colors.black,
      textColor: Colors.white,
      fontSize: 16.0,
    );
  }

  String convertArabicIndicToArabicNumerals() {
    const arabicIndicDigits = '٠١٢٣٤٥٦٧٨٩';
    const arabicDigits = '0123456789';
    String result = this;
    for (int i = 0; i < arabicIndicDigits.length; i++) {
      result = result.replaceAll(arabicIndicDigits[i], arabicDigits[i]);
    }
    return result;
  }
}

extension StringToDate on String {
  DateTime setTime(String time) {
    DateTime dateTime = DateTime.parse(time);
    return dateTime;
  }

  String getDateWithMonthNameDayNameAndYear(String local) {
    DateTime dateTime = DateTime.tryParse(this)!;
    return DateFormat("EEEE, dd MMMM", local).format(dateTime);
  }
}

extension FormatTimeFromSeconds on int {
  String formatTimeFromSecondsToMinSec() {
    int minutes = this ~/ 60;
    int remainingSeconds = this % 60;

    String formattedMinutes = minutes.toString().padLeft(2, '0');
    String formattedSeconds = remainingSeconds.toString().padLeft(2, '0');

    return '$formattedMinutes:$formattedSeconds';
  }
}

extension Date on DateTime {
  String getDayName({String? locale}) {
    return DateFormat('EEEE', locale).format(this);
  }

  String getMonthName({String? locale}) {
    return DateFormat('MMMM', locale).format(this);
  }

  String getDateWithMonthNameDayNameAndYear(String local) {
    return DateFormat("EEEE, dd MMMM", local).format(this);
  }

  String format() {
    return DateFormat("yyyy-MM-dd HH:mm").format(this);
  }

  String formatDateOnlyWithLocal(String local) {
    return DateFormat("dd MMM yyyy", local).format(this);
  }

  String getHour() {
    return DateFormat("K:mm a").format(this);
  }

  String getDateWithDayMonthName() {
    return DateFormat("EEE, d MMM").format(this);
  }

  String getTime(BuildContext context) {
    return DateFormat("jm",context.isArabic?"ar":"en").format(this);
  }

  String getTime24() {
    return DateFormat("HH:mm").format(this);
  }

  String monthDayYear(String local) {
    return DateFormat("dd MMM yyyy-hh:mm a", local).format(this);
  }

  String normalFormat() {
    return DateFormat("dd/MM/yyyy", "en").format(this);
  }

  String dateWithSeconds(String? language, [String? format]) {
    var formatter = DateFormat(format ?? 'h:mm a', language);
    return formatter.format(this).toString();
  }
}

extension DurationEx on Duration {
  String toMinuteWithSeconds() {
    int seconds = inSeconds;
    int minutes = seconds ~/ 60;
    String ret = minutes < 10 ? '0$minutes' : '$minutes';
    ret += ':';
    seconds -= minutes * 60;
    ret += seconds < 10 ? '0$seconds' : '$seconds';
    return ret;
  }
}

extension OrderListStatusEnumString on OrderListStatusEnum {
  String getName() {
    {
      switch (this) {
        case OrderListStatusEnum.pending:
          return "my_orders.Pending".tr();
        case OrderListStatusEnum.outForDelivery:
          return "my_orders.Out For Delivery".tr();
        case OrderListStatusEnum.readyForPickup:
          return "my_orders.Ready For Pickup".tr();
        case OrderListStatusEnum.delivered:
          return "my_orders.Delivered".tr();
        case OrderListStatusEnum.returned:
          return "my_orders.Returned".tr();
        case OrderListStatusEnum.cancelled:
          return "my_orders.Cancelled".tr();
        case OrderListStatusEnum.unKnown:
          return "my_orders.unKnown".tr();
        default:
          return "";
      }
    }
  }

  Color getStatusColor() {
    switch (this) {
      case OrderListStatusEnum.pending:
        return const Color.fromRGBO(226, 127, 39, 1);
      case OrderListStatusEnum.outForDelivery:
        return const Color.fromRGBO(143, 92, 171, 1);
      case OrderListStatusEnum.readyForPickup:
        return const Color.fromRGBO(110, 132, 223, 1);
      case OrderListStatusEnum.delivered:
        return const Color.fromRGBO(38, 208, 189, 1);
      case OrderListStatusEnum.returned:
        return const Color.fromRGBO(234, 39, 39, 1);
      case OrderListStatusEnum.cancelled:
        return const Color.fromRGBO(234, 39, 39, 1);
      case OrderListStatusEnum.unKnown:
        return Colors.grey;
      default:
        return Colors.grey;
    }
  }
}

extension OrderLisTypeEnumString on OrderLisTypeEnum {
  String getName() {
    {
      switch (this) {
        case OrderLisTypeEnum.delivery:
          return "my_orders.delivery".tr();
        case OrderLisTypeEnum.pickUp:
          return "my_orders.pickUp".tr();
        case OrderLisTypeEnum.unKnown:
          return "my_orders.unKnown".tr();
        default:
          return "";
      }
    }
  }

  Color getStatusColor() {
    switch (this) {
      case OrderLisTypeEnum.pickUp:
        return const Color.fromRGBO(230, 236, 238, 1);
      case OrderLisTypeEnum.delivery:
        return const Color.fromRGBO(230, 236, 238, 1);
      case OrderLisTypeEnum.unKnown:
        return Colors.grey;
      default:
        return Colors.grey;
    }
  }
}

extension PaymentTypeEnumString on PaymentStatusEnum {
  String getName() {
    {
      switch (this) {
        case PaymentStatusEnum.cash:
          return "order.cash".tr();
        case PaymentStatusEnum.creditCard:
          return "order.creditCard".tr();
        case PaymentStatusEnum.unKnown:
          return "order.unKnown".tr();
        default:
          return "";
      }
    }
  }
}

extension Formatter on String {
  String formatHoursLocale() {
    var formatter = DateFormat('h:mm a', 'en');
    List<String> time = split(':');
    int h = int.parse(time[0]);
    if (time[2][3] == 'P') {
      if (h != 12) {
        h = h + 12;
      }
    } else {
      h = h % 12;
    }
    String finalHour = '';
    if (h <= 9) {
      finalHour = '0$h';
    } else {
      finalHour = h.toString();
    }
    DateTime temp = DateTime.parse(
        '2012-02-27 $finalHour:${time[1]}:${time[2].substring(0, 2)}');
    return formatter.format(temp);
  }
}

extension InverseKeyValue on Map {
  Map<K, V> inverse<K, V>() {
    return map((k, v) => MapEntry(v, k));
  }
}
