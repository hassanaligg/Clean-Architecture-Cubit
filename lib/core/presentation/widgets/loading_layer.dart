import 'package:flutter/material.dart';

import 'loading_banner.dart';

class LoadingLayerWidget extends StatelessWidget {
  const LoadingLayerWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.grey.withAlpha(80),
      child: const LoadingBanner(),
    );
  }
}
