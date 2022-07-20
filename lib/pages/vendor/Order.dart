import 'dart:ffi';

import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/material.dart';
import 'package:menus/utils/colors.dart';

import '../../utils/app_dimensions.dart';
import '../../widgets/icon_text_widget.dart';

class Order extends StatelessWidget {
  int id;
  List<String> items;
  double total_price;
  String customer;
  String time;
  Function? handleComplete;

  Order({
    Key? key,
    required this.id,
    required this.items,
    required this.total_price,
    required this.customer,
    required this.time,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(10),
      child: Row(
        children: [
          Expanded(
              flex: 6,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Icon(
                        Icons.person,
                        color: AppColors.primaryColor,
                      ),
                      Text(this.customer)
                    ],
                  ),
                  Row(
                    children: [
                      Icon(
                        Icons.access_time_filled,
                        color: Colors.redAccent,
                      ),
                      Text(this.time)
                    ],
                  ),
                  ...items
                      .map((it) => Text(
                            it,
                            textAlign: TextAlign.left,
                            style: TextStyle(
                                fontSize: 18, color: AppColors.titleColor),
                          ))
                      .toList(),
                ],
              )),
          Expanded(
            flex: 4,
            child: Material(
              color: Colors.amber,
              elevation: 5,
              borderRadius: BorderRadius.circular(30),
              child: MaterialButton(
                padding: EdgeInsets.fromLTRB(20, 15, 20, 15),
                minWidth: Dimensions.screenSizeWidth * 0.2,
                onPressed: () {
                  handleComplete!(this.id);
                },
                child: Text("Complete",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        fontSize: 20,
                        color: Colors.white,
                        fontWeight: FontWeight.bold)),
              ),
            ),
          )
        ],
      ),
    );
  }
}
