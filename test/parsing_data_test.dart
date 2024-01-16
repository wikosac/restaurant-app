import 'package:flutter_test/flutter_test.dart';
import 'package:restaurant_app/data/model/restaurant_result.dart';

void main() {
  final restaurantJson = {
    "id": "8maika7giinkfw1e867",
    "name": "Rumah Senja",
    "description": "Quisque rutrum. Aenean imperdiet..",
    "pictureId": "23",
    "city": "Bandung",
    "rating": 3.9
  };
  final restaurantResultJson = {
    "error": false,
    "message": "success",
    "count": 20,
    "restaurants": [restaurantJson]
  };
  final restaurant = Restaurant(
      id: '8maika7giinkfw1e867',
      name: 'Rumah Senja',
      description: 'Quisque rutrum. Aenean imperdiet..',
      pictureId: '23',
      city: 'Bandung',
      rating: 3.9);
  final restaurantResult = RestaurantResult(
      error: false, message: 'success', count: 20, restaurants: [restaurant]);

  test('parse Restaurant from json', () {
    final result = Restaurant.fromJson(restaurantJson);

    expect(result.id, '8maika7giinkfw1e867');
    expect(result.name, 'Rumah Senja');
    expect(result.description, 'Quisque rutrum. Aenean imperdiet..');
    expect(result.pictureId, '23');
    expect(result.city, 'Bandung');
    expect(result.rating, 3.9);
  });

  test('parse RestaurantResult from json', () {
    final result = RestaurantResult.fromJson(restaurantResultJson);

    expect(result.error, false);
    expect(result.message, 'success');
    expect(result.count, 20);
    expect(result.restaurants, result.restaurants);
  });

  test('parse Restaurant to json', () {
    final result = restaurant.toJson();

    expect(result['id'], '8maika7giinkfw1e867');
    expect(result['name'], 'Rumah Senja');
    expect(result['description'], 'Quisque rutrum. Aenean imperdiet..');
    expect(result['pictureId'], '23');
    expect(result['city'], 'Bandung');
    expect(result['rating'], 3.9);
  });

  test('parse RestaurantResult to json', () {
    final result = restaurantResult.toJson();

    expect(result['error'], false);
    expect(result['message'], 'success');
    expect(result['count'], 20);
    expect(result['restaurants'], [restaurantJson]);
  });
}
