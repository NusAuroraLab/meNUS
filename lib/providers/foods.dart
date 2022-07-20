import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import '../models/food.dart';
import '../models/http_exception.dart';

class Foods with ChangeNotifier {
  List<Food> _foods = [];
  List<Food> get foods {
    return [..._foods];
  }

  Future<void> fetchAndSetFoods(String canteenId, String stallId) async {
    final url = Uri.parse(
        'https://menus-14551-default-rtdb.asia-southeast1.firebasedatabase.app/canteen$canteenId/$stallId/foods.json');
    try {
      final response = await http.get(url);
      final extractedData = json.decode(response.body) as Map<String, dynamic>;
      if (extractedData == null) {
        _foods = [];
        return;
      }
      final List<Food> loadedFoods = [];
      extractedData.forEach((id, data) {
        loadedFoods.add(Food(
          id: id,
          title: data['title'],
          description: data['description'],
          price: data['price'],
          imageUrl: data['imageUrl'],
          comments: data['comments'],
        ));
      });
      _foods = loadedFoods;
      notifyListeners();
    } catch (error) {
      print(error);
    }
  }

  Food? findById(String id) {
    return (_foods.any(
      (food) => food.id == id,
    ))
        ? _foods.firstWhere((food) => food.id == id)
        : null;
  }

  Future<void> addFood(Food food, String canteenId, String stallId) async {
    final url = Uri.parse(
        'https://menus-14551-default-rtdb.asia-southeast1.firebasedatabase.app/canteen$canteenId/$stallId/foods.json');
    try {
      final response = await http.post(
        url,
        body: json.encode({
          'title': food.title,
          'description': food.description,
          'price': food.price,
          'imageUrl': food.imageUrl,
          'comments': food.comments,
        }),
      );
      final newFood = Food(
          id: json.decode(response.body)['name'],
          title: food.title,
          description: food.description,
          price: food.price,
          imageUrl: food.imageUrl,
          comments: food.comments);
      _foods.add(newFood);
      notifyListeners();
    } catch (error) {
      print(error);
      throw error;
    }
  }

  Future<void> deleteFood(Food food, String canteenId, String stallId) async {
    final url = Uri.parse(
        'https://menus-14551-default-rtdb.asia-southeast1.firebasedatabase.app/canteen$canteenId/$stallId/foods/${food.id}.json');
    final existingProductIndex =
        _foods.indexWhere((prod) => prod.id == food.id);
    var existingProduct = _foods[existingProductIndex];
    _foods.removeAt(existingProductIndex);
    notifyListeners();
    final response = await http.delete(url);
    if (response.statusCode >= 400) {
      _foods.insert(existingProductIndex, existingProduct);
      notifyListeners();
      throw HttpException('Could not delete product.');
    }
  }
}
