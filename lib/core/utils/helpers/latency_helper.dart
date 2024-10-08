import 'dart:async';

import 'package:flutter/material.dart';

class LatencyHelper {
  final int seconds;
  late VoidCallback action;
  Timer? _timer;

  LatencyHelper({required this.seconds});

  run(VoidCallback action) {
    if (_timer != null) {
      _timer!.cancel();
    }
    _timer = Timer(Duration(seconds: seconds), action);
  }
}
