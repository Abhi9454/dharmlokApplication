
import '../models/ebook_model.dart';
import '../../services/ebook_service.dart';

import 'package:flutter/cupertino.dart';

import '../helpers/enum.dart';
import '../helpers/error_handler.dart';
import '../helpers/read_user_data.dart';


class EbookViewModel extends ChangeNotifier {
  final EbookService _ebookService = EbookService();
  Status _status = Status.init;
  final UserDetails getUser = UserDetails();
  String category = 'Sanatan';

  Status get status => _status;

  List<EbookModel> _ebookTrendingList = [] ;

  List<EbookModel> get ebookTrendingList => _ebookTrendingList;

  List<EbookModel> _ebookDevotionList = [] ;

  List<EbookModel> get ebookDevotionList => _ebookDevotionList;

  List<EbookModel> _ebookFictionList = [] ;

  List<EbookModel> get ebookFictionList => _ebookFictionList;

  Future<void> _setEbookList(List<EbookModel> ebookTrendingList) async {
    _ebookTrendingList = ebookTrendingList;
    _status = Status.success;
    notifyListeners();
  }

  Future<void> _setDevotionList(List<EbookModel> ebookDevotionList) async {
    _ebookDevotionList = ebookDevotionList;
    _status = Status.success;
    notifyListeners();
  }

  Future<void> _setFictionList(List<EbookModel> ebookFictionList) async {
    _ebookFictionList = ebookFictionList;
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
    _ebookTrendingList.clear();
    getTrendingEbook();
    getDevotionEbook();
    getFictionEbook();
    notifyListeners();
  }

  getTrendingEbook() async {
    try {
      _status = Status.loading;
      _setEbookList(await _ebookService.getEbook(category,'en','Trending',await getUser.getToken()));
    } on ShowError catch (error) {
      _status = Status.error;
      _setError(error);
    }
    notifyListeners();
  }

  getDevotionEbook() async {
    try {
      _status = Status.loading;
      _setDevotionList(await _ebookService.getEbook(category,'en','Devotional',await getUser.getToken()));
    } on ShowError catch (error) {
      _status = Status.error;
      _setError(error);
    }
    notifyListeners();
  }

  getFictionEbook() async {
    try {
      _status = Status.loading;
      _setFictionList(await _ebookService.getEbook(category,'en','Fictional',await getUser.getToken()));
    } on ShowError catch (error) {
      _status = Status.error;
      _setError(error);
    }
    notifyListeners();
  }
}
