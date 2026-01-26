import '../../domain/entities/location_entity.dart';

class LocationModel extends LocationEntity {
  LocationModel({
    required super.latitude,
    required super.longitude,
  });

  Map<String, dynamic> toJson() {
    return {
      'latitude': latitude,
      'longitude': longitude,
    };
  }
}
