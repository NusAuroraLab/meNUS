import 'package:menus/providers/comments.dart';
import 'package:provider/provider.dart';

class Food {
  final String? id;
  final String title;
  final String description;
  final double price;
  final String imageUrl;
  final dynamic comments;

  Food({
    required this.id,
    required this.title,
    required this.description,
    required this.price,
    required this.imageUrl,
    this.comments,
  });

  Food.fromJson(Map<String, dynamic> json)
      : id = json['id'],
        title = json['title'],
        description = json['description'],
        price = json['price'],
        imageUrl = json['imageUrl'],
        comments = json['comments'];

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'description': description,
      'price': price,
      'imageUrl': imageUrl,
      'comments': comments,
    };
  }
}
