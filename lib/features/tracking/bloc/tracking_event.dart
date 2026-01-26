
import '../domain/entities/location_entity.dart';

abstract class TrackingEvent {}

class StartTracking extends TrackingEvent {}

class StopTracking extends TrackingEvent {}

class LocationChanged extends TrackingEvent {
  final LocationEntity location;

  LocationChanged(this.location);
}
