import '../repositories/availability_repository.dart';

class UpdateAvailabilityUseCase {
  final AvailabilityRepository repository;

  UpdateAvailabilityUseCase(this.repository);

  Future<bool> call(bool isOnline) {
    return repository.updateAvailability(isOnline);
  }
}
