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
        _restaurantResult = restaurant;
        return _restaurantList = restaurant.restaurants;
      }
    } catch (e) {
      _state = ResultState.error;
      notifyListeners();
      return _message = 'Koneksi error';
    }
  }

  ResultState? _searchState;
  List<Restaurant> _restaurantList = [];

  ResultState? get searchState => _searchState;

  List<Restaurant> get restaurantList => _restaurantList;

  Future<dynamic> searchRestaurant({required String query}) async {
    try {
      _searchState = ResultState.loading;
      notifyListeners();
      final result = await apiService.searchRestaurant(query: query);
      if (result.restaurants.isEmpty) {
        _searchState = ResultState.noData;
        notifyListeners();
        return _message = 'Tidak ditemukan restoran yang cocok';
      } else {
        _searchState = ResultState.hasData;
        notifyListeners();
        return _restaurantList = result.restaurants;
      }
    } catch (e) {
      _searchState = ResultState.error;
      notifyListeners();
      return _message = 'Koneksi error';
    }
  }
}
