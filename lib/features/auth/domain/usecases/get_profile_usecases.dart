import '../entities/rider_entity.dart';
import '../repository/auth_repository.dart';

class GetAuthProfileUseCase {
  final AuthRepository repository;

  GetAuthProfileUseCase(this.repository);

  Future<RiderEntity> call() {
    return repository.getProfile();
  }
}
