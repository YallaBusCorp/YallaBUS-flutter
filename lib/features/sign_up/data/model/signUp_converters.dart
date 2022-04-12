import '../../domain/enitity/town.dart';
import '../../domain/enitity/university.dart';

class UniversityModel extends University {
  UniversityModel({
    required int id,
    required String universityName,
  }) : super(
          id: id,
          universityName: universityName,
        );

  factory UniversityModel.fromJson(Map<String, dynamic> json) {
    return UniversityModel(
      id: json['id'],
      universityName: json['universityName'],
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['id'] = id;
    data['universityName'] = universityName;

    return data;
  }
}

class TownModel extends Town {
  TownModel({
    required int id,
    required String townName,
  }) : super(
          id: id,
          townName: townName,
        );

  factory TownModel.fromJson(Map<String, dynamic> json) {
    return TownModel(
      id: json['id'],
      townName: json['townName'],
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['id'] = id;
    data['townName'] = townName;

    return data;
  }
}
