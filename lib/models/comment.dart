import 'package:menus/providers/profiles.dart';

class Comment {
  final String id;
  final DateTime time;
  final String comment;
  final double rating;
  final String userId;

  Comment(this.id, this.time, this.comment, this.rating, this.userId);
  Comment.fromJson(Map<String, dynamic> json)
      : id = json['id'],
        time = json['time'],
        comment = json['comment'],
        rating = json['rating'],
        userId = json['userId'];

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'time': time,
      'comment': comment,
      'rating': rating,
      'userId': userId,
    };
  }
}
