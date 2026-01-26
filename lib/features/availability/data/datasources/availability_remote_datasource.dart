import 'package:dio/dio.dart';
import 'package:riderapp/core/network/api_endpoints.dart';

abstract class AvailabilityRemoteDataSource {
  Future<bool> updateAvailability(String token, bool isOnline);
}

class AvailabilityRemoteDataSourceImpl implements AvailabilityRemoteDataSource {
  final Dio dio;

  AvailabilityRemoteDataSourceImpl(this.dio);

  @override
  Future<bool> updateAvailability(String token, bool isOnline) async {
    final response = await dio.post(
      ApiEndpoints.availability,
      data: {'isOnline': isOnline},
      options: Options(headers: {
        'Authorization': 'Bearer $token',
      }),
    );

    return response.data['success'] ?? true;
  }
}
