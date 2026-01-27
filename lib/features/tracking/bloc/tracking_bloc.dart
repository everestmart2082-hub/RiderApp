import 'dart:async';
import 'package:geolocator/geolocator.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../domain/entities/location_entity.dart';
import '../domain/usecases/update_location_usecases.dart';
import 'tracking_event.dart';
import 'tracking_state.dart';

class TrackingBloc extends Bloc<TrackingEvent, TrackingState> {
  final UpdateLocationUseCase updateLocationUseCase;
  StreamSubscription<Position>? _sub;

  TrackingBloc(this.updateLocationUseCase) : super(TrackingInitial()) {
    on<StartTracking>(_start);
    on<StopTracking>(_stop);
    on<LocationChanged>(_onLocationChanged);
  }

  Future<void> _start(StartTracking event, Emitter<TrackingState> emit) async {
    bool serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      emit(TrackingError("Location disabled"));
      return;
    }

    LocationPermission permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
    }

    if (permission == LocationPermission.deniedForever) {
      emit(TrackingError("Permission denied"));
      return;
    }

    _sub?.cancel();

    _sub = Geolocator.getPositionStream(
      locationSettings: const LocationSettings(
        accuracy: LocationAccuracy.high,
        distanceFilter: 20,
      ),
    ).listen((pos) {
      add(LocationChanged(
        LocationEntity(latitude: pos.latitude, longitude: pos.longitude),
      ));
    });

    emit(TrackingRunning());
  }

  Future<void> _stop(StopTracking event, Emitter<TrackingState> emit) async {
    await _sub?.cancel();
    _sub = null;
    emit(TrackingStopped());
  }

  Future<void> _onLocationChanged(
      LocationChanged event, Emitter<TrackingState> emit) async {
    try {
      await updateLocationUseCase(event.location);
    } catch (e) {
      emit(TrackingError(e.toString()));
    }
  }

  @override
  Future<void> close() {
    _sub?.cancel();
    return super.close();
  }
}
