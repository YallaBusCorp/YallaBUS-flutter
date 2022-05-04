class ApiEndPoints {
  static const String baseUrl = 'https://yalla-bus.herokuapp.com/api/v1';
  // static const String baseUrl = 'https://yallabus.live/api/v1/';
  static const String companies = '/company';
  static const String townsByCompanyId = '/lkTown/company/active';
  static const String universitiesByCompanyId = '/lkUniversity/company/active';
  static const String saveStudentInfo = '/student/save-student';
  static const String appointmentAm = '/appointment/company/active/get-all-am';
  static const String appointmentPm = '/appointment/company/active/get-all-pm';
  static const String mapPointsPickUp = '/mapPoint/company/active/get-all-pick';
  static const String mapPointsDropDown =
      '/mapPoint/company/active/get-all-drop';
}
