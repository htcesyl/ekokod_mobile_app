import 'package:ekokod_mobile_app/core/network/http_client.dart';
import 'package:ekokod_mobile_app/core/network/endpoints.dart';
import '../models/building_model.dart';

abstract class RemoteBuildingDataSource {
  Future<BuildingResponseModel> getBuildings();
}

class RemoteBuildingDataSourceImpl implements RemoteBuildingDataSource {
  final HttpClient httpClient;

  RemoteBuildingDataSourceImpl(this.httpClient);

  @override
  Future<BuildingResponseModel> getBuildings() async {
    final json = await httpClient.get(
      BuildingEndpoints.list,
    );

    return BuildingResponseModel.fromJson(json as Map<String, dynamic>);
  }
}
