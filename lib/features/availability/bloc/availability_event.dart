abstract class AvailabilityEvent {}

class AvailabilityToggled extends AvailabilityEvent {
  final bool isOnline;

  AvailabilityToggled(this.isOnline);
}
