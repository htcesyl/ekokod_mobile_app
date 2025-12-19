import 'package:ekokod_mobile_app/domain/entities/building_entity.dart';
import 'package:ekokod_mobile_app/domain/repositories/i_building_repository.dart';
import '../datasources/remote_building_datasource.dart';
import '../models/building_model.dart';

class BuildingRepositoryImpl implements IBuildingRepository {
  final RemoteBuildingDataSource remoteDataSource;

  BuildingRepositoryImpl(this.remoteDataSource);

  @override
  Future<List<BuildingEntity>> getBuildings() async {
    final response = await remoteDataSource.getBuildings();
    return response.buildings.map((model) => model.toEntity()).toList();
  }
}
