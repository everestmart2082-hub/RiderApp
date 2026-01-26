class OrderEntity {
  final String id;
  final String customerName;
  final String address;
  final double amount;
  final String status;
  final String otp;

  OrderEntity({
    required this.id,
    required this.customerName,
    required this.address,
    required this.amount,
    required this.status,
    required this.otp,
  });
}
