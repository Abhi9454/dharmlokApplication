

import 'package:dharmlok/helpers/location_manager.dart';
import 'package:dharmlok/models/bal_vidya_model.dart';
import 'package:dharmlok/services/bal_vidya_service.dart';

import 'package:flutter/cupertino.dart';

import '../helpers/enum.dart';
import '../helpers/error_handler.dart';
import '../helpers/read_user_data.dart';


class BalVidyaViewModel extends ChangeNotifier {
  final BalVidyaService _balVidyaService = BalVidyaService();
  Status _status = Status.init;
  final UserDetails getUser = UserDetails();

  String category = 'Sanatan';
  final LocationManager _locationManager = LocationManager();

  String userLocation = '';

  getUserLocation() async{
    userLocation = await _locationManager.getLocationName();
    notifyListeners();
  }

  Status get status => _status;

  List<BalVidyaModel> _balVidyaDetails = [] ;

  List<BalVidyaModel> get balVidyaDetails => _balVidyaDetails;



  Future<void> _setBalVidyaDetails(List<BalVidyaModel> balVidyaDetails) async {
    _balVidyaDetails = balVidyaDetails;
    _status = Status.success;
    notifyListeners();
  }

  late ShowError _error;

  ShowError get error => _error;

  void _setError(ShowError error) {
    _error = error;
    notifyListeners();
  }

  updateCategory(String name){
    category = name;
    _balVidyaDetails.clear();
    getBalVidya();
    notifyListeners();
  }

  getBalVidya() async {
    try {
      _status = Status.loading;
      _setBalVidyaDetails(await _balVidyaService.getBalVidya(category,'en','Book',await getUser.getToken()));
    } on ShowError catch (error) {
      _status = Status.error;
      _setError(error);
    }
    notifyListeners();
  }
}
