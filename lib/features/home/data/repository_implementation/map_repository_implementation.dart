import 'package:yalla_bus/features/home/domain/enitity/reschedule_body.dart';
import 'package:yalla_bus/features/settings/data/model/settings_model_converters.dart';
import 'package:yalla_bus/features/settings/domain/entity/ride_history_model.dart';

import '../../../../core/exceptions/exception.dart';
import '../../../../core/network/network_info.dart';
import 'package:dartz/dartz.dart';
import '../../../../core/states/state.dart';
import '../../domain/enitity/returned_ride.dart';
import '../../domain/enitity/ride.dart';
import '../model/map_json_converters.dart';
import '../../domain/enitity/appoinment.dart';
import '../../domain/enitity/map_point.dart';
import '../../domain/repository/map_repository.dart';
import '../data_sources/remote_data_source.dart';

class MapRepositoryImplementation extends MapRepository {
  late List<dynamic> result;
  late List<Appoinment> appoinmentAm;
  late List<Appoinment> appoinmentPm;
  late List<MapPoint> dropDownPoints;
  late List<MapPoint> pickUpPoints;

  final MapApiClient client;
  final NetworkInfo info;

  MapRepositoryImplementation(this.client, this.info);

  @override
  Future<Either<Failure, List<Appoinment>>> getAppoinmentsOfAM(int id) async {
    if (await info.isConnected()) {
      try {
        result = await client.getAppointmentsAM(id);
        appoinmentAm = result.map((e) => AppointmentModel.fromJson(e)).toList();
        return Right(appoinmentAm);
      } on ServerException {
        return Left(Failure('Try Again in another time'));
      }
    } else {
      // Edit This
      return Left(Failure("You don't have access to internet!"));
    }
  }

  @override
  Future<Either<Failure, List<Appoinment>>> getAppoinmentsOfPM(int id) async {
    if (await info.isConnected()) {
      try {
        result = await client.getAppointmentsPM(id);
        appoinmentPm = result.map((e) => AppointmentModel.fromJson(e)).toList();
        return Right(appoinmentPm);
      } on ServerException {
        return Left(Failure('Try Again in another time'));
      }
    } else {
      // Edit This
      return Left(Failure("You don't have access to internet!"));
    }
  }

  @override
  Future<Either<Failure, List<MapPoint>>> getMapDropOffPoints(int id) async {
    if (await info.isConnected()) {
      try {
        result = await client.getMapDropOffPoints(id);
        dropDownPoints = result.map((e) => MapPointsModel.fromJson(e)).toList();
        return Right(dropDownPoints);
      } on ServerException {
        return Left(Failure('Try Again in another time'));
      }
    } else {
      return Left(Failure("You don't have access to internet!"));
    }
  }

  @override
  Future<Either<Failure, List<MapPoint>>> getMapPickUpPoints(int id) async {
    if (await info.isConnected()) {
      try {
        result = await client.getMapPickUpPoints(id);
        pickUpPoints = result.map((e) => MapPointsModel.fromJson(e)).toList();
        return Right(pickUpPoints);
      } on ServerException {
        return Left(Failure('Try Again in another time'));
      }
    } else {
      return Left(Failure("You don't have access to internet!"));
    }
  }

  @override
  Future<Either<Failure, int>> bookRide(Ride ride) async {
    if (await info.isConnected()) {
      try {
        return Right(await client.bookRide(ride));
      } on ServerException {
        return Left(Failure('Try Again in another time'));
      }
    } else {
      return Left(Failure("You don't have access to internet!"));
    }
  }

  @override
  Future<Either<Failure, ReturenedRide>> getCurrentRide(String uid) async {
    if (await info.isConnected()) {
      try {
        final result = await client.getCurrentRideByUID(uid);
        if (result == 500) {
          return Right(ReturenedRideModel.fromJson({}));
        } else {
          return Right(ReturenedRideModel.fromJson(result));
        }
      } on ServerException {
        return Left(Failure('Try Again in another time'));
      }
    } else {
      return Left(Failure("You don't have access to internet!"));
    }
  }

  @override
  Future<Either<Failure, bool>> cancelRide(int bookingID) async {
    if (await info.isConnected()) {
      try {
        final result = await client.cancelRide(bookingID);
        return Right(result);
      } on ServerException {
        return Left(Failure('Try Again in another time'));
      }
    } else {
      return Left(Failure("You don't have access to internet!"));
    }
  }

  @override
  Future<Either<Failure, StudentID>> getStudentID(String uid) async {
    if (await info.isConnected()) {
      try {
        final data = await client.getStudentId(uid);
        return Right(StudentIdModel.fromJson(data));
      } on ServerException {
        return Left(Failure('Try Again in another time'));
      }
    } else {
      return Left(Failure("You don't have access to internet!"));
    }
  }

  @override
  Future<Either<Failure, RideHis>> rescheduleRide(Reschedule r) async {
    if (await info.isConnected()) {
      try {
        final data = await client.rescheduleRide(r);
        return Right(RideHisModel.fromJson(data));
      } on ServerException {
        return Left(Failure('Try Again in another time'));
      }
    } else {
      return Left(Failure("You don't have access to internet!"));
    }
  }
}
