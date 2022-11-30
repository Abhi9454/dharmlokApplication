

import 'package:dharmlok/models/bal_vidya_model.dart';
import 'package:dharmlok/models/product_model.dart';
import 'package:dharmlok/models/profile_detail_model.dart';
import 'package:dharmlok/services/bal_vidya_service.dart';
import 'package:dharmlok/services/eshop_service.dart';
import 'package:dharmlok/services/profile_detail_service.dart';

import 'package:flutter/cupertino.dart';

import '../helpers/enum.dart';
import '../helpers/error_handler.dart';
import '../helpers/location_manager.dart';
import '../helpers/read_user_data.dart';


class EshopViewModel extends ChangeNotifier {
  final EshopService _eshopService = EshopService();
  final ProfileDetailService _profileDetailService = ProfileDetailService();
  Status _status = Status.init;
  final UserDetails getUser = UserDetails();
  String category = 'Sanatan';
  String vendorName = '', vendorPhoneNumber = '';

  final LocationManager _locationManager = LocationManager();

  String userLocation = '';

  getUserLocation() async{
    userLocation = await _locationManager.getLocationName();
    notifyListeners();
  }

  Status get status => _status;

  List<Product> _productList = [] ;

  List<Product> get productList => _productList;

  Future<void> _setProductList(List<Product> productList) async {
    _productList = productList;
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
    _productList.clear();
    notifyListeners();
  }

  getAllProducts() async {
    try {
      _status = Status.loading;
      _setProductList(await _eshopService.getAllProduct('',await getUser.getToken()));
    } on ShowError catch (error) {
      _status = Status.error;
      _setError(error);
    }
    notifyListeners();
  }

  getProfileDetails(String id) async{
    ProfileModel profileModel = await _profileDetailService.getProfileDetail(id,await getUser.getToken());
    vendorName = profileModel.biography!.name ?? '';
    vendorPhoneNumber = profileModel.biography!.phone ?? '';
  }
}
