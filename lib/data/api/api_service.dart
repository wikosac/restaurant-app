import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:restaurant_app/data/model/detail_result.dart';
import 'package:restaurant_app/data/model/review.dart';
import 'package:restaurant_app/data/model/review_result.dart';
import 'package:restaurant_app/data/model/search_result.dart';

import '../model/restaurant_result.dart';

class ApiService {
  static const String _baseUrl = 'https://restaurant-api.dicoding.dev/';

  Future<RestaurantResult> restaurantList() async {
    final response = await http.get(Uri.parse("${_baseUrl}list"));
    if (response.statusCode == 200) {
      return RestaurantResult.fromJson(json.decode(response.body));
    } else {
      throw Exception('Gagal memuat data');
    }
  }

  Future<DetailResult> restaurantDetail({required String id}) async {
    final response = await http.get(Uri.parse("${_baseUrl}detail/$id"));
    if (response.statusCode == 200) {
      return DetailResult.fromJson(json.decode(response.body));
    } else {
      throw Exception('Gagal memuat data');
    }
  }

  Future<SearchResult> searchRestaurant({required String query}) async {
    final response = await http.get(Uri.parse("${_baseUrl}search?q=$query"));
    if (response.statusCode == 200) {
      return SearchResult.fromJson(json.decode(response.body));
    } else {
      throw Exception('Gagal memuat data');
    }
  }

  Future<ReviewResult> postReview(
      {required String id,
      required String name,
      required String review}) async {
    final Review reviewData = Review(id: id, name: name, review: review);

    try {
      final response = await http.post(
        Uri.parse("${_baseUrl}review"),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode(reviewData),
      );

      ReviewResult responseData = jsonDecode(response.body);
      return responseData;
    } catch (error) {
      return ReviewResult(
          error: true,
          message: 'Gagal menambah ulasan',
      );
    }
  }
}
