class StateModel {
  final String stateName;

  StateModel(
      {required this.stateName,
      });

  factory StateModel.fromJson(Map<String, dynamic> json) {
    return StateModel(
      stateName: json['state_name'],
    );
  }
}