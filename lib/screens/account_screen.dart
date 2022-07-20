import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:menus/pages/vendor/info_page.dart';
import 'package:menus/screens/cart_screen.dart';
import 'package:menus/screens/edit_profile_screen.dart';
import 'package:menus/screens/orders_screen.dart';
import 'package:menus/screens/sign_in_screen.dart';
import 'package:provider/provider.dart';
import '../providers/auth.dart';
import '../providers/profile.dart';
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
      body: Information(),
    );
  }
}

class Information extends StatelessWidget {
  const Information({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: Provider.of<Profile>(context, listen: false)
          .fetchAndSetProfile(Provider.of<Auth>(context).userId),
      builder: (ctx, dataSnapshot) {
        if (dataSnapshot.connectionState == ConnectionState.waiting) {
          return Center(child: CircularProgressIndicator());
        } else {
          return Consumer<Profile>(
            builder: (ctx, userData, child) => Column(
              children: [
                SizedBox(
                  height: Dimensions.height20,
                ),
                Container(
                  width: 150,
                  height: 150,
                  child: Stack(
                    alignment: Alignment.center,
                    children: [
                      CircleAvatar(
                        radius: 75,
                        backgroundImage: NetworkImage(userData.imageUrl),
                      ),
                      Positioned(
                        bottom: 20,
                        right: 20,
                        child: GestureDetector(
                          onTap: () {
                            Navigator.of(context).pushReplacementNamed(
                                EditProfileScreen.routeName);
                          },
                          child: ClipOval(
                            child: Container(
                              padding: EdgeInsets.all(2),
                              color: Colors.white,
                              child: ClipOval(
                                child: Container(
                                  padding: EdgeInsets.all(4),
                                  color: AppColors.primaryColor,
                                  child: Icon(
                                    Icons.edit,
                                    color: AppColors.accentColor,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
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
                          AccountWidgets(userData.name,
                              icon: Icons.person,
                              backgroundColor: AppColors.yellowColor),
                          SizedBox(
                            height: Dimensions.height20,
                          ),
                          AccountWidgets(userData.email,
                              icon: Icons.email,
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
                                icon: Icons.history,
                                backgroundColor: Colors.redAccent),
                          ),
                          SizedBox(
                            height: Dimensions.height20,
                          ),
                          InkWell(
                            onTap: () {
                              Navigator.pushNamedAndRemoveUntil(
                                  context, '/', (r) => false);
                              Provider.of<Auth>(context, listen: false)
                                  .logout();
                            },
                            child: AccountWidgets("Log out",
                                icon: Icons.logout,
                                backgroundColor: Colors.red),
                          ),
                        ],
                      ),
                    ),
                  ),
                )
              ],
            ),
          );
        }
      },
    );
  }
}
