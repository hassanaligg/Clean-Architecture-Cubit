import 'package:dawaa24/core/utils/parse_helpers/parse_helper.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../utils/failures/base_failure.dart';

abstract class MessageHelper {
  static showErrorMessage(Failure failure, BuildContext context) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text(ParseHelper.parseFailureToErrorMessage(failure))));
  }

  static showMessage(String message, BuildContext context) {
    ScaffoldMessenger.of(context)
        .showSnackBar(SnackBar(content: Text(message)));
  }
}
