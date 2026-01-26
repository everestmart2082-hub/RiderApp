

import '../../../order/domain/entities/order_entity.dart';

class DashboardEntity {
  final double todayEarnings;
  final double totalEarnings;
  final int completedOrders;
  final int ongoingOrders;
  final List<OrderEntity> recentOrders;

  DashboardEntity({
    required this.todayEarnings,
    required this.totalEarnings,
    required this.completedOrders,
    required this.ongoingOrders,
    required this.recentOrders,
  });
}
