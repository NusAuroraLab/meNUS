import 'dart:convert';
import 'package:flutter/material.dart';
import '../models/stall.dart';
import 'package:http/http.dart' as http;

class Stalls with ChangeNotifier {
  List<Stall> _stalls = [];
  List<Stall> get stalls {
    return [..._stalls];
  }

  Future<void> fetchAndSetStalls(String canteenId) async {
    final url = Uri.parse(
        'https://menus-14551-default-rtdb.asia-southeast1.firebasedatabase.app/canteen$canteenId.json');
    try {
      final response = await http.get(url);
      final extractedData = json.decode(response.body) as Map<String, dynamic>;
      if (extractedData == null) {
        _stalls = [];
        return;
      }
      final List<Stall> loadedStalls = [];
      extractedData.forEach((stallId, stallData) {
        loadedStalls.add(Stall(
          stallId,
          stallData['name'],
          stallData['url'],
          stallData['foods'],
        ));
      });
      _stalls = loadedStalls;
      notifyListeners();
    } catch (error) {
      print(error);
    }
  }

  Future<void> addStall(Stall stall, String canteenId) async {
    final url = Uri.parse(
        'https://menus-14551-default-rtdb.asia-southeast1.firebasedatabase.app/canteen$canteenId.json');
    try {
      final response = await http.post(
        url,
        body: json.encode({
          'name': stall.name,
          'url': stall.url,
          'foods': stall.foods,
        }),
      );
      final newStall = Stall(
        json.decode(response.body)['name'],
        stall.name,
        stall.url,
        stall.foods,
      );
      _stalls.add(newStall);
      notifyListeners();
    } catch (error) {
      print(error);
      throw error;
    }
  }
}
