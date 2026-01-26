import 'package:riderapp/core/storage/local_storage.dart';

import '../../data/datasources/availability_remote_datasource.dart';

abstract class AvailabilityRepository {
  Future<bool> updateAvailability(bool isOnline);
}


class AvailabilityRepositoryImpl implements AvailabilityRepository {
  final AvailabilityRemoteDataSource remote;

  AvailabilityRepositoryImpl(this.remote);

  @override
  Future<bool> updateAvailability(bool isOnline) async {
    final token = await LocalStorage.load();
    return remote.updateAvailability(token!, isOnline);
  }
}
