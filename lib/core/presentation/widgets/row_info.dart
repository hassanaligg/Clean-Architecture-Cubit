import 'package:flutter/material.dart';

class RowInfoWidget extends StatelessWidget {
  const RowInfoWidget(
      {Key? key, required this.rowKey, required this.rowValue, this.style})
      : super(key: key);

  final String rowKey;
  final String rowValue;
  final TextStyle? style;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            rowKey,
            style: style,
          ),
          Text(
            '$rowValue AED',
            style: style,
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}


