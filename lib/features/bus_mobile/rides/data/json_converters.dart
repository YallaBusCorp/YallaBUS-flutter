import '../domain/entity/all_rides.dart';
import '../../../home/data/model/map_json_converters.dart';
import '../../../home/domain/enitity/appoinment.dart';
import '../../../settings/data/model/settings_model_converters.dart';
import '../../../settings/domain/entity/ride_history_model.dart';
import '../../../home/domain/enitity/map_point.dart';

class BookingModel extends Booking {
  BookingModel(
      Appoinment appoinment, MapPoint pickUp, MapPoint dropOff, TxRide ride)
      : super(appoinment, pickUp, dropOff, ride);

  factory BookingModel.fromJson(Map<String, dynamic> json) {
    return BookingModel(
      AppointmentModel.fromJson(json['appointment']),
      MapPointsModel.fromJson(json['dropoffPoint']),
      MapPointsModel.fromJson(json['pickupPoint']),
      TxRideModel.fromJson(json['txRide']),
    );
  }
}
