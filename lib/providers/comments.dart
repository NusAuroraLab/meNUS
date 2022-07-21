import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:menus/providers/profiles.dart';
import 'package:provider/provider.dart';

import '../models/http_exception.dart';
import '../models/comment.dart';

class Comments with ChangeNotifier {
  Future<List<Comment>> fetchAndSetComments(
      String canteenId, String stallId, String foodId) async {
    final url = Uri.parse(
        'https://menus-14551-default-rtdb.asia-southeast1.firebasedatabase.app/canteen$canteenId/$stallId/foods/$foodId/comments.json');
    try {
      final response = await http.get(url);
      final extractedData = json.decode(response.body) as Map<String, dynamic>;
      final List<Comment> loadedComments = [];
      if (extractedData == null) {
        return loadedComments;
      }

      extractedData.forEach((id, data) {
        loadedComments.add(Comment(
          id,
          DateTime.parse(data['time']),
          data['comment'],
          data['rating'],
          data['userId'],
        ));
      });
      notifyListeners();
      return loadedComments;
    } catch (error) {
      print(error);
      return [];
    }
  }

  Future<void> addComment(
      Comment comment, String canteenId, String stallId, String foodId) async {
    final url = Uri.parse(
        'https://menus-14551-default-rtdb.asia-southeast1.firebasedatabase.app/canteen$canteenId/$stallId/foods/$foodId/comments.json');
    final timestamp = DateTime.now();
    try {
      final response = await http.post(
        url,
        body: json.encode({
          'time': timestamp.toIso8601String(),
          'comment': comment.comment,
          'rating': comment.rating,
          'userId': comment.userId,
        }),
      );
      notifyListeners();
    } catch (error) {
      print(error);
      throw error;
    }
  }
}
