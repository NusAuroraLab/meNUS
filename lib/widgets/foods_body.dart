import 'package:flutter/material.dart';
import 'package:menus/models/comment.dart';
import 'package:menus/providers/comments.dart';
import 'package:menus/screens/food_detail_screen.dart';
import 'package:menus/widgets/app_column.dart';
import 'package:provider/provider.dart';
import '../../widgets/small_text.dart';
import '../models/canteen.dart';
import '../models/stall.dart';
import '../providers/foods.dart';
import '../utils/app_dimensions.dart';
import 'big_text.dart';

class FoodsBody extends StatefulWidget {
  Canteen canteen;
  Stall stall;
  FoodsBody({
    required this.canteen,
    required this.stall,
  });

  @override
  State<FoodsBody> createState() => _FoodsBodyState();
}

class _FoodsBodyState extends State<FoodsBody> {
  var _isInit = true;
  var _isLoading = false;
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
      Provider.of<Foods>(context, listen: false)
          .fetchAndSetFoods(widget.canteen.id, widget.stall.id!)
          .then((_) {
        setState(() {
          _isLoading = false;
        });
      });
    }
    _isInit = false;
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    final foodsData = Provider.of<Foods>(context).foods;

    return _isLoading
        ? CircularProgressIndicator()
        : ListView.builder(
            physics: NeverScrollableScrollPhysics(),
            shrinkWrap: true,
            itemCount: foodsData.length,
            itemBuilder: (context, index) {
              return Container(
                child: Column(
                  children: [
                    GestureDetector(
                      onTap: () async {
                        await Provider.of<Foods>(context, listen: false)
                            .deleteFood(foodsData[index], widget.canteen.id,
                                widget.stall.id!);
                      },
                      child: Container(
                        color: Colors.orange,
                        width: 30,
                        height: 30,
                      ),
                    ),
                    GestureDetector(
                      onTap: () async {
                        await Provider.of<Foods>(context, listen: false)
                            .fetchAndSetFoods(
                                widget.canteen.id, widget.stall.id!)
                            .then(
                              (_) => Navigator.of(context).pushNamed(
                                FoodDetailScreen.routeName,
                                arguments: [
                                  widget.canteen.id,
                                  widget.stall.id,
                                  foodsData[index].id
                                ],
                              ).then((_) {
                                setState(() {});
                              }),
                            );
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
                                  image:
                                      NetworkImage(foodsData[index].imageUrl),
                                  fit: BoxFit.fitWidth,
                                ),
                              ),
                            ),
                            Expanded(
                              child: Container(
                                height: Dimensions.height30 * 5,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.only(
                                    topRight:
                                        Radius.circular(Dimensions.radius20),
                                    bottomRight:
                                        Radius.circular(Dimensions.radius20),
                                  ),
                                ),
                                child: Padding(
                                  padding: EdgeInsets.only(
                                      left: Dimensions.width10,
                                      right: Dimensions.width10),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      FutureBuilder(
                                          future: Provider.of<Comments>(
                                            context,
                                            listen: false,
                                          ).fetchAndSetComments(
                                              widget.canteen.id,
                                              widget.stall.id!,
                                              foodsData[index].id!),
                                          builder: (context, snapshot) {
                                            List<Comment> list =
                                                snapshot.data as List<Comment>;
                                            if (snapshot.connectionState ==
                                                ConnectionState.waiting) {
                                              return CircularProgressIndicator();
                                            } else if (snapshot.hasError) {
                                              print(snapshot.error);
                                              return Text('An Error Occurred!');
                                            }
                                            return AppColumn(
                                              price: foodsData[index].price,
                                              rating: list.isEmpty
                                                  ? null
                                                  : list
                                                          .map((comment) =>
                                                              comment.rating)
                                                          .reduce(
                                                              (a, b) => a + b) /
                                                      list.length,
                                              text: foodsData[index].title,
                                              iconSize:
                                                  Dimensions.height10 * 1.25,
                                              textSize: Dimensions.font20,
                                            );
                                          }),
                                      SizedBox(height: Dimensions.height10),
                                      SmallText(
                                        text: foodsData[index].description,
                                        overflow: TextOverflow.ellipsis,
                                        maxLine: 2,
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              );
            },
          );
  }
}
