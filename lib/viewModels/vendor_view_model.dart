import 'dart:developer';

import '../../models/vendor_model.dart';
import '../../services/vendor_service.dart';
import 'package:flutter/cupertino.dart';

import '../helpers/enum.dart';
import '../helpers/error_handler.dart';
import '../helpers/read_user_data.dart';
import '../helpers/set_user_data.dart';

class VendorViewModel extends ChangeNotifier {
  final VendorService _vendorService = VendorService();
  Status _status = Status.init;
  final UserDetails getUser = UserDetails();
  String category = 'Sanatan';

  Status get status => _status;

  List<VendorModel> _vendorDetails = [] ;

  List<VendorModel> get vendorDetails => _vendorDetails;

  Future<void> _setVendorDetails(List<VendorModel> vendorDetails) async {
    _vendorDetails = vendorDetails;
    _status = Status.success;
    notifyListeners();
  }

  late ShowError _error;

  ShowError get error => _error;

  void _setError(ShowError error) {
    _error = error;
    notifyListeners();
  }

  updateCategory(String name, String type){
    category = name;
    _vendorDetails.clear();
    getVendorList(type);
    notifyListeners();
  }

  getVendorList(String typeVendor) async {
    try {
      _status = Status.loading;
      _setVendorDetails(await _vendorService.getAllVendor(category, typeVendor, await getUser.getToken()));
    } on ShowError catch (error) {
      _status = Status.error;
      _setError(error);
    }
    notifyListeners();
  }
}
