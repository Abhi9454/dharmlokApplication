

import 'package:dharmlok/models/bal_vidya_model.dart';
import 'package:dharmlok/models/event_model.dart';
import 'package:dharmlok/services/bal_vidya_service.dart';
import 'package:dharmlok/services/event_service.dart';

import 'package:flutter/cupertino.dart';

import '../helpers/enum.dart';
import '../helpers/error_handler.dart';
import '../helpers/read_user_data.dart';


class EventViewModel extends ChangeNotifier {
  final EventService _eventService = EventService();
  Status _status = Status.init;
  final UserDetails getUser = UserDetails();
  String category = 'Sanatan';

  Status get status => _status;

  List<EventModel> _eventDetails = [] ;

  List<EventModel> get eventDetails => _eventDetails;

  Future<void> _setEventDetails(List<EventModel> eventDetails) async {
    _eventDetails = eventDetails;
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
    _eventDetails.clear();
    getAllEvents();
    notifyListeners();
  }

  getAllEvents() async {
    try {
      _status = Status.loading;
      _setEventDetails(await _eventService.getAllEvents(category,await getUser.getToken()));
    } on ShowError catch (error) {
      _status = Status.error;
      _setError(error);
    }
    notifyListeners();
  }
}
