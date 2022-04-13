import 'package:yalla_bus/features/sign_up/domain/enitity/student.dart';

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

class StudentModel extends Student {
  StudentModel(
      {required String code,
      required String stdName,
      required String stdPhone,
      required CompanyId companyId,
      required TownId townId,
      required UniversityId universityId})
      : super(
            code: code,
            stdName: stdName,
            stdPhone: stdPhone,
            companyId: companyId,
            townId: townId,
            universityId: universityId);

  factory StudentModel.fromJson(Map<String, dynamic> json) {
    return StudentModel(
        code: json['code'],
        stdName: json['stdName'],
        stdPhone: json['stdPhone'],
        companyId: CompanyIdModel.fromJson(json['company']),
        townId: TownIdModel.fromJson(json['town']),
        universityId: UniversityIdModel.fromJson(json['university']));
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['code'] = code;
    data['stdName'] = stdName;
    data['stdPhone'] = stdPhone;
    data['company'] = CompanyIdModel(companyId.id).toJson();
    data['town'] = TownIdModel(townId.id).toJson();
    data['university'] = UniversityIdModel(universityId.id).toJson();
    return data;
  }
}

class CompanyIdModel extends CompanyId {
  CompanyIdModel(int id) : super(id);
  factory CompanyIdModel.fromJson(Map<String, dynamic> json) {
    return CompanyIdModel(json['id']);
  }
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['id'] = id;

    return data;
  }
}

class TownIdModel extends TownId {
  TownIdModel(int id) : super(id);
  factory TownIdModel.fromJson(Map<String, dynamic> json) {
    return TownIdModel(json['id']);
  }
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['id'] = id;

    return data;
  }
}

class UniversityIdModel extends UniversityId {
  UniversityIdModel(int id) : super(id);
  factory UniversityIdModel.fromJson(Map<String, dynamic> json) {
    return UniversityIdModel(json['id']);
  }
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['id'] = id;

    return data;
  }
}
