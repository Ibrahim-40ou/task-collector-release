import '../../../../core/utils/result.dart';
import '../../data/repositories/auth_repository_impl.dart';

class FetchGovernoratesUseCase {
  final AuthRepositoryImpl authRepositoryImpl;

  FetchGovernoratesUseCase({required this.authRepositoryImpl});

  Future<Result<void>> call() async {
    return await authRepositoryImpl.fetchGovernorates();
  }
}
