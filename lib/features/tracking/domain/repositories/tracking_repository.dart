import 'package:riderapp/core/storage/local_storage.dart';

import '../../data/datasources/tracking_remote_datasource.dart';
import '../../data/models/location_model.dart';
import '../entities/location_entity.dart';

abstract class TrackingRepository {
  Future<void> updateLocation(LocationEntity location);
}


class TrackingRepositoryImpl implements TrackingRepository {
  final TrackingRemoteDataSource remote;

  TrackingRepositoryImpl(this.remote);

  @override
  Future<void> updateLocation(LocationEntity location) async {
    final token = await LocalStorage.load();
    final model = LocationModel(
      latitude: location.latitude,
      longitude: location.longitude,
    );

    await remote.updateLocation(model, token!);
  }
}
