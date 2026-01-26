import 'package:riderapp/core/storage/local_storage.dart';

import '../../data/datasources/dashboard_remote_datasource.dart';
import '../entities/dashboard_entity.dart';

abstract class DashboardRepository {
  Future<DashboardEntity> getDashboard();
}


class DashboardRepositoryImpl implements DashboardRepository {
  final DashboardRemoteDataSource remote;

  DashboardRepositoryImpl(this.remote);

  @override
  Future<DashboardEntity> getDashboard() async {
    final token = await LocalStorage.load();
    return remote.getDashboard(token!);
  }
}
