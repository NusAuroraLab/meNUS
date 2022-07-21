import 'package:flutter/material.dart';
import 'package:menus/models/canteen.dart';
import 'package:menus/pages/vendor/vendor_home_screen.dart';
import 'package:menus/screens/account_edit_screen.dart';
import 'package:menus/screens/account_screen.dart';
import 'package:menus/screens/food_detail_screen.dart';
import 'package:menus/screens/comment_screen.dart';
import 'package:menus/screens/main_screen.dart';
import 'package:menus/screens/comment_form.dart';
import 'package:menus/screens/map_screen.dart';
import 'package:provider/provider.dart';
import './providers/orders.dart';
import './providers/auth.dart';
import 'helpers/custom_route.dart';
import 'providers/cart.dart';
import 'providers/foods.dart';
import 'providers/profiles.dart';
import 'providers/comments.dart';
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
        ChangeNotifierProvider<Comments>(
          create: (ctx) => Comments(),
        ),
        ChangeNotifierProvider<Auth>(
          create: (ctx) => Auth(),
        ),
        ChangeNotifierProvider<Stalls>(
          create: (ctx) => Stalls(),
        ),
        ChangeNotifierProvider<Foods>(
          create: (ctx) => Foods(),
        ),
        ChangeNotifierProvider<Cart>(
          create: (ctx) => Cart(),
        ),
        ChangeNotifierProvider<Profile>(
          create: (ctx) => Profile(),
        ),
        ChangeNotifierProxyProvider<Auth, Orders>(
          create: null, //To avoid warning
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
            FoodForm.routeName: (ctx) => FoodForm(),
            StallForm.routeName: (ctx) => StallForm(),
            CommentForm.routeName: (ctx) => CommentForm(),
            VendorHomeScreen.routeName: (ctx) => VendorHomeScreen(),
            CommentScreen.routeName: (ctx) => CommentScreen(),
            MapScreen.routeName: (ctx) => MapScreen(),
            AccountEditScreen.routeName: (ctx) => AccountEditScreen(),
          },
        ),
      ),
    );
  }
}
