
import '../domain/entities/rider_entity.dart';

abstract class AuthState {}

class AuthInitial extends AuthState {}

class AuthLoading extends AuthState {}

class AuthAuthenticated extends AuthState {
  final RiderEntity rider;

  AuthAuthenticated(this.rider);
}

class AuthSuccess extends AuthState {}

class AuthError extends AuthState {
  final String message;

  AuthError(this.message);
}
