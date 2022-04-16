class ApiEndPoints {
  static const String baseUrl = 'https://yalla-bus.herokuapp.com';
  static const String companies = '/api/v1/company';
  static const String townsByCompanyId = '/api/v1/lkTown/company/active';
  static const String universitiesByCompanyId =
      '/api/v1/lkUniversity/company/active';
  static const String saveStudentInfo = '/api/v1/student/save-student';
}
