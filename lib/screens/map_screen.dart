import 'package:flutter/material.dart';
import 'package:menus/helpers/location_helper.dart';
import '../utils/colors.dart';

class MapScreen extends StatelessWidget {
  static const routeName = '/map';
  const MapScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var location = ModalRoute.of(context)!.settings.arguments as List<double>;
    final staticMapImageUrl = LocationHelper.generateLocationPreviewImage(
        latitude: location[0], longitude: location[1]);
    return Scaffold(
      appBar: AppBar(
        title: Text("Map"),
        backgroundColor: AppColors.primaryColor,
      ),
      body: Image.network(staticMapImageUrl),
    );
  }
}
