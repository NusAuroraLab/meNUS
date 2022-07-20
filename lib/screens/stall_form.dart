import 'package:flutter/material.dart';
import 'package:menus/screens/main_screen.dart';
import 'package:provider/provider.dart';
import '../models/food.dart';
import '../models/stall.dart';
import '../providers/foods.dart';
import '../providers/stalls.dart';

class StallForm extends StatefulWidget {
  static const routeName = '/edit-stall';
  @override
  _EditProductScreenState createState() => _EditProductScreenState();
}

class _EditProductScreenState extends State<StallForm> {
  final _name = FocusNode();
  final _imageUrlController = TextEditingController();
  final _imageUrlFocusNode = FocusNode();
  final _form = GlobalKey<FormState>();
  var _editedProduct = Stall(
    null,
    '',
    '',
    [],
  );
  var _initValues = {
    'id': null,
    'name': '',
    'url': '',
    'foods': '',
  };
  var _isLoading = false;

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    _name.dispose();
    _imageUrlController.dispose();
    _imageUrlFocusNode.dispose();
    super.dispose();
  }

  Future<void> _saveForm(String canteenId) async {
    final isValid = _form.currentState!.validate();
    if (!isValid) {
      return;
    }
    _form.currentState!.save();
    setState(() {
      _isLoading = true;
    });

    try {
      await Provider.of<Stalls>(
        context,
        listen: false,
      ).addStall(_editedProduct, canteenId);
    } catch (error) {
      await showDialog(
        context: context,
        builder: (ctx) => AlertDialog(
          title: Text('An Error Occured!'),
          content: Text('Something went wrong.'),
          actions: <Widget>[
            TextButton(
              child: Text('Okay'),
              onPressed: () {
                Navigator.of(context)
                    .pushReplacementNamed(MainScreen.routeName);
              },
            )
          ],
        ),
      );
    }

    setState(() {
      _isLoading = false;
    });
    Navigator.of(context).pushReplacementNamed(MainScreen.routeName);
  }

  @override
  Widget build(BuildContext context) {
    String data = ModalRoute.of(context)!.settings.arguments as String;
    return Scaffold(
      appBar: AppBar(
        title: Text('Edit Stall'),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.save),
            onPressed: () => _saveForm(data),
          ),
        ],
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
                    TextFormField(
                      initialValue: _initValues['name'] as String,
                      decoration: InputDecoration(labelText: 'name'),
                      textInputAction: TextInputAction.next,
                      onFieldSubmitted: (_) {
                        FocusScope.of(context).requestFocus(_name);
                      },
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Please provide a value.';
                        }
                        return null;
                      },
                      onSaved: (value) {
                        _editedProduct = Stall(_editedProduct.id, value!,
                            _editedProduct.url, _editedProduct.foods);
                      },
                    ),
                    TextFormField(
                      initialValue: _initValues['imageUrl'] as String,
                      decoration: InputDecoration(labelText: 'imageUrl'),
                      textInputAction: TextInputAction.next,
                      onFieldSubmitted: (_) {
                        FocusScope.of(context).requestFocus(_imageUrlFocusNode);
                      },
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Please provide a value.';
                        }
                        return null;
                      },
                      onSaved: (value) {
                        _editedProduct = Stall(_editedProduct.id,
                            _editedProduct.name, value!, _editedProduct.foods);
                      },
                    ),
                  ],
                ),
              ),
            ),
    );
  }
}
