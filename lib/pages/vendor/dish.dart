import 'package:flutter/material.dart';

import '../../utils/app_dimensions.dart';
import '../../utils/colors.dart';

class Dish extends StatefulWidget {
  DishInfo dishInfo;
  Dish({Key? key, required this.dishInfo}) : super(key: key);

  @override
  State<Dish> createState() => _DishState();
}

class DishInfo {
  String name;
  String description;
  String price;
  String picURL;
  bool soldOut;

  DishInfo(
    this.name,
    this.description,
    this.price,
    this.soldOut,
    this.picURL,
  );
}

class _DishState extends State<Dish> {
  @override
  bool soldOut = false;

  Widget build(BuildContext context) {
    DishInfo dish = widget.dishInfo;
    return Container(
      color: soldOut ? Color(0xffcccccc) : Colors.white,
      margin: EdgeInsets.only(
          left: Dimensions.width20,
          right: Dimensions.width20,
          bottom: Dimensions.height10),
      child: Row(
        children: [
          Container(
            width: Dimensions.listViewImg,
            height: Dimensions.listViewImg,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(Dimensions.radius20),
              color: Colors.white38,
              image: DecorationImage(
                fit: BoxFit.cover,
                image: NetworkImage(dish.picURL),
              ),
            ),
          ),
          Expanded(
            child: Container(
              height: 100,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.only(
                  topRight: Radius.circular(Dimensions.radius20),
                  bottomRight: Radius.circular(Dimensions.radius20),
                ),
              ),
              child: Padding(
                padding: EdgeInsets.only(
                    left: Dimensions.width10, right: Dimensions.width10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      dish.name,
                      style: TextStyle(
                          fontSize: 18,
                          fontWeight:
                              soldOut ? FontWeight.normal : FontWeight.bold),
                    ),
                    SizedBox(height: Dimensions.width10),
                    Text(
                      dish.description,
                      style: TextStyle(fontSize: 12),
                    ),
                    SizedBox(height: Dimensions.width10),
                    Text(
                      dish.price,
                      style: TextStyle(
                          color: AppColors.primaryColor,
                          fontWeight: FontWeight.bold,
                          fontSize: 20),
                    )
                  ],
                ),
              ),
            ),
          ),
          Switch(
            value: soldOut,
            onChanged: (value) {
              setState(() {
                soldOut = value;
                print(soldOut);
              });
            },
            activeTrackColor: Colors.grey,
            activeColor: Colors.blueGrey,
          ),
        ],
      ),
    );
  }
}
