import 'package:flutter/foundation.dart';
import 'package:restaurant_app/data/api/api_service.dart';
import 'package:restaurant_app/data/model/detail_result.dart';
import 'package:restaurant_app/data/model/restaurant_result.dart';

enum ResultState { loading, noData, hasData, error }

class RestaurantProvider extends ChangeNotifier {
  final ApiService apiService;

  RestaurantProvider({required this.apiService}) {
    _fetchRestaurant();
    _fetchDetail(id: '');
  }

  late RestaurantResult _restaurantResult;
  late DetailResult _detailResult;
  late ResultState _state;
  String _message = '';

  RestaurantResult get restaurantResult => _restaurantResult;
  DetailResult get detailResult => _detailResult;
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
      return _message = 'Error --> $e';
    }
  }

  Future<dynamic> _fetchDetail({required String id}) async {
    try {
      _state = ResultState.loading;
      notifyListeners();
      final detail = await apiService.restaurantDetail(id: id);
      if (detail.error == true) {
        _state = ResultState.noData;
        notifyListeners();
        return _message = 'Tidak ada data';
      } else {
        _state = ResultState.hasData;
        notifyListeners();
        return _detailResult = detail;
      }
    } catch (e) {
      _state = ResultState.error;
      notifyListeners();
      return _message = 'Error --> $e';
    }
  }
}