import 'package:flutter_bloc/flutter_bloc.dart';
import '../domain/usecases/get_profile_usecases.dart';
import 'profile_event.dart';
import 'profile_state.dart';

class ProfileBloc extends Bloc<ProfileEvent, ProfileState> {
  final GetProfileUseCase getProfileUseCase;

  ProfileBloc(this.getProfileUseCase) : super(ProfileInitial()) {
    on<LoadProfileRequested>(_loadProfile);
  }

  Future<void> _loadProfile(
      LoadProfileRequested event, Emitter<ProfileState> emit) async {
    emit(ProfileLoading());
    try {
      final profile = await getProfileUseCase();
      emit(ProfileLoaded(profile));
    } catch (e) {
      emit(ProfileError(e.toString()));
    }
  }
}
