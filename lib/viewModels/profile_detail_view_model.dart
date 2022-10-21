

import '../models/post_model.dart';
import '../models/profile_detail_model.dart';

import '../services/profile_detail_service.dart';

import 'package:flutter/cupertino.dart';

import '../helpers/enum.dart';
import '../helpers/error_handler.dart';
import '../helpers/read_user_data.dart';


class ProfileDetailViewModel extends ChangeNotifier {
  final ProfileDetailService _profileDetailService = ProfileDetailService();
  Status _status = Status.init;
  UserPostStatus _userPostStatus = UserPostStatus.init;
  final UserDetails getUser = UserDetails();
  String category = 'Sanatan';

  int selectedTab = 0;

  Status get status => _status;

  UserPostStatus get userPostStatus => _userPostStatus;

  late ProfileModel _profileDetails;

  List<PostModel> _postList = [];

  List<String> _videoList = [];

  List<String> _photoList = [];

  List<String> get videoList => _videoList;

  List<String> get photoList => _photoList;

  ProfileModel get profileDetails => _profileDetails;

  List<PostModel> get postList => _postList;

  Future<void> _setProfileDetail(ProfileModel profileDetails) async {
    _profileDetails = profileDetails;
    _status = Status.success;
    notifyListeners();
  }

  Future<void> _setPostList(List<PostModel> postList) async {
    _postList = postList;
    _userPostStatus = UserPostStatus.success;
    notifyListeners();
  }

  Future<void> _setVideoList(List<String> videoList) async {
    _videoList = videoList;
    _userPostStatus = UserPostStatus.success;
    notifyListeners();
  }

  Future<void> _setPhotoList(List<String> photoList) async {
    _photoList = photoList;
    _userPostStatus = UserPostStatus.success;
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
    notifyListeners();
  }

  setSelectedTab(int value){
    selectedTab = value;
    notifyListeners();
  }

  getProfileDetail(String id) async {
    try {
      _status = Status.loading;
      _setProfileDetail(await _profileDetailService.getProfileDetail(id,await getUser.getToken()));
    } on ShowError catch (error) {
      _status = Status.error;
      _setError(error);
    }
    notifyListeners();
  }

  getAllPosts(String userType) async {
    try {
      _userPostStatus = UserPostStatus.loading;
      _setPostList(await _profileDetailService.getUserPosts(userType,await getUser.getToken()));
    } on ShowError catch (error) {
      _userPostStatus = UserPostStatus.error;
      _setError(error);
    }
    notifyListeners();
  }
}
