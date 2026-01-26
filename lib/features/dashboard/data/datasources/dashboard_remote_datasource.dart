import 'package:dio/dio.dart';
import 'package:riderapp/core/network/api_endpoints.dart';
import '../models/dashboard_model.dart';

abstract class DashboardRemoteDataSource {
  Future<DashboardModel> getDashboard(String token);
}

class DashboardRemoteDataSourceImpl implements DashboardRemoteDataSource {
  final Dio dio;

  DashboardRemoteDataSourceImpl(this.dio);

  @override
  Future<DashboardModel> getDashboard(String token) async {
    final response = await dio.get(
      ApiEndpoints.dashboard,
      options: Options(headers: {
        'Authorization': 'Bearer $token',
      }),
    );

    return DashboardModel.fromJson(response.data);
  }
}
