
import '../../../order/data/model/order_model.dart';
import '../../domain/entities/dashboard_entity.dart';

class DashboardModel extends DashboardEntity {
  DashboardModel({
    required super.todayEarnings,
    required super.totalEarnings,
    required super.completedOrders,
    required super.ongoingOrders,
    required super.recentOrders,
  });

  factory DashboardModel.fromJson(Map<String, dynamic> json) {
    return DashboardModel(
      todayEarnings: (json['todayEarnings'] ?? 0).toDouble(),
      totalEarnings: (json['totalEarnings'] ?? 0).toDouble(),
      completedOrders: json['completedOrders'] ?? 0,
      ongoingOrders: json['ongoingOrders'] ?? 0,
      recentOrders: (json['recentOrders'] as List? ?? [])
          .map((e) => OrderModel.fromJson(e))
          .toList(),
    );
  }
}
