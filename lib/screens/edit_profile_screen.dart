import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import '../utils/app_dimensions.dart';
import '../utils/colors.dart';
import '../widgets/account_widgets.dart';

class EditProfileScreen extends StatefulWidget {
  static const routeName = '/edit-profile';

  @override
  State<EditProfileScreen> createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends State<EditProfileScreen> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
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
                  backgroundImage: NetworkImage(''),
                ),
                Positioned(
                  bottom: 20,
                  right: 20,
                  child: GestureDetector(
                    onTap: () {},
                    child: ClipOval(
                      child: Container(
                        padding: EdgeInsets.all(2),
                        color: Colors.white,
                        child: ClipOval(
                          child: Container(
                            padding: EdgeInsets.all(4),
                            color: AppColors.primaryColor,
                            child: Icon(
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
                    AccountWidgets('',
                        icon: Icons.email,
                        backgroundColor: AppColors.primaryColor),
                  ],
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
