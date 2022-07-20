import 'food.dart';

class Stall {
  final String? id;
  final String name;
  final String url;
  final dynamic foods;
  Stall(this.id, this.name, this.url, this.foods);
  Stall.fromJson(Map<String, dynamic> json)
      : id = json['id'],
        name = json['name'],
        url = json['url'],
        foods = json['foods'];

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'url': url,
      'foods': foods,
    };
  }
}
