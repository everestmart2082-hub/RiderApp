import 'package:flutter_bloc/flutter_bloc.dart';
import '../domain/usecases/get_profile_usecases.dart';
import '../domain/usecases/login_usecases.dart';
import '../domain/usecases/logout_usecases.dart';
import '../domain/usecases/register_usecases.dart';
import 'auth_event.dart';
import 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final LoginUseCase loginUseCase;
  final RegisterUseCase registerUseCase;
  final GetProfileUseCase getProfileUseCase;
  final LogoutUseCase logoutUseCase;

  AuthBloc({
    required this.loginUseCase,
    required this.registerUseCase,
    required this.getProfileUseCase,
    required this.logoutUseCase,
  }) : super(AuthInitial()) {
    on<LoginRequested>(_login);
    on<RegisterRequested>(_register);
    on<LoadProfileRequested>(_loadProfile);
    on<LogoutRequested>(_logout);
  }

  Future<void> _login(LoginRequested e, Emitter<AuthState> emit) async {
    emit(AuthLoading());
    try {
      final rider = await loginUseCase(e.email, e.password);
      emit(AuthAuthenticated(rider));
    } catch (err) {
      emit(AuthError(err.toString()));
    }
  }

  Future<void> _register(RegisterRequested e, Emitter<AuthState> emit) async {
    emit(AuthLoading());
    try {
      await registerUseCase(data: e.data, files: e.files);
      emit(AuthSuccess());
    } catch (err) {
      emit(AuthError(err.toString()));
    }
  }

  Future<void> _loadProfile(
      LoadProfileRequested e, Emitter<AuthState> emit) async {
    emit(AuthLoading());
    try {
      final rider = await getProfileUseCase();
      emit(AuthAuthenticated(rider));
    } catch (err) {
      emit(AuthError(err.toString()));
    }
  }

  Future<void> _logout(LogoutRequested e, Emitter<AuthState> emit) async {
    await logoutUseCase();
    emit(AuthInitial());
  }
}
