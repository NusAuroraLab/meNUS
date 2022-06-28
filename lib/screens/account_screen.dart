import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:menus/screens/cart_screen.dart';
import 'package:menus/screens/orders_screen.dart';
import 'package:menus/screens/sign_in_screen.dart';
import 'package:provider/provider.dart';
import '../providers/auth.dart';
import '../utils/app_dimensions.dart';
import '../utils/colors.dart';
import '../widgets/account_widgets.dart';
import 'main_screen.dart';

class AccountScreen extends StatelessWidget {
  static const routeName = '/account';
  const AccountScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          IconButton(
            icon: Icon(Icons.home),
            color: AppColors.accentColor,
            iconSize: Dimensions.width30 * 1.2,
            onPressed: () {
              Navigator.of(context).pushReplacementNamed(MainScreen.routeName);
            },
          ),
          IconButton(
            icon: Icon(Icons.shopping_cart),
            color: AppColors.accentColor,
            iconSize: Dimensions.width30 * 1.2,
            onPressed: () {
              Navigator.of(context).pushReplacementNamed(CartScreen.routeName);
            },
          ),
          IconButton(
            icon: Icon(Icons.person),
            color: AppColors.accentColor,
            iconSize: Dimensions.width30 * 1.2,
            onPressed: () {},
          ),
        ],
      ),
      appBar: AppBar(
        title: Text("Profile"),
        backgroundColor: AppColors.primaryColor,
      ),
      body: Container(
        margin: Dimensions.isWeb
            ? EdgeInsets.only(
                left: Dimensions.MARGIN_SIZE_EXTRA_LARGE,
                right: Dimensions.MARGIN_SIZE_EXTRA_LARGE)
            : EdgeInsets.all(0),
        child: Column(
          children: [
            SizedBox(
              height: Dimensions.height20,
            ),
            Container(
              width: 150,
              height: 150,
              child: Icon(
                Icons.person,
                size: 75,
                color: Colors.white,
              ),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(75),
                  color: AppColors.primaryColor),
            ),
            Expanded(
              child: Scrollbar(
                child: SingleChildScrollView(
                  physics: BouncingScrollPhysics(),
                  child: Column(
                    children: [
                      SizedBox(
                        height: Dimensions.height20,
                      ),
                      AccountWidgets('Name',
                          icon: Icons.person,
                          backgroundColor: AppColors.yellowColor),
                      SizedBox(
                        height: Dimensions.height20,
                      ),
                      AccountWidgets('E-Mail',
                          icon: Icons.phone,
                          backgroundColor: AppColors.primaryColor),
                      SizedBox(
                        height: Dimensions.height20,
                      ),
                      InkWell(
                        onTap: () {
                          Navigator.of(context)
                              .pushNamed(OrdersScreen.routeName);
                        },
                        child: AccountWidgets('Order History',
                            icon: Icons.email,
                            backgroundColor: Colors.redAccent),
                      ),
                      SizedBox(
                        height: Dimensions.height20,
                      ),
                      InkWell(
                        onTap: () {
                          Navigator.pushNamedAndRemoveUntil(
                              context, '/', (r) => false);
                          Provider.of<Auth>(context, listen: false).logout();
                        },
                        child: AccountWidgets("Log out",
                            icon: Icons.logout, backgroundColor: Colors.red),
                      ),
                    ],
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
