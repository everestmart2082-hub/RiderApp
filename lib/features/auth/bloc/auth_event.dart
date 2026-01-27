abstract class AuthEvent {}

class LoginRequested extends AuthEvent {
  final String email;
  final String password;

  LoginRequested(this.email, this.password);
}

class AuthCheckRequested extends AuthEvent{
  
}

class RegisterRequested extends AuthEvent {
  final Map<String, dynamic> data;
  final Map<String, dynamic> files;

  RegisterRequested(this.data, this.files);
}

class LoadProfileRequested extends AuthEvent {}

class LogoutRequested extends AuthEvent {}
