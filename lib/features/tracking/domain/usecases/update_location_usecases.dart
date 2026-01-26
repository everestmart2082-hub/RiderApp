import '../entities/location_entity.dart';
import '../repositories/tracking_repository.dart';

class UpdateLocationUseCase {
  final TrackingRepository repository;

  UpdateLocationUseCase(this.repository);

  Future<void> call(LocationEntity location) {
    return repository.updateLocation(location);
  }
}
