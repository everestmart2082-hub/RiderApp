import 'package:dio/dio.dart';
import 'package:riderapp/core/network/api_endpoints.dart';

import '../model/profile_model.dart';


abstract class ProfileRemoteDataSource {
  Future<ProfileModel> getProfile(String token);
}

class ProfileRemoteDataSourceImpl implements ProfileRemoteDataSource {
  final Dio dio;

  ProfileRemoteDataSourceImpl(this.dio);

  @override
  Future<ProfileModel> getProfile(String token) async {
    final response = await dio.get(
      ApiEndpoints.me,
      options: Options(
        headers: {'Authorization': 'Bearer $token'},
      ),
    );

    return ProfileModel.fromJson(response.data);
  }
}
