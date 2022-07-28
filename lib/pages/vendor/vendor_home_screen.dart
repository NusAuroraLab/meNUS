import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:menus/utils/colors.dart';
import 'package:provider/provider.dart';
import '../../utils/app_dimensions.dart';
import './orders_page.dart';
import './menu_page.dart';
import './vendor_profile.dart';
import './info_page.dart';
import '../../providers/canteens.dart';
import '../../providers/stalls.dart';

class VendorHomeScreen extends StatefulWidget {
  static const routeName = '/vendor';
  const VendorHomeScreen({Key? key}) : super(key: key);

  @override
  State<VendorHomeScreen> createState() => _VendorHomeScreenState();
}

class _VendorHomeScreenState extends State<VendorHomeScreen> {
  int currIndex = 1;

  var _isInit = true;
  var _isLoading = true;
  @override
  void initState() {
    super.initState();
  }

  @override
  void didChangeDependencies() {
    if (_isInit) {
      setState(() {
        _isLoading = true;
      });
      Provider.of<Stalls>(context)
          .fetchAndSetStalls(Canteens.canteens[0].id)
          .then((_) {
        setState(() {
          _isLoading = false;
        });
      });
    }
    _isInit = false;
    super.didChangeDependencies();
  }

  String title = 'Your Stall';

  @override
  Widget build(BuildContext context) {
    final stallsData = Provider.of<Stalls>(context).stalls;
    final screens = [
      OrdersPage(),
      VendorMenuPage(
        canteen: Canteens.canteens[0],
        stall: stallsData[0],
      ),
      ProfilePage()
    ];

    return _isLoading
        ? CircularProgressIndicator()
        : Scaffold(
            appBar: AppBar(
              automaticallyImplyLeading: false,
              title: Row(
                children: [
                  Expanded(child: Text(title)),
                  Container(
                    width: Dimensions.width15 * 3,
                    height: Dimensions.height45,
                    child: Icon(
                      Icons.chat_bubble_outline_rounded,
                      color: Colors.white,
                      size: Dimensions.height30,
                    ),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(Dimensions.radius15),
                    ),
                  ),
                ],
              ),
              // flexibleSpace: Row(
              //   children: [
              //     Text(title),
              //     Container(
              //                 width: Dimensions.width45,
              //                 height: Dimensions.height45,
              //                 child: Icon(
              //                   Icons.search,
              //                   color: Colors.white,
              //                   size: Dimensions.iconSize24,
              //                 ),
              //                 decoration: BoxDecoration(
              //                   borderRadius:
              //                       BorderRadius.circular(Dimensions.radius15),
              //                 ),
              //               ),
              //   ],
              // ),
              centerTitle: false,
              backgroundColor: AppColors.primaryColor,
            ),
            body: screens[currIndex],
            bottomNavigationBar: BottomNavigationBar(
              type: BottomNavigationBarType.shifting,
              currentIndex: currIndex,
              onTap: (index) => setState(() {
                currIndex = index;
              }),
              items: [
                BottomNavigationBarItem(
                  icon: Icon(Icons.list),
                  label: 'Orders',
                  backgroundColor: AppColors.primaryColor,
                ),
                BottomNavigationBarItem(
                  icon: Icon(Icons.menu_book),
                  label: 'Menu',
                  backgroundColor: AppColors.accentColor,
                ),
                BottomNavigationBarItem(
                  icon: Icon(Icons.store),
                  label: 'Profile',
                  backgroundColor: Colors.lightBlueAccent,
                ),
              ],
            ),
          );
  }
}
