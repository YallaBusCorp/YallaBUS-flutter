import 'package:yalla_bus/features/choose_company/domain/enitity/company.dart';

class CompanyModel extends Company {
  CompanyModel(
      {required int id,
      required String companyName,
      required String companyPhone,
      required String description,
      required String companyLocation,
      required String imgUrl,
      required String facebookUrl})
      : super(
            id: id,
            companyName: companyName,
            companyPhone: companyPhone,
            description: description,
            companyLocation: companyLocation,
            imgUrl: imgUrl,
            facebookUrl: facebookUrl);

  factory CompanyModel.fromJson(Map<String, dynamic> json) {
    return CompanyModel(
        id: json['id'],
        companyName: json['companyName'],
        companyPhone: json['companyPhone'],
        description: json['description'],
        companyLocation: json['companyLocation'],
        imgUrl: json['imgURL'] ?? "NotFound",
        facebookUrl: json['facebookURL']);
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['companyName'] = companyName;
    data['companyPhone'] = companyPhone;
    data['description'] = description;
    data['companyLocation'] = companyLocation;
    data['imgURL'] = imgUrl;
    data['facebookURL'] = facebookUrl;
    return data;
  }
}
