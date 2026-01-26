

import '../repositories/order_repository.dart';

class VerifyDelivery {
  final OrdersRepository repo;

  VerifyDelivery(this.repo);

  Future<void> call(String id, String otp) {
    return repo.verifyDelivery(id, otp);
  }
}
