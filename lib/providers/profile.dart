import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class Profile with ChangeNotifier {
  String _imageUrl = '';
  String _name = '';
  String _email = '';

  String get imageUrl {
    StringBuffer sf = StringBuffer(_imageUrl);
    return sf.toString();
  }

  String get name {
    StringBuffer sf = StringBuffer(_name);
    return sf.toString();
  }

  String get email {
    StringBuffer sf = StringBuffer(_email);
    return sf.toString();
  }

  Future<List<String>> fetchAndSetProfile(String userId) async {
    final url = Uri.parse(
        'https://menus-14551-default-rtdb.asia-southeast1.firebasedatabase.app/profile/$userId.json');
    try {
      final response = await http.get(url);
      final extractedData = json.decode(response.body) as Map<String, dynamic>;
      if (extractedData == null) {
        return [];
      }
      extractedData.forEach(
        (userId, userData) {
          _imageUrl = userData['imageUrl'];
          _name = userData['name'];
          _email = userData['email'];
        },
      );
      notifyListeners();
      return [imageUrl, name, email];
    } catch (error) {
      print(error);
      return [];
    }
  }
}
