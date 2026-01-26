abstract class TrackingState {}

class TrackingInitial extends TrackingState {}

class TrackingRunning extends TrackingState {}

class TrackingStopped extends TrackingState {}

class TrackingError extends TrackingState {
  final String message;

  TrackingError(this.message);
}
