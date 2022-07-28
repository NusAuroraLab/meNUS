import 'package:flutter/material.dart';
import 'package:menus/screens/map_screen.dart';
import 'package:menus/utils/colors.dart';
import 'package:menus/widgets/big_text.dart';
import '../../widgets/small_text.dart';
import '../models/canteen.dart';
import '../providers/canteens.dart';
import '../screens/stall_form.dart';
import '../utils/app_dimensions.dart';

class CanteensBody extends StatelessWidget {
  Function function;
  CanteensBody({required this.function, Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    List<Canteen> canteens = Canteens.canteens;
    return ListView.builder(
      physics: NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      itemCount: canteens.length,
      itemBuilder: (context, index) {
        return GestureDetector(
          onTap: () {
            function(canteens[index]);
          },
          child: Container(
            margin: EdgeInsets.only(
                left: Dimensions.width20,
                right: Dimensions.width20,
                bottom: Dimensions.height10),
            child: Row(
              children: [
                Container(
                  width: Dimensions.width30 * 5,
                  height: Dimensions.height45 * 3,
                  decoration: BoxDecoration(
                    color: Colors.white38,
                    image: DecorationImage(
                      image: AssetImage(canteens[index].url),
                      fit: BoxFit.fitWidth,
                    ),
                  ),
                ),
                Expanded(
                  child: Container(
                    height: Dimensions.height45 * 2,
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
                          BigText(
                              color: Colors.black, text: canteens[index].name),
                          SizedBox(height: Dimensions.width10),
                          SmallText(
                            text: canteens[index].address,
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                Column(
                  children: [
                    OutlinedButton(
                        style: OutlinedButton.styleFrom(
                          side: BorderSide(
                            color: AppColors.accentColor,
                          ),
                          // foregroundColor: AppColors.accentColor,
                          backgroundColor: AppColors.primaryColor,
                          elevation: 3,
                        ),
                        child: Text(
                          '  Show\non Map',
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                        onPressed: () {
                          Navigator.of(context).pushNamed(MapScreen.routeName,
                              arguments: canteens[index].location);
                        }),
                    GestureDetector(
                      child: Container(
                        width: 30,
                        height: 30,
                        color: Colors.orange,
                      ),
                      onTap: () {
                        Navigator.of(context).pushNamed(
                          StallForm.routeName,
                          arguments: canteens[index].id,
                        );
                      },
                    ),
                  ],
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
