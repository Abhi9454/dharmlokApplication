

import '../helpers/location_manager.dart';
import '../models/photo_model.dart';
import '../models/post_model.dart';
import '../models/profile_detail_model.dart';

import '../models/video_model.dart';
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

  List<VideoModel> _videoList = [];

  List<PhotoModel> _photoList = [];

  List<VideoModel> get videoList => _videoList;

  List<PhotoModel> get photoList => _photoList;

  ProfileModel get profileDetails => _profileDetails;

  List<PostModel> get postList => _postList;

  final LocationManager _locationManager = LocationManager();

  String userLocation = '';

  getUserLocation() async{
    userLocation = await _locationManager.getLocationName();
    notifyListeners();
  }

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

  Future<void> _setVideoList(List<VideoModel> videoList) async {
    _videoList = videoList;
    _userPostStatus = UserPostStatus.success;
    notifyListeners();
  }

  Future<void> _setPhotoList(List<PhotoModel> photoList) async {
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

  getUserPhotos(String id) async {
    try {
      _status = Status.loading;
      _setPhotoList(await _profileDetailService.getUserPhotos(id,await getUser.getToken()));
    } on ShowError catch (error) {
      _status = Status.error;
      _setError(error);
    }
    notifyListeners();
  }

  getUserVideos(String id) async {
    try {
      _status = Status.loading;
      _setVideoList(await _profileDetailService.getUserVideos(id,await getUser.getToken()));
    } on ShowError catch (error) {
      _status = Status.error;
      _setError(error);
    }
    notifyListeners();
  }
}
