import 'dart:io';
import 'dart:typed_data';
import 'package:cached_memory_image/cached_memory_image.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:dawaa24/core/utils/extentions.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'dart:convert';
import 'package:flutter_svg/flutter_svg.dart';

import '../resources/assets.gen.dart';

class CustomNetworkImage extends StatefulWidget {
  const CustomNetworkImage(
      {super.key,
      required this.url,
      this.boxFit,
      this.errorIconSize,
      this.borderRadius,
      this.height,
      this.width,
      this.colorFilter,
      this.errorPadding,
      this.backgroundColor,
      this.errorIcon,
      this.errorWidgetIcon,
      this.errorBackgroundColor,
      this.isBase64 = false,
      this.isLoad = false});

  final String? url;
  final String? errorIcon;
  final Widget? errorWidgetIcon;
  final double? errorPadding;
  final BoxFit? boxFit;
  final BorderRadius? borderRadius;
  final double? height;
  final double? width;
  final double? errorIconSize;
  final ColorFilter? colorFilter;
  final bool isBase64;
  final bool isLoad;
  final Color? backgroundColor;
  final Color? errorBackgroundColor;

  @override
  _CustomNetworkImageState createState() => _CustomNetworkImageState();
}

class _CustomNetworkImageState extends State<CustomNetworkImage> {
  Uint8List? _imageData;

  @override
  void initState() {
    super.initState();
    if (widget.isBase64) {
      _imageData = base64Decode(widget.url ?? '');
    }
  }

  @override
  void didUpdateWidget(CustomNetworkImage oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.isBase64 && widget.url != oldWidget.url) {
      setState(() {
        _imageData = base64Decode(widget.url ?? '');
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    if (widget.isBase64 == false && widget.isLoad == false) {
      return CachedNetworkImage(
        imageUrl: widget.url!,
        height: widget.height,
        width: widget.width,
        imageBuilder: (context, imageProvider) => Container(
          decoration: BoxDecoration(
            image: DecorationImage(
              image: imageProvider,
              fit: widget.boxFit ?? BoxFit.cover,
              colorFilter: widget.colorFilter,
            ),
            borderRadius: widget.borderRadius ?? BorderRadius.circular(12.r),
          ),
        ),
        errorWidget: (context, error, stackTrace) {
          return _errorWidget();
        },
        placeholder: (context, loadingProgress) {
          return _loadingIndicator();
        },
        fit: widget.boxFit ?? BoxFit.cover,
      );
    } else if (widget.isLoad) {
      return Container(
        height: widget.height,
        width: widget.width,
        decoration: BoxDecoration(
          image: DecorationImage(
            image: FileImage(File(widget.url!)),
            fit: widget.boxFit ?? BoxFit.cover,
          ),
          borderRadius: widget.borderRadius ?? BorderRadius.circular(12.r),
        ),
      );
    } else {
      return ClipRRect(
        borderRadius: widget.borderRadius ?? BorderRadius.zero,
        child: _imageData == null
            ? _errorWidget()
            : Image.memory(
                _imageData!,
                repeat: ImageRepeat.noRepeat,
                height: widget.height,
                width: widget.width,
                errorBuilder: (context, error, stackTrace) {
                  return _errorWidget();
                },
                fit: widget.boxFit ?? BoxFit.cover,
              ),
      );
    }
  }

  Widget _errorWidget() {
    return Container(
      height: widget.height,
      width: widget.width,
      padding: widget.errorPadding == null
          ? const EdgeInsets.all(0)
          : EdgeInsets.all(widget.errorPadding!),
      decoration: BoxDecoration(
        borderRadius: widget.borderRadius ?? BorderRadius.circular(12.r),
        color: widget.errorBackgroundColor ??
            widget.backgroundColor ??
            Colors.grey.withOpacity(0.3),
      ),
      child: widget.errorIcon != null
          ? SvgPicture.asset(
              widget.errorIcon!,
            )
          : widget.errorWidgetIcon ??
              Center(
                child: Icon(
                  Icons.broken_image_outlined,
                  size: widget.errorIconSize,
                ),
              ),
    );
  }

  Widget _loadingIndicator() {
    return SizedBox(
      height: widget.height,
      width: widget.width,
      child: Center(
        child: (Platform.isAndroid)
            ? CircularProgressIndicator(color: context.theme.primaryColor)
            : CupertinoActivityIndicator(color: context.theme.primaryColor),
      ),
    );
  }
}
