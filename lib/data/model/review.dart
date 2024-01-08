// To parse this JSON data, do
//
//     final review = reviewFromJson(jsonString);

import 'dart:convert';

Review reviewFromJson(String str) => Review.fromJson(json.decode(str));

String reviewToJson(Review data) => json.encode(data.toJson());

class Review {
  String id;
  String name;
  String review;

  Review({
    required this.id,
    required this.name,
    required this.review,
  });

  factory Review.fromJson(Map<String, dynamic> json) => Review(
    id: json["id"],
    name: json["name"],
    review: json["review"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
    "review": review,
  };
}