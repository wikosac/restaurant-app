import 'package:flutter/foundation.dart';
import 'package:restaurant_app/data/api/api_service.dart';
import 'package:restaurant_app/data/model/restaurant_result.dart';

enum ResultState { loading, noData, hasData, error }

class RestaurantProvider extends ChangeNotifier {
  final ApiService apiService;

  RestaurantProvider({required this.apiService}) {
    _fetchRestaurant();
  }

  late RestaurantResult _restaurantResult;
  late ResultState _state;
  String _message = '';

  RestaurantResult get restaurantResult => _restaurantResult;

  ResultState get state => _state;

  String get message => _message;

  Future<dynamic> _fetchRestaurant() async {
    try {
      _state = ResultState.loading;
      notifyListeners();
      final restaurant = await apiService.restaurantList();
      if (restaurant.restaurants.isEmpty) {
        _state = ResultState.noData;
        notifyListeners();
        return _message = 'Tidak ada data';
      } else {
        _state = ResultState.hasData;
        notifyListeners();
        return _restaurantResult = restaurant;
      }
    } catch (e) {
      _state = ResultState.error;
      notifyListeners();
      return _message = 'Koneksi error';
    }
  }

  ResultState? _searchState;

  List<Restaurant> _filteredRestaurants = [];

  ResultState? get searchState => _searchState;

  List<Restaurant> get filteredRestaurants => _filteredRestaurants;


  void searchRestaurantsByKeyword(String keyword) {
    _filteredRestaurants = _restaurantResult.restaurants
        .where((item) => item.name.toLowerCase().contains(keyword.toLowerCase()))
        .toList();

    if (_filteredRestaurants.isEmpty) {
      _searchState = ResultState.noData;
      _message = 'Tidak ditemukan restoran yang cocok';
      notifyListeners();
    } else {
      _searchState = ResultState.hasData;
      notifyListeners();
    }
  }
}
