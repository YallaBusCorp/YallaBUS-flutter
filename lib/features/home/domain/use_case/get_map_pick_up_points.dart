import 'package:dartz/dartz.dart';
import '../../../../core/states/state.dart';
import '../enitity/map_point.dart';
import '../repository/map_repository.dart';

class GetMapPickUpPoints {
  final MapRepository repo;

  GetMapPickUpPoints(this.repo);
  Future<Either<Failure, List<MapPoint>>> getMapPickUpPoints(int id) async {
    return await repo.getMapPickUpPoints(id);
  }
}
