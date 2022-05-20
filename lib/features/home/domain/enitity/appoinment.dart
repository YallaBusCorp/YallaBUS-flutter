

class Appoinment {
  final int id;
  final String appointmentStartTime;
  final String appointmentType;

  Appoinment({
    required this.id,
    required this.appointmentStartTime,
    required this.appointmentType,
  });
}

/* 
 [
    {
        "id": 14,
        "company": {
            "id": 1,
            "companyName": "UNIBUS",
            "companyPhone": "01012962987",
            "description": "مكتب UNI BUS لخدمات نقل طلاب مدينة ميت غمر لجامعة المنصورة للعام الثامن ع التوالي Since 2014/2015",
            "companyLocation": "ميت غمر",
            "imgURL": "",
            "facebookURL": "https://www.facebook.com/unibus2018"
        },
        "appointmentStartTime": "01:00:00",
        "appointmentType": "PM",
        "isActive": true
    },
    {
        "id": 24,
        "company": {
            "id": 1,
            "companyName": "UNIBUS",
            "companyPhone": "01012962987",
            "description": "مكتب UNI BUS لخدمات نقل طلاب مدينة ميت غمر لجامعة المنصورة للعام الثامن ع التوالي Since 2014/2015",
            "companyLocation": "ميت غمر",
            "imgURL": "",
            "facebookURL": "https://www.facebook.com/unibus2018"
        },
        "appointmentStartTime": "01:30:00",
        "appointmentType": "PM",
        "isActive": true
    }
]

 */