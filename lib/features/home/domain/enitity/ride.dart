class Ride {
  final String qrCode;
  final PickUpPoint pickupPoint;
  final DropOffPoint dropOffPoint;
  final Appointments appointment;
  final StudentID std;

  Ride(
      {required this.qrCode,
      required this.pickupPoint,
      required this.dropOffPoint,
      required this.appointment,
      required this.std});
}

class PickUpPoint {
  final int id;

  PickUpPoint(this.id);
}

class DropOffPoint {
  final int id;

  DropOffPoint(this.id);
}

class Appointments {
  final int id;

  Appointments(this.id);
}

class StudentID {
  final int id;
  StudentID(this.id);
}


// Response of book ride 
/* 
{
    "id": 4,
    "qrCode": "piviviviviviviv23",
    "isScanned": false,
    "bookingData": "2022-06-24T15:02:05.382",
    "emp": null,
    "pickupPoint": {
        "id": 17,
        "mapPointTitleEn": "Beshla",
        "mapPointTitleAr": "بشلا",
        "mapPointType": "P",
        "longitude": 31.259078,
        "latitude": 30.773347,
        "company": {
            "id": 1
        },
        "isActive": true
    },
    "dropoffPoint": {
        "id": 27,
        "mapPointTitleEn": "Elslap",
        "mapPointTitleAr": "معهد السلاب",
        "mapPointType": "D",
        "longitude": 31.377755,
        "latitude": 31.015205,
        "company": {
            "id": 1
        },
        "isActive": true
    },
    "appointment": {
        "id": 3,
        "company": {
            "id": 1
        },
        "appointmentStartTime": "10:15:00",
        "appointmentType": "PM",
        "isActive": true
    },
    "bus": null,
    "std": {
        "id": 8,
        "company": {
            "id": 1
        },
        "town": {
            "id": 2,
            "company": {
                "id": 1
            },
            "townName": "فيشا",
            "isActive": true
        },
        "university": {
            "id": 1,
            "company": {
                "id": 1
            },
            "universityName": "السلاب",
            "isActive": true
        },
        "stdName": "Kareem  Mohamed ",
        "stdPhone": "+201019035005",
        "endSubscriptionDate": null,
        "isSubscribed": null,
        "stdUid": "LJ745gpqO4SpeN1XJXDEVxRGO3S2",
        "isActive": true
    }
}

*/