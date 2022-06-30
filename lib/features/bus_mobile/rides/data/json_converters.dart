import 'package:yalla_bus/features/bus_mobile/rides/domain/entity/all_rides.dart';
import 'package:yalla_bus/features/home/data/model/map_json_converters.dart';
import 'package:yalla_bus/features/home/domain/enitity/appoinment.dart';
import 'package:yalla_bus/features/settings/data/model/settings_model_converters.dart';
import 'package:yalla_bus/features/settings/domain/entity/ride_history_model.dart';
import 'package:yalla_bus/features/home/domain/enitity/map_point.dart';

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
