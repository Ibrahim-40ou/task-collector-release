import 'package:tasks_collector/resources/features/map/data/repositories/map_repository_impl.dart';

import '../../../../core/utils/result.dart';


class FetchPlacesUseCase {
  final MapRepositoryImpl mapRepositoryImpl;

  FetchPlacesUseCase({required this.mapRepositoryImpl});

  Future<Result<void>> call(String placeName) async {
    return await mapRepositoryImpl.fetchPlaces(placeName);
  }
}
