import '../../../../home/domain/enitity/appoinment.dart';
import '../../../../home/domain/enitity/map_point.dart';
import '../../../../settings/domain/entity/ride_history_model.dart';

class Booking {
  final Appoinment appoinment;
  final MapPoint pickUp;
  final MapPoint dropOff;
  final TxRide ride;

  Booking(this.appoinment, this.pickUp, this.dropOff, this.ride);
}

// 11 -> 19

/* [
    {
        "id": 21,
        "bookingData": "2022-06-28T20:05:15",
        "isScanned": false,
        "qrCode": "08:00AM/1nUUE8aULtZ2UOn3n2AlsU7EiC83",
        "appointment": {
            "id": 7,
            "company": {
                "id": 1
            },
            "appointmentStartTime": "08:00:00",
            "appointmentType": "AM",
            "isActive": true
        },
        "bus": {
            "id": 8,
            "busUid": "Jgy5ZUYY1zZSVn8JDeeJ8yYY9R13",
            "phone": "+201222222223",
            "model": "Yasser Bus",
            "capacity": 25,
            "busLicenceNumber": "dsadsa",
            "busLicenceExpirationDate": "2024-10-16",
            "busLicenceExpirationDateAlarm": "2024-09-16",
            "company": {
                "id": 1
            },
            "isActive": true
        },
        "dropoffPoint": {
            "id": 61,
            "mapPointTitleEn": "aCaollege",
            "mapPointTitleAr": "كولدج",
            "mapPointType": "D",
            "longitude": 31.35961217,
            "latitude": 31.02162391,
            "company": {
                "id": 1
            },
            "isActive": true
        },
        "emp": {
            "id": 14,
            "company": {
                "id": 1
            },
            "empCode": "456",
            "empName": "مصطفي ابراهيم عبدالباسط",
            "empPhone": "01222222551",
            "empNationalId": "30006660500088",
            "empSalary": 4444,
            "empLk": {
                "id": 3,
                "lkName": "driver"
            },
            "empStartDate": "2022-07-10",
            "empEndDate": null
        },
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
        "std": {
            "id": 16,
            "company": {
                "id": 1
            },
            "town": {
                "id": 6,
                "company": {
                    "id": 1
                },
                "townName": "منية النصر",
                "isActive": true
            },
            "university": {
                "id": 5,
                "company": {
                    "id": 1
                },
                "universityName": "النيل",
                "isActive": true
            },
            "stdName": "Kareem  Adel",
            "stdPhone": "+201234567893",
            "endSubscriptionDate": null,
            "isSubscribed": null,
            "stdUid": "1nUUE8aULtZ2UOn3n2AlsU7EiC83",
            "isActive": true
        },
        "txRide": {
            "id": 158,
            "rideData": "2022-06-29",
            "rideStatus": "process",
            "appointment": {
                "id": 7,
                "company": {
                    "id": 1
                },
                "appointmentStartTime": "08:00:00",
                "appointmentType": "AM",
                "isActive": true
            },
            "bus": {
                "id": 8,
                "busUid": "Jgy5ZUYY1zZSVn8JDeeJ8yYY9R13",
                "phone": "+201222222223",
                "model": "Yasser Bus",
                "capacity": 25,
                "busLicenceNumber": "dsadsa",
                "busLicenceExpirationDate": "2024-10-16",
                "busLicenceExpirationDateAlarm": "2024-09-16",
                "company": {
                    "id": 1
                },
                "isActive": true
            },
            "emp": {
                "id": 14,
                "company": {
                    "id": 1
                },
                "empCode": "456",
                "empName": "مصطفي ابراهيم عبدالباسط",
                "empPhone": "01222222551",
                "empNationalId": "30006660500088",
                "empSalary": 4444,
                "empLk": {
                    "id": 3,
                    "lkName": "driver"
                },
                "empStartDate": "2022-07-10",
                "empEndDate": null
            }
        }
    }
]
*/