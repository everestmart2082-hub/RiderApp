import '../entities/order_entity.dart';
import '../repositories/order_repository.dart';

class GetMyOrders {
  final OrdersRepository repo;

  GetMyOrders(this.repo);

  Future<List<OrderEntity>> call() {
    return repo.getMyOrders();
  }
}
