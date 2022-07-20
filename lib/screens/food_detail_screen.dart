import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:menus/models/comment.dart';
import 'package:menus/providers/comments.dart';
import 'package:menus/screens/cart_screen.dart';
import 'package:menus/screens/comment_screen.dart';
import 'package:menus/widgets/expandable_text_widget.dart';
import 'package:menus/widgets/small_text.dart';
import 'package:provider/provider.dart';
import '../../utils/colors.dart';
import '../../widgets/app_column.dart';
import '../../widgets/app_icon.dart';
import '../../widgets/big_text.dart';
import '../models/food.dart';
import '../providers/cart.dart';
import '../providers/foods.dart';
import '../utils/app_dimensions.dart';

class FoodDetailScreen extends StatefulWidget {
  static const routeName = '/food-detail';

  @override
  State<FoodDetailScreen> createState() => _FoodDetailScreenState();
}

class _FoodDetailScreenState extends State<FoodDetailScreen> {
  int _quantity = 0;
  bool _isInit = true;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    List<String> data =
        ModalRoute.of(context)!.settings.arguments as List<String>;
    Food food = Provider.of<Foods>(context, listen: false).findById(data[2])!;
    final cart = Provider.of<Cart>(context, listen: false);
    return Scaffold(
      backgroundColor: Colors.white,
      body: Stack(children: [
        Positioned(
          left: 0,
          right: 0,
          child: Container(
            width: double.maxFinite,
            height: Dimensions.height45 * 8,
            decoration: BoxDecoration(
              image: DecorationImage(
                fit: BoxFit.cover,
                image: NetworkImage(food.imageUrl),
              ),
            ),
          ),
        ),
        Positioned(
            top: Dimensions.height45,
            left: Dimensions.width20,
            right: Dimensions.width20,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                GestureDetector(
                  onTap: () {
                    Navigator.of(context).pop();
                  },
                  child: AppIcon(
                    icon: Icons.arrow_back_ios,
                    iconColor: AppColors.accentColor,
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    Navigator.of(context).pushNamed(CartScreen.routeName);
                  },
                  child: AppIcon(
                    icon: Icons.shopping_cart_outlined,
                    iconColor: AppColors.accentColor,
                  ),
                ),
              ],
            )),
        Positioned(
            left: 0,
            right: 0,
            bottom: 0,
            top: Dimensions.height45 * 7,
            child: Container(
              padding: EdgeInsets.only(
                  left: Dimensions.width20,
                  right: Dimensions.width20,
                  top: Dimensions.height20),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.only(
                      topRight: Radius.circular(Dimensions.radius20),
                      topLeft: Radius.circular(Dimensions.radius20)),
                  color: Colors.white),
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    FutureBuilder(
                      future: Provider.of<Comments>(context, listen: false)
                          .fetchAndSetComments(data[0], data[1], data[2]),
                      builder: (context, snapshot) {
                        if (snapshot.hasError) {
                          print(snapshot.error);

                          return Text('An Error Occurred');
                        }
                        var list = snapshot.data as List<Comment>;
                        return AppColumn(
                          text: food.title,
                          rating: list == null || list.isEmpty
                              ? null
                              : list
                                      .map((comment) => comment.rating)
                                      .reduce((a, b) => a + b) /
                                  list.length,
                          textSize: Dimensions.font30,
                          smallTextSize: Dimensions.font20,
                          iconSize: Dimensions.width20,
                          price: food.price,
                        );
                      },
                    ),
                    SizedBox(
                      height: Dimensions.height10,
                    ),
                    GestureDetector(
                      onTap: () {
                        Navigator.of(context)
                            .pushNamed(CommentScreen.routeName, arguments: data)
                            .then((_) {
                          setState(() {});
                        });
                      },
                      child: Row(
                        children: [
                          Icon(
                            Icons.comment,
                            size: Dimensions.iconBackSize / 1.75,
                          ),
                          SizedBox(
                            width: Dimensions.width10,
                          ),
                          SmallText(
                            text: 'View Comments',
                            size: Dimensions.font20,
                            color: Colors.black,
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: Dimensions.height20,
                    ),
                    BigText(
                      color: Colors.black,
                      text: "Introduce",
                      size: Dimensions.font26,
                    ),
                    SizedBox(
                      height: Dimensions.height20,
                    ),
                    Expanded(
                      child: SingleChildScrollView(
                        child: ExpandableTextWidget(
                          text: food.description,
                        ),
                      ),
                    )
                  ]),
            )),
      ]),
      bottomNavigationBar: Container(
        height: Dimensions.height45 * 3,
        width: Dimensions.width30,
        padding: EdgeInsets.only(
            top: Dimensions.height30,
            bottom: Dimensions.height30,
            left: Dimensions.width20,
            right: Dimensions.width20),
        decoration: BoxDecoration(
          color: AppColors.buttonBackgroundColor,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(Dimensions.radius20 * 2),
            topRight: Radius.circular(Dimensions.radius20 * 2),
          ),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Container(
              padding: EdgeInsets.only(
                  top: Dimensions.height20,
                  bottom: Dimensions.height20,
                  left: Dimensions.width20,
                  right: Dimensions.width20),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(Dimensions.radius20),
                color: AppColors.primaryColor,
              ),
              child: Row(
                children: [
                  GestureDetector(
                    onTap: () {
                      setState(() {
                        if (_quantity <= 0) {
                          ScaffoldMessenger.of(context).hideCurrentSnackBar();
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text(
                                'Invalid quantity!',
                              ),
                              duration: Duration(seconds: 2),
                              action: SnackBarAction(
                                label: 'Okay',
                                onPressed: () {},
                              ),
                            ),
                          );
                        } else {
                          _quantity -= 1;
                        }
                      });
                    },
                    child: Icon(
                      Icons.remove,
                      color: AppColors.accentColor,
                    ),
                  ),
                  SizedBox(
                    width: Dimensions.width10 / 2,
                  ),
                  BigText(
                    text: _quantity.toString(),
                    color: AppColors.accentColor,
                  ),
                  SizedBox(
                    width: Dimensions.width10 / 2,
                  ),
                  GestureDetector(
                    onTap: () {
                      setState(() {
                        _quantity += 1;
                      });
                    },
                    child: Icon(
                      Icons.add,
                      color: AppColors.accentColor,
                    ),
                  )
                ],
              ),
            ),
            Container(
              padding: EdgeInsets.only(
                  top: Dimensions.height20,
                  bottom: Dimensions.height20,
                  left: Dimensions.width20,
                  right: Dimensions.width20),
              child: GestureDetector(
                onTap: () {
                  cart.addItem(
                    data[0],
                    data[1],
                    food,
                    _quantity,
                  );
                  ScaffoldMessenger.of(context).hideCurrentSnackBar();
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text(
                        'Added item to cart!',
                      ),
                      duration: Duration(seconds: 2),
                      action: SnackBarAction(
                        label: 'UNDO',
                        onPressed: () {
                          cart.removeItem(food.id!);
                        },
                      ),
                    ),
                  );

                  setState(() {
                    _quantity = 0;
                  });
                },
                child: BigText(
                  text:
                      "\$ ${(food.price * _quantity).toStringAsFixed(2)} | Add to cart",
                  color: AppColors.accentColor,
                ),
              ),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(Dimensions.radius20),
                  color: AppColors.primaryColor),
            ),
          ],
        ),
      ),
    );
  }
}
