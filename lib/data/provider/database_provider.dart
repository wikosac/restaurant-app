import 'package:flutter/material.dart';
import 'package:restaurant_app/data/db/database_helper.dart';
import 'package:restaurant_app/data/model/restaurant_result.dart';
import 'package:restaurant_app/utils/result_state.dart';

class DatabaseProvider extends ChangeNotifier {
  final DatabaseHelper databaseHelper;

  DatabaseProvider({required this.databaseHelper}) {
    _getFavorite();
  }

  late ResultState _state;

  ResultState get state => _state;

  String _message = '';

  String get message => _message;

  List<Restaurant> _favorites = [];

  List<Restaurant> get favorites => _favorites;

  void _getFavorite() async {
    _state = ResultState.loading;
    _favorites = await databaseHelper.getFavorites();
    if (_favorites.isNotEmpty) {
      _state = ResultState.hasData;
    } else {
      _state = ResultState.noData;
      _message = 'Tidak ada data';
    }
    notifyListeners();
  }

  void addFavorite(Restaurant restaurant) async {
    try {
      _state = ResultState.loading;
      await databaseHelper.insertFavorite(restaurant);
      _message = 'Ditambahkan ke favorit';
      notifyListeners();
      _getFavorite();
    } catch (e) {
      _state = ResultState.error;
      _message = 'Gagal menambah favorit';
      notifyListeners();
    }
  }

  Future<bool> isFavorited(String id) async {
    final favoritedRestaurant = await databaseHelper.getFavoriteById(id);
    return favoritedRestaurant.isNotEmpty;
  }

  void removeFavorite(String id) async {
    try {
      await databaseHelper.removeFavorite(id);
      _message = 'Favorit telah diperbarui';
      notifyListeners();
      _getFavorite();
    } catch (e) {
      _state = ResultState.error;
      _message = 'Gagal menghapus favorit';
      notifyListeners();
    }
  }
}
