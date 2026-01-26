import 'package:riderapp/core/storage/local_storage.dart';

import '../../data/datasources/profile_remote_datasources.dart';
import '../entities/profile_entity.dart';

abstract class ProfileRepository {
  Future<ProfileEntity> getProfile();
}

class ProfileRepositoryImpl implements ProfileRepository {
  final ProfileRemoteDataSource remote;

  ProfileRepositoryImpl(this.remote);

  @override
  Future<ProfileEntity> getProfile() async {
    final token = await LocalStorage.load();
    return remote.getProfile(token!);
  }
}
