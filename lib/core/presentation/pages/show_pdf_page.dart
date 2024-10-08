import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_pdfview/flutter_pdfview.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';

import '../../domain/params/show_pdf_params.dart';

class ShowPdfPage extends StatelessWidget {
  final ShowPdfParams pdfParams;

  ShowPdfPage({required this.pdfParams});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          PDFView(
            filePath: pdfParams.file,
          ),
          PositionedDirectional(
            bottom: 10.h,
            end: 20.w,
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 10.h),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(12.r),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.3),
                    spreadRadius: 2,
                    blurRadius: 5,
                    offset: const Offset(0, 3), // changes position of shadow
                  ),
                ],
              ),
              child: Column(
                children: [
                  InkWell(
                    splashColor: Colors.transparent,
                    focusColor: Colors.transparent,
                    highlightColor: Colors.transparent,
                    onTap: () => context.pop(false),
                    child: Padding(
                      padding:  EdgeInsets.symmetric(horizontal: 10.w,vertical: 10.h),
                      child: Row(
                        children: [
                          const Icon(Icons.close, color: Colors.black),
                          Text(
                            'chat.cancel'.tr(),
                            style: const TextStyle(color: Colors.black),
                          ),
                          SizedBox(
                            width: 10.w,
                          )
                        ],
                      ),
                    ),
                  ),
                  if (!pdfParams.isNetwork) ...[
                    InkWell(
                      splashColor: Colors.transparent,
                      focusColor: Colors.transparent,
                      highlightColor: Colors.transparent,
                      onTap: () => context.pop(true),
                      child: Padding(
                        padding:  EdgeInsets.symmetric(horizontal: 10.w,vertical: 10.h),
                        child: Row(
                          children: [
                            const Icon(
                              Icons.send,
                              color: Colors.black,
                            ),
                            Text(
                              'chat.send'.tr(),
                              style: const TextStyle(color: Colors.black),
                            ),
                            SizedBox(
                              width: 10.w,
                            )
                          ],
                        ),
                      ),
                    )
                  ]
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
