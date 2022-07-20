import 'package:flutter/material.dart';
import 'package:menus/screens/main_screen.dart';
import 'package:provider/provider.dart';
import '../providers/cart.dart';
import '../providers/orders.dart';
import '../utils/app_dimensions.dart';
import '../utils/colors.dart';
import '../widgets/app_cart_item.dart';
import 'account_screen.dart';

class CartScreen extends StatelessWidget {
  static const routeName = '/cart';

  @override
  Widget build(BuildContext context) {
    final cart = Provider.of<Cart>(context);
    return Scaffold(
      bottomNavigationBar: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          IconButton(
            icon: Icon(Icons.home),
            color: AppColors.accentColor,
            iconSize: Dimensions.width30 * 1.2,
            onPressed: () {
              Navigator.pushNamedAndRemoveUntil(
                  context, MainScreen.routeName, (r) => false);
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
        title: Text('Your Cart'),
        backgroundColor: AppColors.primaryColor,
        flexibleSpace: Container(
          color: AppColors.primaryColor,
          margin: EdgeInsets.only(top: Dimensions.height30 * 1.2),
          padding: EdgeInsets.only(
              left: Dimensions.width20, right: Dimensions.width20),
        ),
      ),
      body: Column(
        children: [
          Card(
            margin: EdgeInsets.all(15),
            child: Padding(
              padding: EdgeInsets.all(8),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Total',
                    style: TextStyle(fontSize: Dimensions.font22 * 1.2),
                  ),
                  Spacer(),
                  Chip(
                    label: Text(
                      '\$${cart.totalAmount.toStringAsFixed(2)}',
                      style: TextStyle(
                        color: AppColors.accentColor,
                        fontSize: Dimensions.font20,
                      ),
                    ),
                    backgroundColor: AppColors.primaryColor,
                  ),
                  OrderButton(cart: cart)
                ],
              ),
            ),
          ),
          SizedBox(height: 10),
          Expanded(
            child: ListView.builder(
                itemCount: cart.items.length,
                itemBuilder: (ctx, i) => AppCartItem(
                      cart.items.values.toList()[i].id,
                      cart.items.values.toList()[i].price,
                      cart.items.values.toList()[i].quantity,
                      cart.items.values.toList()[i].title,
                      cart.items.values.toList()[i].url,
                    )),
          )
        ],
      ),
    );
  }
}

class OrderButton extends StatefulWidget {
  const OrderButton({
    Key? key,
    required this.cart,
  }) : super(key: key);

  final Cart cart;

  @override
  _OrderButtonState createState() => _OrderButtonState();
}

class _OrderButtonState extends State<OrderButton> {
  var _isLoading = false;

  @override
  Widget build(BuildContext context) {
    return TextButton(
      child: _isLoading
          ? CircularProgressIndicator()
          : Text('ORDER NOW',
              style: TextStyle(
                  color: AppColors.accentColor, fontSize: Dimensions.font22)),
      onPressed: (widget.cart.totalAmount <= 0 || _isLoading)
          ? null
          : () async {
              setState(() {
                ScaffoldMessenger.of(context).hideCurrentSnackBar();
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text(
                      'You have ordered successfully!',
                    ),
                    duration: Duration(seconds: 2),
                    action: SnackBarAction(
                      label: 'Okay',
                      onPressed: () {},
                    ),
                  ),
                );

                _isLoading = true;
              });
              await Provider.of<Orders>(context, listen: false).addOrder(
                widget.cart.items.values.toList(),
                widget.cart.totalAmount,
              );
              setState(() {
                _isLoading = false;
              });
              widget.cart.clear();
            },
    );
  }
}
