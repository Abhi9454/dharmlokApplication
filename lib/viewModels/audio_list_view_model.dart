

import 'package:dharmlok/helpers/location_manager.dart';
import 'package:dharmlok/models/audio_track_model.dart';
import 'package:dharmlok/services/audio_service.dart';

import 'package:flutter/cupertino.dart';

import '../helpers/enum.dart';
import '../helpers/error_handler.dart';
import '../helpers/read_user_data.dart';
import '../models/audio_playlist_model.dart';


class AudioListViewModel extends ChangeNotifier {
  final AudioService _audioService = AudioService();
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

  List<AudioPlayListModel> _audioList = [] ;

  List<AudioPlayListModel> playList = [] ;

  List<AudioPlayListModel> get audioList => _audioList;


  List<AudioTrackModel> _allTracks = [] ;

  List<AudioTrackModel> get allTracks => _allTracks;


  Future<void> _setAudioList(List<AudioPlayListModel> audioList) async {
    _audioList = audioList;
    _status = Status.success;
    notifyListeners();
  }

  Future<void> _setTrackList(List<AudioTrackModel> audioTrack) async {
    _allTracks = audioTrack;
    setAudioList();
    _status = Status.success;
    notifyListeners();
  }


  setAudioList(){
    if(_audioList.isNotEmpty){
      for(int i = 0 ; i < _audioList.length ; i++){
        for(int j = 0; j < _audioList[i].playlist!.length; j++){
          if(_audioList[i].playlist![j].category == category){
            playList.add(_audioList[i].playlist![j]);
          }
        }
      }
    }
  }


  late ShowError _error;

  ShowError get error => _error;

  void _setError(ShowError error) {
    _error = error;
    notifyListeners();
  }

  updateCategory(String name){
    category = name;
    playList.clear();
    setAudioList();
    notifyListeners();
  }

  getAudioPlayList() async {
    try {
      _status = Status.loading;
      _setAudioList(await _audioService.getAllAudio(await getUser.getToken()));
    } on ShowError catch (error) {
      _status = Status.error;
      _setError(error);
    }
    notifyListeners();
  }

  getAllTracks() async {
    try {
      _status = Status.loading;
      _setTrackList(await _audioService.getPlayListAudio(await getUser.getToken()));
    } on ShowError catch (error) {
      _status = Status.error;
      _setError(error);
    }
    notifyListeners();
  }
}
