import 'package:flutter/material.dart';
import 'package:menus/screens/food_detail_screen.dart';
import 'package:menus/utils/app_dimensions.dart';
import 'package:provider/provider.dart';
import '../providers/cart.dart';
import '../providers/foods.dart';

class AppCartItem extends StatelessWidget {
  final List<String> id;
  final double price;
  final int quantity;
  final String title;
  final String url;

  AppCartItem(
    this.id,
    this.price,
    this.quantity,
    this.title,
    this.url,
  );

  @override
  Widget build(BuildContext context) {
    return Dismissible(
      key: ValueKey(id[2]),
      background: Container(
        color: Theme.of(context).errorColor,
        child: Icon(
          Icons.delete,
          color: Colors.white,
          size: 40,
        ),
        alignment: Alignment.centerRight,
        padding: EdgeInsets.only(right: 20),
        margin: EdgeInsets.symmetric(
          horizontal: 15,
          vertical: 4,
        ),
      ),
      direction: DismissDirection.endToStart,
      confirmDismiss: (direction) {
        return showDialog(
          context: context,
          builder: (ctx) => AlertDialog(
            title: Text('Are you sure?'),
            content: Text(
              'Do you want to remove the item from the cart?',
            ),
            actions: [
              TextButton(
                child: Text('No'),
                onPressed: () {
                  Navigator.of(ctx).pop(false);
                },
              ),
              TextButton(
                child: Text('Yes'),
                onPressed: () {
                  Navigator.of(ctx).pop(true);
                },
              ),
            ],
          ),
        );
      },
      onDismissed: (direction) {
        Provider.of<Cart>(context, listen: false).removeItem(id[2]);
      },
      child: GestureDetector(
        onTap: () async {
          await Provider.of<Foods>(context, listen: false)
              .fetchAndSetFoods(id[0], id[1])
              .then((_) => Navigator.of(context)
                  .pushNamed(FoodDetailScreen.routeName, arguments: id));
        },
        child: Card(
          margin: EdgeInsets.symmetric(
            horizontal: 15,
            vertical: 4,
          ),
          child: Padding(
            padding: EdgeInsets.all(8),
            child: ListTile(
              leading: CircleAvatar(
                backgroundColor: Colors.white,
                child: ClipRRect(
                  borderRadius:
                      BorderRadius.circular(Dimensions.BORDER_RADIUS_15),
                  child: Image(
                    image: NetworkImage(url),
                  ),
                ),
              ),
              title: Text(title),
              subtitle:
                  Text('Total: \$${(price * quantity).toStringAsFixed(2)}'),
              trailing: Text('$quantity x'),
            ),
          ),
        ),
      ),
    );
  }
}
