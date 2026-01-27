import 'package:dio/dio.dart';
import 'package:riderapp/core/network/api_endpoints.dart';
import '../models/rider_model.dart';

abstract class AuthRemoteDataSource {
  Future<(RiderModel, String)> login(String email, String password);
  Future<void> registerWithDocuments(
      Map<String, dynamic> data, Map<String, dynamic> files);
  Future<RiderModel> getProfile(String token);
}

class AuthRemoteDataSourceImpl implements AuthRemoteDataSource {
  final Dio dio;

  AuthRemoteDataSourceImpl(this.dio);

  @override
  Future<(RiderModel, String)> login(String email, String password) async {
    final response = await dio.post(
      ApiEndpoints.login,
      data: {'email': email, 'password': password},
    );

    final rider = RiderModel.fromJson(response.data['rider']);
    final token = response.data['token'] as String;

    return (rider, token);
  }

  @override
  Future<void> registerWithDocuments(
      Map<String, dynamic> data, Map<String, dynamic> files) async {
    final formData = FormData.fromMap({
      ...data,
      ...files.map((k, v) => MapEntry(
            k,
            MultipartFile.fromFileSync(v),
          )),
    });

    await dio.post(ApiEndpoints.registerWithDocuments, data: formData,options: Options(
      contentType: 'multipart/form-data',
    ),);
  }

  @override
  Future<RiderModel> getProfile(String token) async {
    final response = await dio.get(
      ApiEndpoints.me,
      options: Options(headers: {'Authorization': 'Bearer $token'}),
    );

    return RiderModel.fromJson(response.data);
  }
}
