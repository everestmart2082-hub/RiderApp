import 'package:riderapp/core/storage/local_storage.dart';

import '../../data/datasources/order_remote_datasource.dart';
import '../entities/order_entity.dart';

abstract class OrdersRepository {
  Future<List<OrderEntity>> getAvailableOrders();
  Future<List<OrderEntity>> getMyOrders();
  Future<void> acceptOrder(String id);
  Future<void> pickupOrder(String id);
  Future<void> verifyDelivery(String id, String otp);
}


class OrdersRepositoryImpl implements OrdersRepository {
  final OrdersRemoteDataSource remote;

  OrdersRepositoryImpl(this.remote);

  @override
  Future<List<OrderEntity>> getAvailableOrders() async {
    final token = await LocalStorage.load();
    return remote.getAvailableOrders(token!);
  }

  @override
  Future<List<OrderEntity>> getMyOrders() async {
    final token = await LocalStorage.load();
    return remote.getMyOrders(token!);
  }

  @override
  Future<void> acceptOrder(String id) async {
    final token = await LocalStorage.load();
    await remote.acceptOrder(token!, id);
  }

  @override
  Future<void> pickupOrder(String id) async {
    final token = await LocalStorage.load();
    await remote.pickupOrder(token!, id);
  }

  @override
  Future<void> verifyDelivery(String id, String otp) async {
    final token = await LocalStorage.load();
    await remote.verifyDelivery(token!, id, otp);
  }
}
