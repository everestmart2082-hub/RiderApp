import '../entities/order_entity.dart';
import '../repositories/order_repository.dart';

class GetAvailableOrders {
  final OrdersRepository repo;

  GetAvailableOrders(this.repo);

  Future<List<OrderEntity>> call() {
    return repo.getAvailableOrders();
  }
}
