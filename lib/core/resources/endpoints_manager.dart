class ApiEndPoints {
  // static const String baseUrl = 'https://yalla-bus.herokuapp.com/api/v1';
  // static const String baseUrl = 'https://yallabus.azurewebsites.net/api/v1';
  static const String baseUrl = 'https://yallabus.live/api/v1/';
  static const String companies = '/company';
  static const String companyId = '/company/get-by-id';
  static const String townsByCompanyId = '/lkTown/company/active';
  static const String universitiesByCompanyId = '/lkUniversity/company/active';
  static const String saveStudentInfo = '/student/save-student';
  static const String appointmentAm =
      '/appointment/company/available/get-all-am';
  static const String appointmentPm =
      '/appointment/company/available/get-all-pm';
  static const String mapPointsPickUp = '/mapPoint/company/active/get-all-pick';
  static const String mapPointsDropDown =
      '/mapPoint/company/active/get-all-drop';
  static const String bookRide = '/txBooking/save-txBooking';
  static const String updateStudent = '/student/update-student';
  static const String getStudentID = '/student/get-by-uid';
  static const String getNonScannedRides =
      '/txBooking/student/get-all-not-scanned';
  static const String getScannedRides = '/txBooking/student/get-all-scanned';
  static const String getCurrentRideByUID = '/txBooking/get-current-by-stdUid';
  static const String cancelRide = '/txBooking/';
  static const String scanQr = '/txBooking/scan-qrCode';
  static const String getBusUid = '/bus/get-by-phone';
  static const String getCurrentRideByBusUid = '/txBooking/bus/get-current';
  static const String endRide = '/txRide/assign';
  static const String getEmployeeByCode = '/employee/get-by-empCode';
  static const String saveTxRide = '/txBus/save-txBus';
}
