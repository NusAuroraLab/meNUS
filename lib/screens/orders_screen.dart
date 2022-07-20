import 'package:flutter/material.dart';
import 'package:menus/screens/food_detail_screen.dart';
import 'package:provider/provider.dart';
import '../providers/orders.dart' show Orders;
import '../utils/app_dimensions.dart';
import '../utils/colors.dart';
import '../widgets/app_order_item.dart';
import 'account_screen.dart';
import 'cart_screen.dart';
import 'main_screen.dart';

class OrdersScreen extends StatelessWidget {
  static const routeName = '/orders';

  @override
  Widget build(BuildContext context) {
    // final orderData = Provider.of<Orders>(context);
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
      appBar: AppBar(
        title: Text('Order History'),
        backgroundColor: AppColors.primaryColor,
        flexibleSpace: Container(
          color: AppColors.primaryColor,
          margin: EdgeInsets.only(top: Dimensions.height30 * 1.2),
          padding: EdgeInsets.only(
              left: Dimensions.width20, right: Dimensions.width20),
        ),
      ),
      body: FutureBuilder(
        future: Provider.of<Orders>(context, listen: false).fetchAndSetOrders(),
        builder: (ctx, dataSnapshot) {
          if (dataSnapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else {
            if (dataSnapshot.hasError) {
              // ...
              // Do error handling stuff
              return Center(
                child: Text('An Error Occurred!'),
              );
            } else {
              return Consumer<Orders>(
                builder: (ctx, orderData, child) => ListView.builder(
                    itemCount: orderData.orders.length,
                    itemBuilder: (ctx, i) => AppOrderItem(orderData.orders[i])),
              );
            }
          }
        },
      ),
    );
  }
}
