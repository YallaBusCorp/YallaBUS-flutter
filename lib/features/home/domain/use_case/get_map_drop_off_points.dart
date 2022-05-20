import 'package:dartz/dartz.dart';
import '../../../../core/states/state.dart';
import '../enitity/map_point.dart';
import '../repository/map_repository.dart';


class GetMapDropOffPoints {
  final MapRepository repo;

  GetMapDropOffPoints(this.repo);
  Future<Either<Failure, List<MapPoint>>> getMapDropOffPoints(int id) async {
    return await repo.getMapDropOffPoints(id);
  }
}
