import 'package:flutter/material.dart';
import 'package:menus/screens/food_form.dart';
import 'package:menus/widgets/big_text.dart';
import 'package:menus/widgets/small_text.dart';
import 'package:provider/provider.dart';
import '../models/canteen.dart';
import '../providers/stalls.dart';
import '../utils/app_dimensions.dart';

class StallsBody extends StatefulWidget {
  Function function;
  Canteen canteen;
  StallsBody({required this.function, required this.canteen, Key? key})
      : super(key: key);

  @override
  State<StallsBody> createState() => _StallsBodyState();
}

class _StallsBodyState extends State<StallsBody> {
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
          .fetchAndSetStalls(widget.canteen.id)
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
    final stallsData = Provider.of<Stalls>(context).stalls;
    return _isLoading
        ? CircularProgressIndicator()
        : ListView.builder(
            physics: NeverScrollableScrollPhysics(),
            shrinkWrap: true,
            itemCount: stallsData.length,
            itemBuilder: (context, index) {
              return GestureDetector(
                onTap: () {
                  widget.function(stallsData[index]);
                },
                child: Container(
                  margin: EdgeInsets.only(
                      left: Dimensions.width20,
                      right: Dimensions.width20,
                      bottom: Dimensions.height10),
                  child: Container(
                    margin: EdgeInsets.only(
                      left: Dimensions.width10,
                      right: Dimensions.width20,
                    ),
                    child: Row(
                      children: [
                        Container(
                          width: Dimensions.width30 * 4,
                          height: Dimensions.height45 * 3,
                          decoration: BoxDecoration(
                            color: Colors.white38,
                            image: DecorationImage(
                              image: NetworkImage(stallsData[index].url),
                              fit: BoxFit.fitWidth,
                            ),
                          ),
                        ),
                        Expanded(
                          child: Container(
                            height: Dimensions.height45 * 3,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.only(
                                topRight: Radius.circular(Dimensions.radius20),
                                bottomRight:
                                    Radius.circular(Dimensions.radius20),
                              ),
                            ),
                            child: Padding(
                              padding: EdgeInsets.only(
                                  left: Dimensions.width10,
                                  right: Dimensions.width10),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  SmallText(
                                    text: stallsData[index].name,
                                    color: Colors.black,
                                    size: Dimensions.font22,
                                  ),
                                  SizedBox(height: Dimensions.height10),
                                ],
                              ),
                            ),
                          ),
                        ),
                        GestureDetector(
                          child: Container(
                            width: Dimensions.width30,
                            height: Dimensions.height30,
                            color: Colors.orange,
                          ),
                          onTap: () {
                            Navigator.of(context).pushNamed(FoodForm.routeName,
                                arguments: [
                                  widget.canteen.id,
                                  stallsData[index].id
                                ]);
                          },
                        ),
                      ],
                    ),
                  ),
                ),
              );
            },
          );
  }
}
