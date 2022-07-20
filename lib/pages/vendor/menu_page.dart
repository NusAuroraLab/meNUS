import 'package:flutter/material.dart';
import 'package:menus/pages/vendor/dish.dart';
import '../../utils/app_dimensions.dart';
import '../../utils/colors.dart';

class VendorMenuPage extends StatefulWidget {
  const VendorMenuPage({Key? key}) : super(key: key);

  @override
  State<VendorMenuPage> createState() => _VendorMenuPageState();
}

class _VendorMenuPageState extends State<VendorMenuPage> {
  //true for viewing mode, false for editing mode
  bool mode = true;

  Widget dishMapper(DishInfo dish) {
    return Dish(dishInfo: dish);
  }

  // List<DishInfo> dishInfo = [
  //   DishInfo('Burger', 'description', '\$10'),
  //   DishInfo('Steak', 'description', '\$30'),
  //   DishInfo('Pasta', 'description', '\$20')
  // ];

  // var dishes = dishInfo.map(dishMapper);

  @override
  Widget build(BuildContext context) {
    List<DishInfo> dishInfo = [
      DishInfo('Burger', 'Severd with fries', '\$5', false,
          'https://img.freepik.com/free-photo/big-hamburger-with-double-beef-french-fries_252907-8.jpg?w=2000'),
      DishInfo('Chicken Sandwich', 'Severd with fries', '\$5', false,
          'https://hips.hearstapps.com/hmg-prod.s3.amazonaws.com/images/delish-211105-popeyes-chicken-sandwich-001-ab-web-1637207425.jpg'),
      DishInfo('Beef Steak', 'description', '\$10', false,
          'https://media.istockphoto.com/photos/grilled-striploin-steak-picture-id535786572?k=20&m=535786572&s=612x612&w=0&h=WAOuIsIUQB7zVW23C6MX9y5QCyl6KLPL2eYcOcc_Qdk='),
      DishInfo(
          'Spaghetti',
          'description aeaffe aae efaef  gr  stshy wt gqrg eff ',
          '\$8',
          false,
          'https://www.onceuponachef.com/images/2019/09/Spaghetti-and-Meatballs.jpg'),
      DishInfo('金汤肥牛', '酸辣的金汤，鲜美的肥牛', '\$10', false,
          'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRjy1U9DEIgKiaUlPFCArhCIDbTnnJNz39bi76Lxh165UEOGIXOnanZFIsfL2_aTSJEqbA&usqp=CAU'),
      DishInfo('Soup', 'description', '\$5', false,
          'https://upload.wikimedia.org/wikipedia/commons/0/0f/Hungarian_goulash_soup.jpg'),
      DishInfo('Sprite', 'description', '\$2', false,
          'https://cdn.shopify.com/s/files/1/0281/8726/3010/products/sprite_530x@2x.jpg?v=1586271896'),
      DishInfo('Coke Light', 'description', '\$2', false,
          'https://en.coca-colaarabia.com/content/dam/one/me/en/brand-header-mobile/coca-cola-light%20600x900%20.jpg'),
    ];

    List<Widget> dishes = dishInfo.map(dishMapper).toList();

    Widget editButton = Material(
      color: Colors.white60,
      elevation: 5,
      borderRadius: BorderRadius.circular(2),
      child: MaterialButton(
        padding: EdgeInsets.fromLTRB(20, 15, 20, 15),
        minWidth: Dimensions.screenSizeWidth,
        onPressed: () {
          setState(() {
            mode = false;
          });
        },
        child: Text("Edit",
            textAlign: TextAlign.center,
            style: TextStyle(
                fontSize: 20,
                color: AppColors.titleColor,
                fontWeight: FontWeight.bold)),
      ),
    );

    Widget saveButton = Material(
      color: Colors.white60,
      elevation: 5,
      borderRadius: BorderRadius.circular(2),
      child: MaterialButton(
        padding: EdgeInsets.fromLTRB(20, 15, 20, 15),
        minWidth: Dimensions.screenSizeWidth * 0.5,
        onPressed: () {
          setState(() {
            mode = true;
          });
        },
        child: Text("Save",
            textAlign: TextAlign.center,
            style: TextStyle(
                fontSize: 20,
                color: AppColors.titleColor,
                fontWeight: FontWeight.bold)),
      ),
    );

    Widget cancelButton = Material(
      color: Colors.white60,
      elevation: 5,
      borderRadius: BorderRadius.circular(2),
      child: MaterialButton(
        padding: EdgeInsets.fromLTRB(20, 15, 20, 15),
        minWidth: Dimensions.screenSizeWidth * 0.5,
        onPressed: () {
          setState(() {
            mode = true;
          });
        },
        child: Text("Cancel",
            textAlign: TextAlign.center,
            style: TextStyle(
                fontSize: 20,
                color: AppColors.titleColor,
                fontWeight: FontWeight.bold)),
      ),
    );

    Widget addButton = Material(
      color: Colors.white60,
      elevation: 5,
      borderRadius: BorderRadius.circular(2),
      child: MaterialButton(
        padding: EdgeInsets.fromLTRB(20, 15, 20, 15),
        minWidth: Dimensions.screenSizeWidth,
        onPressed: () {
          setState(() {
            mode = true;
          });
        },
        child: Text("Add Item",
            textAlign: TextAlign.center,
            style: TextStyle(
                fontSize: 20,
                color: AppColors.titleColor,
                fontWeight: FontWeight.bold)),
      ),
    );

    return SingleChildScrollView(
        child: mode
            ? Column(
                children: [
                  Container(
                    child: Text(
                      'Sold Out?',
                      textAlign: TextAlign.left,
                    ),
                    padding: EdgeInsets.fromLTRB(
                        Dimensions.screenSizeWidth * 0.7, 10, 0, 10),
                  ),
                  ...dishes,
                  editButton
                ],
              )
            : Column(
                children: [
                  ...dishes,
                  addButton,
                  Row(children: [saveButton, cancelButton])
                ],
              ));
  }
}
