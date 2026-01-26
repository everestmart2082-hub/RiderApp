abstract class AvailabilityState {}

class AvailabilityInitial extends AvailabilityState {}

class AvailabilityLoading extends AvailabilityState {}

class AvailabilityUpdated extends AvailabilityState {
  final bool isOnline;

  AvailabilityUpdated(this.isOnline);
}

class AvailabilityError extends AvailabilityState {
  final String message;

  AvailabilityError(this.message);
}
