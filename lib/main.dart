import 'package:flutter/material.dart';
import 'package:menus/models/canteen.dart';
import 'package:menus/screens/account_screen.dart';
import 'package:menus/screens/food_detail_screen.dart';
import 'package:menus/screens/main_screen.dart';
import 'package:provider/provider.dart';
import './providers/orders.dart';
import './providers/auth.dart';
import 'helper/custom_route.dart';
import 'providers/cart.dart';
import 'providers/foods.dart';
import 'providers/stalls.dart';
import 'screens/cart_screen.dart';
import 'screens/food_form.dart';
import 'screens/orders_screen.dart';
import 'screens/sign_in_screen.dart';
import 'screens/sign_up_screen.dart';
import 'screens/splash_screen.dart';
import 'screens/stall_form.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider.value(
          value: Auth(),
        ),
        ChangeNotifierProvider<Stalls>.value(
          value: Stalls(),
        ),
        ChangeNotifierProvider<Foods>.value(
          value: Foods(),
        ),
        ChangeNotifierProvider<Cart>.value(
          value: Cart(),
        ),
        ChangeNotifierProxyProvider<Auth, Orders>(
          update: (ctx, auth, previousOrders) => Orders(
            auth.token ?? '',
            auth.userId,
            previousOrders == null ? [] : previousOrders.orders,
          ),
        ),
      ],
      child: Consumer<Auth>(
        builder: (ctx, auth, _) => MaterialApp(
          title: 'MyShop',
          theme: ThemeData(
            fontFamily: 'Lato',
            pageTransitionsTheme: PageTransitionsTheme(
              builders: {
                TargetPlatform.android: CustomPageTransitionBuilder(),
                TargetPlatform.iOS: CustomPageTransitionBuilder(),
              },
            ),
          ),
          debugShowCheckedModeBanner: false,
          home: auth.isAuth
              ? MainScreen()
              : FutureBuilder(
                  future: auth.tryAutoLogin(),
                  builder: (ctx, authResultSnapshot) =>
                      authResultSnapshot.connectionState ==
                              ConnectionState.waiting
                          ? SplashScreen()
                          : SignInScreen(),
                ),
          routes: {
            SignUpScreen.routeName: (ctx) => SignUpScreen(),
            SignInScreen.routeName: (ctx) => SignInScreen(),
            MainScreen.routeName: (ctx) => MainScreen(),
            AccountScreen.routeName: (ctx) => AccountScreen(),
            FoodDetailScreen.routeName: (ctx) => FoodDetailScreen(),
            CartScreen.routeName: (ctx) => CartScreen(),
            OrdersScreen.routeName: (ctx) => OrdersScreen(),
            // UserProductsScreen.routeName: (ctx) => UserProductsScreen(),
            FoodForm.routeName: (ctx) => FoodForm(),
            StallForm.routeName: (ctx) => StallForm(),
          },
        ),
      ),
    );
  }
}
