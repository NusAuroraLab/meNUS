import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:menus/pages/vendor/info_page.dart';
import 'package:menus/screens/account_edit_screen.dart';
import 'package:menus/screens/cart_screen.dart';
import 'package:menus/screens/orders_screen.dart';
import 'package:menus/screens/sign_in_screen.dart';
import 'package:provider/provider.dart';
import '../providers/auth.dart';
import '../providers/profiles.dart';
import '../utils/app_dimensions.dart';
import '../utils/colors.dart';
import '../widgets/account_widgets.dart';
import 'main_screen.dart';

class AccountScreen extends StatefulWidget {
  static const routeName = '/account';
  const AccountScreen({Key? key}) : super(key: key);

  @override
  State<AccountScreen> createState() => _AccountScreenState();
}

class _AccountScreenState extends State<AccountScreen> {
  _getFromGallery(String userId) async {
    final ImagePicker _picker = ImagePicker();
    final XFile? pickedFile = await _picker.pickImage(
      source: ImageSource.gallery,
      maxWidth: 1800,
      maxHeight: 1800,
    );
    if (pickedFile != null) {
      File imageFile = File(pickedFile.path);
      Provider.of<Profile>(context, listen: false).upload(imageFile, userId);
    }
  }

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
        actions: [
          TextButton(
            child: Text(
              'Edit',
              style: TextStyle(
                  fontSize: Dimensions.font22,
                  color: Color.fromARGB(200, 255, 255, 255)),
            ),
            onPressed: () {
              Navigator.of(context)
                  .pushReplacementNamed(AccountEditScreen.routeName);
            },
          )
        ],
      ),
      body: FutureBuilder(
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
                                hint: 'User Name',
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
      ),
    );
  }
}
