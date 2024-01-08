import 'dart:convert';

import 'package:restaurant_app/data/model/detail_result.dart';

ReviewResult reviewResultFromJson(String str) => ReviewResult.fromJson(json.decode(str));

class ReviewResult {
  bool error;
  String message;
  List<CustomerReview>? customerReviews;

  ReviewResult({
    required this.error,
    required this.message,
    this.customerReviews,
  });

  factory ReviewResult.fromJson(Map<String, dynamic> json) => ReviewResult(
    error: json["error"],
    message: json["message"],
    customerReviews: List<CustomerReview>.from(json["customerReviews"].map((x) => CustomerReview.fromJson(x))),
  );
}