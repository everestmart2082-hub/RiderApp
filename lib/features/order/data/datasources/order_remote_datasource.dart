import 'package:dio/dio.dart';
import 'package:riderapp/core/network/api_endpoints.dart';

import '../model/order_model.dart';

abstract class OrdersRemoteDataSource {
  Future<List<OrderModel>> getAvailableOrders(String token);
  Future<List<OrderModel>> getMyOrders(String token);
  Future<void> acceptOrder(String token, String id);
  Future<void> pickupOrder(String token, String id);
  Future<void> verifyDelivery(String token, String id, String otp);
}

class OrdersRemoteDataSourceImpl implements OrdersRemoteDataSource {
  final Dio dio;

  OrdersRemoteDataSourceImpl(this.dio);

  @override
  Future<List<OrderModel>> getAvailableOrders(String token) async {
    final response = await dio.get(
      ApiEndpoints.availableOrders,
      options: Options(headers: {'Authorization': 'Bearer $token'}),
    );

    return (response.data as List)
        .map((e) => OrderModel.fromJson(e))
        .toList();
  }

  @override
  Future<List<OrderModel>> getMyOrders(String token) async {
    final response = await dio.get(
      ApiEndpoints.myOrders,
      options: Options(headers: {'Authorization': 'Bearer $token'}),
    );

    return (response.data as List)
        .map((e) => OrderModel.fromJson(e))
        .toList();
  }

  @override
  Future<void> acceptOrder(String token, String id) async {
    await dio.post(
      ApiEndpoints.acceptOrder(id),
      options: Options(headers: {'Authorization': 'Bearer $token'}),
    );
  }

  @override
  Future<void> pickupOrder(String token, String id) async {
    await dio.post(
      ApiEndpoints.pickupOrder(id),
      options: Options(headers: {'Authorization': 'Bearer $token'}),
    );
  }

  @override
  Future<void> verifyDelivery(String token, String id, String otp) async {
    await dio.post(
      ApiEndpoints.verifyDelivery(id),
      data: {'otp': otp},
      options: Options(headers: {'Authorization': 'Bearer $token'}),
    );
  }
}
