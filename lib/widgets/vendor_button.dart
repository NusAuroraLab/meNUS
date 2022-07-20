import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';

import '../pages/vendor/vendor_home_screen.dart';
import '../utils/colors.dart';

class VendorButton extends StatelessWidget {
  const VendorButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Material(
      //width: Dimensions.screenWidth * 0.7,
      color: AppColors.primaryColor,
      elevation: 5,
      borderRadius: BorderRadius.circular(30),
      child: MaterialButton(
        padding: EdgeInsets.fromLTRB(20, 15, 20, 15),
        minWidth: MediaQuery.of(context).size.width,
        onPressed: () {
          Navigator.of(context).pushNamed(VendorHomeScreen.routeName);
        },
        child: Text("Or register as a vendor",
            textAlign: TextAlign.center,
            style: TextStyle(
                fontSize: 20,
                color: Colors.white,
                fontWeight: FontWeight.bold)),
      ),
    );
  }
}
