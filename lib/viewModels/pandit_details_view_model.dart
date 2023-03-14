import 'package:dharmlok/models/pandit_details_model.dart';
import 'package:dharmlok/models/pandit_service_model.dart';
import 'package:dharmlok/models/service_model.dart';

import 'package:flutter/cupertino.dart';

import '../helpers/enum.dart';
import '../helpers/error_handler.dart';
import '../helpers/location_manager.dart';
import '../helpers/read_user_data.dart';
import '../models/service_detail_model.dart';
import '../services/pooja_service.dart';


class PanditDetailsViewModel extends ChangeNotifier {
  final PoojaService _poojaService = PoojaService();
  Status _status = Status.init;
  final UserDetails getUser = UserDetails();
  String category = 'Sanatan';

  Status get status => _status;

  late PanditDetails _panditDetails;

  PanditDetails get panditDetails => _panditDetails;


  late List<PanditService> _panditService;

  List<PanditService> get panditService => _panditService;

  late ServiceDetailsModel _serviceDetails;

  ServiceDetailsModel get serviceDetails => _serviceDetails;


  final LocationManager _locationManager = LocationManager();

  String userLocation = '';

  getUserLocation() async{
    userLocation = await _locationManager.getLocationName();
    notifyListeners();
  }




  Future<void> _setPanditDetails(PanditDetails panditDetails) async {
    _panditDetails = panditDetails;
    getPanditService(_panditDetails.message.userId);
    //_status = Status.success;
    notifyListeners();
  }

  Future<void> _setPanditService( List<PanditService> panditService) async {
    _panditService = panditService;
    _status = Status.success;
    notifyListeners();
  }

  Future<void> _setServiceDetails( ServiceDetailsModel serviceDetail) async {
    _serviceDetails = serviceDetail;
    _status = Status.success;
    notifyListeners();
  }


  late ShowError _error;

  ShowError get error => _error;

  void _setError(ShowError error) {
    _error = error;
    notifyListeners();
  }

  getPanditDetails(String id) async {
    try {
      _status = Status.loading;
      _setPanditDetails(await _poojaService.getPanditDetails(id,await getUser.getToken()));

    } on ShowError catch (error) {
      _status = Status.error;
      _setError(error);
    }
    notifyListeners();
  }

  getPanditService(String id) async {
    try {
      _status = Status.loading;
      _setPanditService(await _poojaService.getPanditService(id,await getUser.getToken()));
    } on ShowError catch (error) {
      _status = Status.error;
      _setError(error);
    }
    notifyListeners();
  }

  getServiceDetails(String id) async {
    try {
      _status = Status.loading;
      _setServiceDetails(await _poojaService.getServiceDetail(id,await getUser.getToken()));
    } on ShowError catch (error) {
      _status = Status.error;
      _setError(error);
    }
    notifyListeners();
  }
}
