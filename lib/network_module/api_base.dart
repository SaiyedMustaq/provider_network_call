import 'package:flutter/foundation.dart';

class APIBase {
  static String get baseUrl {
    if (kReleaseMode) {
      return 'https://jsonplaceholder.typicode.com';
    } else {
      return 'https://jsonplaceholder.typicode.com';
    }
  }
}
