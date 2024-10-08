import 'package:flutter/material.dart';

class VerticalText extends StatelessWidget {
  final String? textFirst;
  final String? textSecond;
  final TextStyle? styleFirst;
  final TextStyle? styleSecond;

  const VerticalText({
    Key? key,
    this.textFirst,
    this.textSecond,
    this.styleFirst,
    this.styleSecond,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      //crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(textFirst!, style: styleFirst,),
        const SizedBox(
          height: 3,
        ),
        Text(textSecond!, style: styleSecond),
      ],
    );
  }
}
