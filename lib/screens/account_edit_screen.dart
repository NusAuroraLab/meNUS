import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:menus/pages/vendor/info_page.dart';
import 'package:menus/screens/account_screen.dart';
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

class AccountEditScreen extends StatefulWidget {
  static const routeName = '/account-edit';
  const AccountEditScreen({Key? key}) : super(key: key);

  @override
  State<AccountEditScreen> createState() => _AccountScreenState();
}

class _AccountScreenState extends State<AccountEditScreen> {
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
    final _form = GlobalKey<FormState>();
    final _nameFocusNode = FocusNode();
    String _name = 'Anonymous';

    Future<void> _saveForm(
        String id, String email, String name, String imageUrl) async {
      final isValid = _form.currentState!.validate();
      if (!isValid) {
        return;
      }

      _form.currentState!.save();

      try {
        await Provider.of<Profile>(
          context,
          listen: false,
        ).updateProfile(id, email, name, imageUrl);
      } catch (error) {
        await showDialog(
          context: context,
          builder: (ctx) => AlertDialog(
            title: Text('An Error Occurred!'),
            content: Text('Something went wrong.'),
            actions: [
              TextButton(
                child: Text('Okay'),
                onPressed: () {},
              )
            ],
          ),
        );
      }
    }

    return FutureBuilder(
      future: Provider.of<Profile>(context, listen: false)
          .fetchAndSetProfile(Provider.of<Auth>(context).userId),
      builder: (ctx, dataSnapshot) {
        if (dataSnapshot.connectionState == ConnectionState.waiting) {
          return Center(child: CircularProgressIndicator());
        } else {
          return Consumer<Profile>(
            builder: (ctx, userData, child) {
              _name = userData.name;

              return Scaffold(
                bottomNavigationBar: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    IconButton(
                      icon: Icon(Icons.home),
                      color: AppColors.accentColor,
                      iconSize: Dimensions.width30 * 1.2,
                      onPressed: () {
                        Navigator.of(context)
                            .pushReplacementNamed(MainScreen.routeName);
                      },
                    ),
                    IconButton(
                      icon: Icon(Icons.shopping_cart),
                      color: AppColors.accentColor,
                      iconSize: Dimensions.width30 * 1.2,
                      onPressed: () {
                        Navigator.of(context)
                            .pushReplacementNamed(CartScreen.routeName);
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
                          'Finish',
                          style: TextStyle(
                              fontSize: Dimensions.font22,
                              color: Color.fromARGB(200, 255, 255, 255)),
                        ),
                        onPressed: () {
                          _saveForm(userData.id, userData.email, _name,
                              userData.imageUrl);
                          Navigator.of(context)
                              .pushReplacementNamed(AccountScreen.routeName);
                        })
                  ],
                ),
                body: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    SizedBox(
                      height: Dimensions.height45,
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
                            bottom: 15,
                            right: 15,
                            child: ClipOval(
                              child: Container(
                                padding: EdgeInsets.all(3),
                                color: Colors.white,
                                child: ClipOval(
                                  child: Container(
                                    color: AppColors.primaryColor,
                                    child: IconButton(
                                      onPressed: () {},
                                      icon: Icon(
                                        Icons.add_a_photo,
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
                    SizedBox(
                      height: Dimensions.height45,
                    ),
                    Padding(
                      padding:
                          EdgeInsets.symmetric(horizontal: Dimensions.width30),
                      child: Form(
                        key: _form,
                        child: TextFormField(
                          initialValue: userData.name,
                          decoration: InputDecoration(labelText: 'User Name'),
                          textInputAction: TextInputAction.next,
                          onFieldSubmitted: (_) {
                            FocusScope.of(context).requestFocus(_nameFocusNode);
                          },
                          validator: (value) {
                            if (value!.isEmpty) {
                              return 'Please provide a value.';
                            }
                            if (value.length > 50) {
                              return 'Max character limit is 50!';
                            }
                            return null;
                          },
                          onChanged: (value) {
                            _name = value;
                          },
                        ),
                      ),
                    ),
                  ],
                ),
              );
            },
          );
        }
      },
    );
  }
}
