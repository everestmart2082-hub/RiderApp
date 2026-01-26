import '../../domain/entities/order_entity.dart';

class OrderModel extends OrderEntity {
  OrderModel({
    required super.id,
    required super.customerName,
    required super.address,
    required super.amount,
    required super.status,
    required super.otp,
  });

  factory OrderModel.fromJson(Map<String, dynamic> json) {
    return OrderModel(
      id: json['_id'],
      customerName: json['customerName'] ?? '',
      address: json['deliveryAddress'] ?? '',
      amount: (json['amount'] ?? 0).toDouble(),
      status: json['status'] ?? '',
      otp: json['otp'] ?? '',
    );
  }
}
