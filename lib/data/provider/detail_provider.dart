import 'package:flutter/foundation.dart';
import 'package:restaurant_app/data/api/api_service.dart';
import 'package:restaurant_app/data/model/detail_result.dart';
import 'package:restaurant_app/data/provider/restaurant_provider.dart';

class DetailProvider extends ChangeNotifier {
  final ApiService apiService;
  final String id;

  DetailProvider({required this.apiService, required this.id}) {
    _fetchDetail(id: id);
  }

  late DetailResult _detailResult;
  late ResultState _state;
  String _message = '';

  DetailResult get detailResult => _detailResult;
  ResultState get state => _state;
  String get message => _message;

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
      return _message = 'Koneksi error';
    }
  }
}