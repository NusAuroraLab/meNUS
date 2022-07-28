import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:path/path.dart';

class Profile with ChangeNotifier {
  String _id = '';
  String _imageUrl = '';
  String _name = '';
  String _email = '';
  String get id {
    StringBuffer sf = StringBuffer(_id);
    return sf.toString();
  }

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
    print('555userId: ${userId}');
    final url = Uri.parse(
        'https://menus-14551-default-rtdb.asia-southeast1.firebasedatabase.app/profiles.json');
    try {
      final response = await http.get(url);
      final extractedData = json.decode(response.body) as Map<String, dynamic>;
      if (extractedData == null) {
        return [];
      }
      extractedData.forEach(
        (userId, userData) {
          _id = userId;
          _imageUrl = userData['imageUrl'];
          _name = userData['name'];
          _email = userData['email'];
        },
      );
      notifyListeners();
      return [imageUrl, name];
    } catch (error) {
      print(error);
      return [];
    }
  }

  Future<void> updateProfile(
      String userId, String email, String name, String imageUrl) async {
    final url = Uri.parse(
        'https://menus-14551-default-rtdb.asia-southeast1.firebasedatabase.app/profiles/$userId.json');
    await http.patch(url,
        body: json.encode({
          'email': email,
          'name': name,
          'imageUrl': imageUrl,
        }));
    notifyListeners();
  }

  upload(File imageFile, String userId) async {
    var stream = new http.ByteStream(imageFile.openRead());
    stream.cast();
    var length = await imageFile.length();

    var uri = Uri.parse(
        'https://menus-14551-default-rtdb.asia-southeast1.firebasedatabase.app/profile/$userId.json');
  }
}
