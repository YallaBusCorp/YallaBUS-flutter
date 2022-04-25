import 'package:yalla_bus/core/exceptions/exception.dart';
import 'package:yalla_bus/core/network/network_info.dart';
import 'package:yalla_bus/features/choose_company/data/data_sources/remote_data_source.dart';
import 'package:yalla_bus/features/choose_company/data/model/company_converters.dart';
import 'package:yalla_bus/features/choose_company/domain/enitity/company.dart';
import 'package:yalla_bus/core/failure/failure.dart';
import 'package:dartz/dartz.dart';
import 'package:yalla_bus/features/choose_company/domain/repository/company_repository.dart';
import 'package:yalla_bus/features/home/data/model/map_json_converters.dart';
import 'package:yalla_bus/features/home/domain/enitity/appoinment.dart';
import 'package:yalla_bus/features/home/domain/enitity/map_point.dart';
import 'package:yalla_bus/features/home/domain/use_case/get_appoinments_of_am.dart';

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
  Future<Either<Failure, List<MapPoint>>> getMapDropDownPoints(int id) async {
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
  Future<Either<Failure, List<MapPoint>>> getMapPickUpPoints(int id) async {
    if (await info.isConnected()) {
      try {
        result = await client.getMapDropDownPoints(id);
        dropDownPoints = result.map((e) => MapPointsModel.fromJson(e)).toList();
        return Right(dropDownPoints);
      } on ServerException {
        return Left(Failure('Try Again in another time'));
      }
    } else {
      return Left(Failure("You don't have access to internet!"));
    }
  }
}
