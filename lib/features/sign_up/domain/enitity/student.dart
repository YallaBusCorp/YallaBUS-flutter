class Student {
  final String code;
  final String stdName;
  final String stdPhone;
  final CompanyId companyId;
  final TownId townId;
  final UniversityId universityId;

  Student(
      {required this.code,
      required this.stdName,
      required this.stdPhone,
      required this.companyId,
      required this.townId,
      required this.universityId});
}

class CompanyId {
  final int id;

  CompanyId(this.id);
}

class TownId {
  final int id;

  TownId(this.id);
}

class UniversityId {
  final int id;

  UniversityId(this.id);
}
// {
//   "id": null,
//   "code": "97641616215615612as",
//   "stdName": "ابراهيم عيد",
//   "stdPhone": "01068504066",
//   "company": {
//     "id": 2
//   },
//   "town": {
//     "id": 4
//   },
//   "university": {
//     "id": 3
//   }
// }