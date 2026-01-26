import 'package:flutter_bloc/flutter_bloc.dart';
import '../domain/usecases/update_availability.dart';
import 'availability_event.dart';
import 'availability_state.dart';

class AvailabilityBloc extends Bloc<AvailabilityEvent, AvailabilityState> {
  final UpdateAvailabilityUseCase useCase;

  AvailabilityBloc(this.useCase) : super(AvailabilityInitial()) {
    on<AvailabilityToggled>(_toggle);
  }

  Future<void> _toggle(
      AvailabilityToggled event, Emitter<AvailabilityState> emit) async {
    emit(AvailabilityLoading());
    try {
      final result = await useCase(event.isOnline);
      emit(AvailabilityUpdated(result));
    } catch (e) {
      emit(AvailabilityError(e.toString()));
    }
  }
}
