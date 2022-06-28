import 'package:flutter/material.dart';
import 'package:menus/widgets/small_text.dart';
import '../utils/app_dimensions.dart';
import '../utils/colors.dart';
import 'big_text.dart';
import 'icon_text_widget.dart';

class AppColumn extends StatelessWidget {
  final double price;
  final String text;
  final double iconSize;
  final double textSize;
  const AppColumn(
      {Key? key,
      required this.price,
      required this.text,
      this.iconSize = 18,
      required this.textSize})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        BigText(color: Colors.black, text: text, size: textSize),
        SizedBox(
          height: Dimensions.height10,
        ),
        Row(
          children: [
            Wrap(
              children: List.generate(5, (index) {
                return Icon(Icons.star,
                    color: AppColors.primaryColor, size: iconSize);
              }),
            ),
            SizedBox(width: Dimensions.width10),
            SmallText(text: "4.5"),
            SizedBox(width: Dimensions.width10),
            SmallText(text: "price"),
            SizedBox(
              width: Dimensions.width10,
            ),
            SmallText(text: '\$${price.toStringAsFixed(2)}'),
          ],
        ),
      ],
    );
  }
}
