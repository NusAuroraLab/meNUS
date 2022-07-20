import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:menus/utils/colors.dart';

class ReadRate extends StatefulWidget {
  final Function changeRating;
  const ReadRate(this.changeRating);

  @override
  State<ReadRate> createState() => _ReadRateState();
}

class _ReadRateState extends State<ReadRate> {
  var _ratingController = TextEditingController();
  double _rating = 5;
  @override
  void initState() {
    _ratingController.text = "5.0";
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return RatingBar.builder(
      initialRating: 5,
      minRating: 0,
      direction: Axis.horizontal,
      allowHalfRating: true,
      unratedColor: AppColors.primaryColor.withAlpha(50),
      itemCount: 5,
      itemSize: 50.0,
      itemPadding: EdgeInsets.symmetric(horizontal: 4.0),
      itemBuilder: (context, _) => Icon(
        Icons.star,
        color: AppColors.primaryColor,
      ),
      onRatingUpdate: (rating) {
        setState(() {
          _rating = rating;
          widget.changeRating(rating);
        });
      },
      updateOnDrag: true,
    );
  }
}
