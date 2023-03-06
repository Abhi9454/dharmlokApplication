

import 'dart:convert';

import 'package:dharmlok/helpers/location_manager.dart';
import 'package:dharmlok/models/bal_vidya_model.dart';
import 'package:dharmlok/models/service_model.dart';
import 'package:dharmlok/services/bal_vidya_service.dart';
import 'package:dharmlok/services/pooja_service.dart';
import 'package:dharmlok/services/termple_service.dart';
import 'package:dharmlok/services/vendor_service.dart';

import 'package:flutter/cupertino.dart';

import '../helpers/enum.dart';
import '../helpers/error_handler.dart';
import '../helpers/read_user_data.dart';
import '../models/service_model.dart';
import '../models/temple_model.dart';


class PanchangViewModel extends ChangeNotifier {
  final VendorService _vendorService = VendorService();
  Status _status = Status.init;

  Status get status => _status;

  Map<dynamic,dynamic> _pDetail = <dynamic,dynamic>{};

  Map<dynamic,dynamic> get pDetail => _pDetail;



  Future<void> _setServiceModel(Map<dynamic,dynamic> pDetail) async {
    _pDetail = jsonDecode(pDetail['message']) as Map<dynamic, dynamic>;
    _status = Status.success;
    notifyListeners();
  }

  late ShowError _error;

  ShowError get error => _error;

  void _setError(ShowError error) {
    _error = error;
    notifyListeners();
  }


  getP() async {
    try {
      _status = Status.loading;
      _setServiceModel(await _vendorService.getPDetails());
    } on ShowError catch (error) {
      _status = Status.error;
      _setError(error);
    }
    notifyListeners();
  }
}
