import '../helpers/location_manager.dart';
import '../models/dharshan_model.dart';
import '../services/dharshan_service.dart';

import 'package:flutter/cupertino.dart';

import '../helpers/enum.dart';
import '../helpers/error_handler.dart';
import '../helpers/read_user_data.dart';

class DharshanViewModel extends ChangeNotifier {
  final DharshanService _dharshanService = DharshanService();
  Status _status = Status.init;
  final UserDetails getUser = UserDetails();
  String category = 'Sanatan';

  final LocationManager _locationManager = LocationManager();

  String userLocation = '';

  getUserLocation() async {
    userLocation = await _locationManager.getLocationName();
    notifyListeners();
  }

  List<DharshanModel> liveDharshan = [];

  List<DharshanModel> liveTV = [];

  Status get status => _status;

  List<DharshanModel> _dharshanModelList = [];

  List<DharshanModel> get dharshanModelList => _dharshanModelList;

  Future<void> _setDharshanModel(List<DharshanModel> dharshanModelList) async {
    _dharshanModelList = dharshanModelList;
    updateList();
    _status = Status.success;
    notifyListeners();
  }

  updateList() {
    for (int i = 0; i < _dharshanModelList.length; i++) {
      if (_dharshanModelList[i].type == 'live') {
        liveTV.add(_dharshanModelList[i]);
      } else {
        liveDharshan.add(_dharshanModelList[i]);
      }
    }
  }

  late ShowError _error;

  ShowError get error => _error;

  void _setError(ShowError error) {
    _error = error;
    notifyListeners();
  }

  updateCategory(String name) {
    category = name;
    _dharshanModelList.clear();
    liveDharshan.clear();
    liveTV.clear();
    getDharshan();
    notifyListeners();
  }

  getDharshan() async {
    try {
      _status = Status.loading;
      _setDharshanModel(await _dharshanService.getAllDharshan(
          category, await getUser.getToken()));
    } on ShowError catch (error) {
      _status = Status.error;
      _setError(error);
    }
    notifyListeners();
  }
}
