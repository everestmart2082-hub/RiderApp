
import '../repository/auth_repository.dart';

class RegisterUseCase {
  final AuthRepository repository;

  RegisterUseCase(this.repository);

  Future<void> call({
    required Map<String, dynamic> data,
    required Map<String, dynamic> files,
  }) {
    return repository.registerWithDocuments(data: data, files: files);
  }
}
