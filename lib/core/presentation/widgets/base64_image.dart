import 'package:flutter/material.dart';
import 'dart:convert';

class Base64ImageWidget extends StatelessWidget {
  const Base64ImageWidget({Key? key, required this.image}) : super(key: key);
  final String image;

  @override
  Widget build(BuildContext context) {
    return getImageBase64(image);
  }
}

Widget getImageBase64(String image) {
  var imageBase64 = image;
  const Base64Codec base64 = Base64Codec();
  if (imageBase64 == null) return Container();
  var bytes = base64.decode(imageBase64);
  return Image.memory(
    bytes,
    fit: BoxFit.cover,
  );
}
