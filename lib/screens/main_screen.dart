import 'package:flutter/material.dart';
import 'package:menus/screens/food_detail_screen.dart';
import 'package:menus/utils/colors.dart';
import 'package:menus/widgets/big_text.dart';
import 'package:menus/widgets/small_text.dart';
import '../models/canteen.dart';
import '../models/food.dart';
import '../models/stall.dart';
import '../utils/app_dimensions.dart';
import '../widgets/canteens_body.dart';
import '../widgets/foods_body.dart';
import '../widgets/stalls_body.dart';
import 'account_screen.dart';
import 'cart_screen.dart';

enum Mode {
  Canteens,
  Stalls,
  Foods,
}

class MainScreen extends StatefulWidget with ChangeNotifier {
  static const routeName = '/main';

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  Mode _mode = Mode.Canteens;
  Canteen? canteen;
  Stall? stall;
  Food? food;
  Function? _prev;
  @override
  void initState() {
    _mode = Mode.Canteens;
    super.initState();
  }

  void _home() {
    setState(() {
      _mode = Mode.Canteens;
      canteen = null;
      stall = null;
      _prev = null;
    });
  }

  void _changeStateToStalls(Canteen selectedCanteen) {
    setState(() {
      _mode = Mode.Stalls;
      canteen = selectedCanteen;
      _prev = _home;
    });
  }

  void _changeStateToFoods(Stall selectedStall) {
    setState(() {
      _mode = Mode.Foods;
      _prev = () => _changeStateToStalls(canteen!);
      stall = selectedStall;
    });
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
              _home();
            },
          ),
          IconButton(
            icon: Icon(Icons.shopping_cart),
            color: AppColors.accentColor,
            iconSize: Dimensions.width30 * 1.2,
            onPressed: () {
              Navigator.of(context).pushNamed(CartScreen.routeName);
            },
          ),
          IconButton(
            icon: Icon(Icons.person),
            color: AppColors.accentColor,
            iconSize: Dimensions.width30 * 1.2,
            onPressed: () {
              Navigator.of(context)
                  .pushReplacementNamed(AccountScreen.routeName);
            },
          ),
        ],
      ),
      body: Column(
        children: [
          Container(
            child: AppBar(
              backgroundColor: AppColors.primaryColor,
              flexibleSpace: Container(
                color: AppColors.primaryColor,
                margin: EdgeInsets.only(top: Dimensions.height30 * 1.2),
                padding: EdgeInsets.only(
                    left: Dimensions.width20, right: Dimensions.width20),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    BigText(
                      text: _mode == Mode.Canteens
                          ? "NUS Canteens"
                          : _mode == Mode.Stalls
                              ? canteen!.name
                              : stall!.name,
                      color: Colors.white,
                      size: Dimensions.font26,
                    ),
                    Row(
                      children: [
                        IconButton(
                            icon: Icon(
                              Icons.arrow_circle_left,
                              color: AppColors.accentColor,
                            ),
                            onPressed: () {
                              _prev == null ? null : _prev!();
                            }),
                        SmallText(
                          text: "Back",
                          color: Colors.white,
                          size: Dimensions.font20,
                        ),
                      ],
                    )
                  ],
                ),
              ),
            ),
          ),
          Expanded(
            child: SingleChildScrollView(
              child: _mode == Mode.Canteens
                  ? CanteensBody(function: _changeStateToStalls)
                  : _mode == Mode.Stalls
                      ? StallsBody(
                          canteen: canteen!, function: _changeStateToFoods)
                      : FoodsBody(canteen: canteen!, stall: stall!),
            ),
          ),
        ],
      ),
    );
  }
}
