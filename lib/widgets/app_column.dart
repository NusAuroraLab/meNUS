import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:menus/widgets/small_text.dart';
import '../utils/app_dimensions.dart';
import '../utils/colors.dart';
import 'big_text.dart';
import 'icon_text_widget.dart';

class AppColumn extends StatelessWidget {
  final double price;
  final double? rating;
  final String text;
  final double iconSize;
  final double textSize;
  final double smallTextSize;
  const AppColumn(
      {Key? key,
      required this.price,
      this.rating,
      required this.text,
      this.iconSize = 18,
      required this.textSize,
      this.smallTextSize = 12})
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
            RatingBarIndicator(
              rating: this.rating ?? 0,
              itemBuilder: (context, index) => Icon(
                Icons.star,
                color: AppColors.primaryColor,
              ),
              itemCount: 5,
              itemSize: iconSize * 1.25,
              direction: Axis.horizontal,
            ),
            SizedBox(width: Dimensions.width10),
            SmallText(
                text: rating == null ? 'N/A' : rating!.toStringAsFixed(1),
                size: this.smallTextSize),
            SizedBox(width: Dimensions.width10),
            SmallText(
              text: "Price",
              size: this.smallTextSize,
            ),
            SizedBox(
              width: Dimensions.width10,
            ),
            SmallText(
              text: '\$${price.toStringAsFixed(2)}',
              size: this.smallTextSize,
            ),
          ],
        ),
      ],
    );
  }
}
