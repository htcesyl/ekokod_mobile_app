import '../entities/building_entity.dart';

abstract class IBuildingRepository {
  Future<List<BuildingEntity>> getBuildings();
}
