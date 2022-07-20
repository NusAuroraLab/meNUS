import 'dart:math';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:menus/utils/app_dimensions.dart';
import 'package:provider/provider.dart';
import '../providers/foods.dart';
import '../providers/orders.dart';
import '../screens/food_detail_screen.dart';

class AppOrderItem extends StatefulWidget {
  final OrderItem order;

  AppOrderItem(this.order);

  @override
  _AppOrderItem createState() => _AppOrderItem();
}

class _AppOrderItem extends State<AppOrderItem> {
  var _expanded = false;

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: Duration(milliseconds: 300),
      height: _expanded
          ? min(widget.order.items.length * 26 + Dimensions.height20 * 6,
              Dimensions.height20 * 12)
          : Dimensions.height20 * 6,
      child: Card(
        margin: EdgeInsets.all(10),
        child: Column(
          children: <Widget>[
            ListTile(
              title: Text('\$${widget.order.amount.toStringAsFixed(2)}'),
              subtitle: Text(
                DateFormat('dd/MM/yyyy hh:mm').format(widget.order.dateTime),
              ),
              trailing: IconButton(
                icon: Icon(_expanded ? Icons.expand_less : Icons.expand_more),
                onPressed: () {
                  setState(() {
                    _expanded = !_expanded;
                  });
                },
              ),
            ),
            AnimatedContainer(
              duration: Duration(milliseconds: 300),
              padding: EdgeInsets.symmetric(
                  horizontal: Dimensions.width15,
                  vertical: Dimensions.height10),
              height: _expanded
                  ? min(widget.order.items.length * 13 + Dimensions.height20,
                      Dimensions.height10 * 10)
                  : 0,
              child: ListView(
                children: widget.order.items
                    .map(
                      (food) => GestureDetector(
                        onTap: () async {
                          Foods foods =
                              Provider.of<Foods>(context, listen: false);
                          await foods
                              .fetchAndSetFoods(food.id[0], food.id[1])
                              .then(
                                foods.findById(food.id[2]) == null
                                    ? (_) {
                                        ScaffoldMessenger.of(context)
                                            .hideCurrentSnackBar();
                                        ScaffoldMessenger.of(context)
                                            .showSnackBar(
                                          SnackBar(
                                            content: Text(
                                              'The item does not exist!',
                                            ),
                                            duration: Duration(seconds: 2),
                                            action: SnackBarAction(
                                              label: 'Okay',
                                              onPressed: () {},
                                            ),
                                          ),
                                        );
                                      }
                                    : (_) => Navigator.of(context).pushNamed(
                                        FoodDetailScreen.routeName,
                                        arguments: food.id),
                              );
                        },
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Container(
                              width: Dimensions.width30 * 10,
                              child: Text(
                                food.title,
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                                style: TextStyle(
                                  fontSize: Dimensions.font20,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                            Text(
                              '${food.quantity}x \$${food.price}',
                              style: TextStyle(
                                fontSize: Dimensions.font20,
                                color: Colors.grey,
                              ),
                            )
                          ],
                        ),
                      ),
                    )
                    .toList(),
              ),
            )
          ],
        ),
      ),
    );
  }
}
