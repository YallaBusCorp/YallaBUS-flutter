class ApiEndPoints {
  static const String baseUrl = 'https://yalla-bus.herokuapp.com/api/v1';
  static const String companies = '/company';
  static const String townsByCompanyId = '/lkTown/company/active';
  static const String universitiesByCompanyId = '/lkUniversity/company/active';
  static const String saveStudentInfo = '/student/save-student';
  static const String appointmentAm = '/appointment/company/active/get-all-am';
  static const String appointmentPm = '/appointment/company/active/get-all-pm';
}
