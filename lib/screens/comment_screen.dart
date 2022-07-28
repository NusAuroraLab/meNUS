import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:intl/intl.dart';
import 'package:menus/providers/profiles.dart';
import 'package:provider/provider.dart';
import '../models/comment.dart';
import '../providers/comments.dart';
import '../utils/app_dimensions.dart';
import '../utils/colors.dart';
import 'comment_form.dart';
import '../widgets/small_text.dart';

class CommentScreen extends StatefulWidget {
  static const routeName = '/comment';

  @override
  State<CommentScreen> createState() => _CommentScreenState();
}

class _CommentScreenState extends State<CommentScreen> {
  @override
  Widget build(BuildContext context) {
    List<String> data =
        ModalRoute.of(context)!.settings.arguments as List<String>;
    List<String> userNames = [];
    return Scaffold(
      appBar: AppBar(
        title: Text('Comments'),
        backgroundColor: AppColors.primaryColor,
        flexibleSpace: Container(
          color: AppColors.primaryColor,
          margin: EdgeInsets.only(top: Dimensions.height30 * 1.2),
          padding: EdgeInsets.only(
              left: Dimensions.width20, right: Dimensions.width20),
        ),
      ),
      body: FutureBuilder(
          future: Provider.of<Comments>(context, listen: false)
              .fetchAndSetComments(data[0], data[1], data[2]),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return CircularProgressIndicator();
            } else if (snapshot.hasError) {
              print(snapshot.error);
              return Text('An Error Occurred!');
            } else {
              var comments = snapshot.data as List<Comment>;
              for (int i = 0; i < comments.length; i++) {
                Provider.of<Profile>(context, listen: false)
                    .fetchAndSetProfile(
                        comments[comments.length - 1 - i].userId)
                    .then((value) {
                  userNames.add(value[1]);
                });
              }
              return Column(
                children: [
                  Container(
                    height: Dimensions.screenSizeHeight -
                        Dimensions.height45 * 3.75,
                    child: ListView.builder(
                      physics: BouncingScrollPhysics(),
                      shrinkWrap: true,
                      itemCount: comments.length,
                      itemBuilder: (context, index) {
                        return Container(
                          margin: EdgeInsets.only(
                              left: Dimensions.width20,
                              right: Dimensions.width20,
                              bottom: Dimensions.height10),
                          child: FutureBuilder(
                              future:
                                  Provider.of<Profile>(context, listen: false)
                                      .fetchAndSetProfile(
                                          comments[comments.length - 1 - index]
                                              .userId),
                              builder: (context, snapshot) {
                                if (snapshot.connectionState ==
                                    ConnectionState.waiting) {
                                  return CircularProgressIndicator();
                                } else if (snapshot.hasError) {
                                  return Text("An Error Occured!");
                                }
                                var userData = snapshot.data as List<String>;
                                return Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    ListTile(
                                      leading: CircleAvatar(
                                        radius: 20,
                                        backgroundImage:
                                            NetworkImage(userData[0]),
                                      ),
                                      title: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Row(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.end,
                                            children: [
                                              SizedBox(
                                                width: Dimensions.width10 / 2,
                                              ),
                                              Container(
                                                width: Dimensions.width20 * 6,
                                                child: SmallText(
                                                  text: comments[
                                                          comments.length -
                                                              1 -
                                                              index]
                                                      .userId,
                                                  maxLine: 1,
                                                  size: Dimensions.font22,
                                                  color: Colors.black,
                                                ),
                                              ),
                                              SizedBox(
                                                width: Dimensions.width20,
                                              ),
                                              SmallText(
                                                text: DateFormat(
                                                        'dd/MM/yyyy hh:mm')
                                                    .format(comments[
                                                            comments.length -
                                                                1 -
                                                                index]
                                                        .time),
                                                size: Dimensions.font18 * 1.3,
                                              ),
                                            ],
                                          ),
                                          RatingBarIndicator(
                                            rating: comments[
                                                    comments.length - 1 - index]
                                                .rating,
                                            itemBuilder: (context, index) =>
                                                Icon(
                                              Icons.star,
                                              color: AppColors.primaryColor,
                                            ),
                                            itemCount: 5,
                                            itemSize: Dimensions.width15 * 2,
                                            direction: Axis.horizontal,
                                          ),
                                        ],
                                      ),
                                    ),
                                    Row(
                                      children: [
                                        SizedBox(
                                          width: Dimensions.width30 / 1.2,
                                        ),
                                        SmallText(
                                          text: comments[
                                                  comments.length - 1 - index]
                                              .comment,
                                          size: Dimensions.font22,
                                        ),
                                      ],
                                    )
                                  ],
                                );
                              }),
                        );
                      },
                    ),
                  ),
                  Container(
                    width: Dimensions.screenSizeWidth,
                    height: Dimensions.height45 * 1.6,
                    child: ElevatedButton(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.reviews,
                            color: AppColors.accentColor,
                          ),
                          SizedBox(
                            width: Dimensions.width20,
                          ),
                          SmallText(
                            text: 'Make your own comments',
                            size: Dimensions.font22,
                            color: AppColors.accentColor,
                          ),
                        ],
                      ),
                      onPressed: () {
                        Navigator.of(context)
                            .pushNamed(
                          CommentForm.routeName,
                          arguments: data,
                        )
                            .then((_) {
                          setState(() {});
                        });
                      },
                      style: ElevatedButton.styleFrom(
                          primary: Colors.white,
                          tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                          elevation: 0),
                    ),
                  ),
                ],
              );
            }
          }),
    );
  }
}
