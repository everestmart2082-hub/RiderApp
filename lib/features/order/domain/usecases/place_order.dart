
import '../repositories/order_repository.dart';

class PickupOrder {
  final OrdersRepository repo;

  PickupOrder(this.repo);

  Future<void> call(String id) {
    return repo.pickupOrder(id);
  }
}
