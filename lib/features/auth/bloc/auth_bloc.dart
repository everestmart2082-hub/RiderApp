import 'package:dio/dio.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:riderapp/core/network/api_endpoints.dart';
import 'package:riderapp/features/auth/data/datasources/auth_remote_datasource.dart';
import 'package:riderapp/features/auth/domain/entities/rider_entity.dart';
import 'package:riderapp/features/auth/domain/repository/auth_repository.dart';
import '../domain/usecases/get_profile_usecases.dart';
import '../domain/usecases/login_usecases.dart';
import '../domain/usecases/logout_usecases.dart';
import '../domain/usecases/register_usecases.dart';
import 'auth_event.dart';
import 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final LoginUseCase loginUseCase;
  final RegisterUseCase registerUseCase;
  final GetAuthProfileUseCase getProfileUseCase;
  final LogoutUseCase logoutUseCase;
  final authRepository = AuthRepositoryImpl(AuthRemoteDataSourceImpl(Dio(
    BaseOptions(
      baseUrl: ApiEndpoints.baseUrl,
      connectTimeout: const Duration(seconds: 10),
      receiveTimeout: const Duration(seconds: 10),
    )
  )));

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
    on<AuthCheckRequested>((event, emit)async {
      emit(AuthLoading());

      final loggedIn = authRepository.isLoggedIn();
      if (!loggedIn) {
        emit(AuthUnauthenticated());
        return;
      }

      try {
        RiderEntity rider = await authRepository.getProfile();
        emit(AuthAuthenticated(rider));
      } catch (e) {
        emit(AuthUnauthenticated());
      }
    },);
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
