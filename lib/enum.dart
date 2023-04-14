part of 'flutter_hyperpay.dart';

/// This enum is used to store the result of a Payment operation. It can be either 'sync', 'success', 'error' or 'noResult'.
enum PaymentResult { sync, success, error, noResult }

/// PaymentMode is an enumeration which can take on the values of either 'live' or 'test' and is used to indicate which payment mode is used.
enum PaymentMode { live, test }
