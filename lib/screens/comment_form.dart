import 'package:flutter/material.dart';
import 'package:menus/utils/app_dimensions.dart';
import 'package:menus/widgets/big_text.dart';
import 'package:provider/provider.dart';
import '../models/comment.dart';
import '../providers/auth.dart';
import '../providers/comments.dart';
import '../utils/colors.dart';
import '../widgets/read_rating.dart';

class CommentForm extends StatefulWidget {
  static const routeName = '/comment-edit';
  @override
  _EditProductScreenState createState() => _EditProductScreenState();
}

class _EditProductScreenState extends State<CommentForm> {
  final _commentFocusNode = FocusNode();
  final _form = GlobalKey<FormState>();
  var _editedProduct = Comment('', DateTime.now(), '', 5, '');
  var _isLoading = false;
  _readRating(double rating) {
    _editedProduct = Comment(_editedProduct.id, _editedProduct.time,
        _editedProduct.comment, rating, _editedProduct.userId);
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    _commentFocusNode.dispose();
    super.dispose();
  }

  Future<void> _saveForm(
      String canteenId, String stallId, String foodId) async {
    final isValid = _form.currentState!.validate();
    if (!isValid) {
      return;
    }
    _form.currentState!.save();
    setState(() {
      _isLoading = true;
    });

    try {
      await Provider.of<Comments>(
        context,
        listen: false,
      ).addComment(_editedProduct, canteenId, stallId, foodId);
    } catch (error) {
      await showDialog(
        context: context,
        builder: (ctx) => AlertDialog(
          title: Text('An Error Occurred!'),
          content: Text('Something went wrong.'),
          actions: [
            TextButton(
              child: Text('Okay'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            )
          ],
        ),
      );
    }

    setState(() {
      _isLoading = false;
    });
    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    var _initValues = {
      'id': '',
      'date': DateTime.now(),
      'comment': '',
      'rate': '',
      'userId': Provider.of<Auth>(context, listen: false).userId,
    };
    List<String> data =
        ModalRoute.of(context)!.settings.arguments as List<String>;
    return Scaffold(
      appBar: AppBar(
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.save),
            onPressed: () => _saveForm(data[0], data[1], data[2]),
          ),
        ],
        title: Text('Add your feedback'),
        backgroundColor: AppColors.primaryColor,
        flexibleSpace: Container(
          color: AppColors.primaryColor,
          margin: EdgeInsets.only(top: Dimensions.height30 * 1.2),
          padding: EdgeInsets.only(
              left: Dimensions.width20, right: Dimensions.width20),
        ),
      ),
      body: _isLoading
          ? Center(
              child: CircularProgressIndicator(),
            )
          : Padding(
              padding: const EdgeInsets.all(16.0),
              child: Form(
                key: _form,
                child: ListView(
                  children: <Widget>[
                    Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        SizedBox(
                          height: Dimensions.height20,
                        ),
                        BigText(
                          text: 'Rate your experience!',
                          color: Colors.black87,
                          size: Dimensions.font22,
                        ),
                        SizedBox(
                          height: Dimensions.height20,
                        ),
                        ReadRate(_readRating),
                      ],
                    ),
                    SizedBox(
                      height: Dimensions.height20,
                    ),
                    TextFormField(
                      maxLines: 5,
                      initialValue: _initValues['comment'] as String,
                      decoration: InputDecoration(labelText: 'comment'),
                      textInputAction: TextInputAction.next,
                      onFieldSubmitted: (_) {
                        FocusScope.of(context).requestFocus(_commentFocusNode);
                      },
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Please provide a value.';
                        } else if (value.length < 10) {
                          return 'Please input as least 10 characters!';
                        } else {
                          return null;
                        }
                      },
                      onSaved: (value) {
                        _editedProduct = Comment(
                          _editedProduct.id,
                          _editedProduct.time,
                          value!,
                          _editedProduct.rating,
                          _initValues['userId'] as String,
                        );
                      },
                    ),
                  ],
                ),
              ),
            ),
    );
  }
}
