part of 'flutter_hyperpay.dart';

/// This enum is used to store the result of a Payment operation. It can be either 'sync', 'success', 'error' or 'noResult'.
enum PaymentResult { sync, success, error, noResult }

extension PaymentResultExtension on PaymentResult {
  bool get isSync => this == PaymentResult.sync;

  bool get isSuccess => this == PaymentResult.success;

  bool get isError => this == PaymentResult.error;

  bool get isNoResult => this == PaymentResult.noResult;

  bool get isNotSync => this != PaymentResult.sync;

  bool get isNotSuccess => this != PaymentResult.success;

  bool get isNotError => this != PaymentResult.error;

  bool get isNotNoResult => this != PaymentResult.noResult;
}

/// PaymentMode is an enumeration which can take on the values of either 'live' or 'test' and is used to indicate which payment mode is used.
enum PaymentMode { live, test }

extension PaymentModeExtension on PaymentMode {
  bool get isLive => this == PaymentMode.live;

  bool get isTest => this == PaymentMode.test;

  bool get isNotLive => this != PaymentMode.live;

  bool get isNotTest => this != PaymentMode.test;
}
