class Student {
  final String stdUid;
  final String stdName;
  final String stdPhone;
  final CompanyId companyId;
  final TownId townId;
  final UniversityId universityId;

  Student(
      {required this.stdUid,
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
