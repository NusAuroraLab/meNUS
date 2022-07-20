import 'package:flutter/cupertino.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';

//Not in use


class VendorProfilePage extends StatefulWidget {
  const VendorProfilePage({Key? key}) : super(key: key);

  @override
  State<VendorProfilePage> createState() => _VendorProfilePageState();
}

class _VendorProfilePageState extends State<VendorProfilePage> {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text(
        'Profile',
        style: TextStyle(fontSize: 60, fontWeight: FontWeight.bold),
      ),
    );
  }
}
