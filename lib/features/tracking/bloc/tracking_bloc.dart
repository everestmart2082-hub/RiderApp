import 'package:flutter_bloc/flutter_bloc.dart';
import '../domain/usecases/update_location_usecases.dart';
import 'tracking_event.dart';
import 'tracking_state.dart';

class TrackingBloc extends Bloc<TrackingEvent, TrackingState> {
  final UpdateLocationUseCase updateLocationUseCase;

  TrackingBloc(this.updateLocationUseCase) : super(TrackingInitial()) {
    on<StartTracking>((event, emit) {
      emit(TrackingRunning());
    });

    on<StopTracking>((event, emit) {
      emit(TrackingStopped());
    });

    on<LocationChanged>(_onLocationChanged);
  }

  Future<void> _onLocationChanged(
      LocationChanged event, Emitter<TrackingState> emit) async {
    try {
      await updateLocationUseCase(event.location);
    } catch (e) {
      emit(TrackingError(e.toString()));
    }
  }
}
