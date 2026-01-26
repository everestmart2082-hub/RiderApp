

import '../repositories/order_repository.dart';

class AcceptOrder {
  final OrdersRepository repo;

  AcceptOrder(this.repo);

  Future<void> call(String id) {
    return repo.acceptOrder(id);
  }
}
