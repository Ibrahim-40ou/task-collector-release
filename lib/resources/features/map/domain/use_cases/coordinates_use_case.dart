import 'package:tasks_collector/resources/features/map/data/repositories/map_repository_impl.dart';

import '../../../../core/utils/result.dart';


class FetchCoordinatesUseCase {
  final MapRepositoryImpl mapRepositoryImpl;

  FetchCoordinatesUseCase({required this.mapRepositoryImpl});

  Future<Result<void>> call(String placeID) async {
    return await mapRepositoryImpl.fetchLatLng(placeID);
  }
}
