import 'package:riderapp/core/storage/local_storage.dart';

import '../../data/datasources/auth_remote_datasource.dart';
import '../entities/rider_entity.dart';

abstract class AuthRepository {
  Future<RiderEntity> login({
    required String email,
    required String password,
  });

  Future<void> registerWithDocuments({
    required Map<String, dynamic> data,
    required Map<String, dynamic> files,
  });

  Future<RiderEntity> getProfile();

  Future<void> logout();

  bool isLoggedIn();
}


class AuthRepositoryImpl implements AuthRepository {
  final AuthRemoteDataSource remote;

  AuthRepositoryImpl(this.remote);

  @override
  Future<RiderEntity> login(
      {required String email, required String password}) async {
    final result = await remote.login(email, password);
    final rider = result.$1;
    final token = result.$2;

    await LocalStorage.save(token);
    return rider;
  }

  @override
  bool isLoggedIn() {
    return LocalStorage.load() != "";
  }

  @override
  Future<void> registerWithDocuments(
      {required Map<String, dynamic> data,
      required Map<String, dynamic> files}) {
    return remote.registerWithDocuments(data, files);
  }

  @override
  Future<RiderEntity> getProfile() async {
    final token = await LocalStorage.load();
    return remote.getProfile(token!);
  }

  @override
  Future<void> logout() {
    return LocalStorage.clear();
  }
}