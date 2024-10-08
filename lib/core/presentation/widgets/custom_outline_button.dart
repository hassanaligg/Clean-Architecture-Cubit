import 'package:flutter/cupertino.dart';
import "package:flutter/material.dart";



class CustomOutlineButton extends StatefulWidget {
   CustomOutlineButton({Key? key
    ,required this.width,
    this.height = 50,
    this.onTap,
    this.active = true,
    required this.child}) : super(key: key);

  double width;
  double height;
  bool active;
  final void Function()? onTap;
  Widget child;
  @override
  State<CustomOutlineButton> createState() => _CustomOutlineButtonState();
}

class _CustomOutlineButtonState extends State<CustomOutlineButton> with SingleTickerProviderStateMixin {
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
    )
      ..addListener(() {
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
        onTapDown:widget.active? _onTapDown:null,
        onTapUp:widget.active? _onTapUp:null,
        child: Transform.scale(
          scale: _scale,
          child: InkWell(
            onTap: widget.onTap,
            child: Container(
              width: widget.width+2,
              height: widget.height+2,
              child: Stack(
                children: [


                  Container(
                    width: widget.width,
                    height: widget.height,
                    child: OutlinedButton(onPressed: widget.onTap, child: widget.child),
                  ),
                  !widget.active?Container(
                    width: widget.width,
                    height: widget.height,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8),
                        color: Colors.white.withOpacity(0.4)),
                  ):Container(),
                ],
              ),
            )
            ,
          )
          ,
        ));
  }
}