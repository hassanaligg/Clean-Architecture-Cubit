import "package:flutter/material.dart";

import '../resources/theme/app_gradients.dart';

class CustomButton extends StatefulWidget {
  CustomButton({
    super.key,
    required this.width,
    this.height = 50,
    this.withGradient = false,
    this.color,
    this.onTap,
    this.active = true,
    required this.child,
    this.raduis = 8,
    this.decoration,
  });

  double width;
  double height;
  bool withGradient;
  Color? color;
  bool active;
  final void Function()? onTap;
  Widget child;
  double raduis;
  Decoration? decoration;

  @override
  State<CustomButton> createState() => _CustomButtonState();
}

class _CustomButtonState extends State<CustomButton>
    with SingleTickerProviderStateMixin {
  late double _scale;
  late AnimationController _controller;

  @override
  void initState() {
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(
        milliseconds: 100,
      ),
      lowerBound: 0.0,
      upperBound: 0.05,
    )..addListener(() {
        setState(() {});
      });
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
    _controller.dispose();
  }

  void _onTapDown(TapDownDetails details) {
    _controller.forward();
  }

  void _onTapUp(TapUpDetails details) {
    _controller.reverse();
  }

  @override
  Widget build(BuildContext context) {
    _scale = 1 - _controller.value;
    return GestureDetector(
        onTapDown: widget.active ? _onTapDown : null,
        onTapUp: widget.active ? _onTapUp : null,
        child: Transform.scale(
          scale: _scale,
          child: InkWell(
            onTap: widget.active ? widget.onTap : null,
            splashColor: Colors.transparent,
            focusColor: Colors.transparent,
            highlightColor: Colors.transparent,
            child: Container(
              width: widget.width + 2,
              height: widget.height + 2,
              decoration: widget.decoration,
              child: Stack(
                children: [
                  Container(
                    width: widget.width,
                    height: widget.height,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(widget.raduis),
                        gradient: widget.withGradient
                            ? AppGradients.continerGradient
                            : null,
                        color: widget.color),
                    child: widget.child,
                  ),
                  !widget.active
                      ? Container(
                          width: widget.width,
                          height: widget.height,
                          decoration: BoxDecoration(
                              borderRadius:
                                  BorderRadius.circular(widget.raduis),
                              color: Colors.white.withOpacity(0.4)),
                        )
                      : Container(),
                ],
              ),
            ),
          ),
        ));
  }
}
