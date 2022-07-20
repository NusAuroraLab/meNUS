import 'package:flutter/material.dart';

import '../utils/colors.dart';

class SmallText extends StatelessWidget {
  final Color? color;
  final String text;
  TextOverflow overflow;
  double size;
  double height;
  int maxLine;
  SmallText(
      {Key? key,
      this.maxLine = 999,
      this.color = AppColors.paraColor,
      required this.text,
      this.size = 12,
      this.height = 1.2,
      this.overflow = TextOverflow.clip})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      maxLines: maxLine,
      textWidthBasis: TextWidthBasis.parent,
      style: TextStyle(
        height: height,
        fontFamily: 'Roboto',
        color: color,
        fontSize: size,
        fontWeight: FontWeight.w400,
        overflow: overflow,
      ),
    );
  }
}
