import '../entities/rider_entity.dart';
import '../repository/auth_repository.dart';

class LoginUseCase {
  final AuthRepository repository;

  LoginUseCase(this.repository);

  Future<RiderEntity> call(String email, String password) {
    return repository.login(email: email, password: password);
  }
}
