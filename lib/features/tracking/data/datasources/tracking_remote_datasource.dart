import 'package:dio/dio.dart';
import 'package:riderapp/core/network/api_endpoints.dart';
import '../models/location_model.dart';

abstract class TrackingRemoteDataSource {
  Future<void> updateLocation(LocationModel model, String token);
}

class TrackingRemoteDataSourceImpl implements TrackingRemoteDataSource {
  final Dio dio;

  TrackingRemoteDataSourceImpl(this.dio);

  @override
  Future<void> updateLocation(LocationModel model, String token) async {
    await dio.post(
      ApiEndpoints.updateLocation,
      data: model.toJson(),
      options: Options(headers: {
        'Authorization': 'Bearer $token',
      }),
    );
  }
}
