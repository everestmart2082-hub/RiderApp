
import '../domain/entities/order_entity.dart';

abstract class OrdersState {}

class OrdersInitial extends OrdersState {}

class OrdersLoading extends OrdersState {}

class OrdersLoaded extends OrdersState {
  final List<OrderEntity> orders;

  OrdersLoaded(this.orders);
}

class OrdersActionSuccess extends OrdersState {}

class OrdersError extends OrdersState {
  final String message;

  OrdersError(this.message);
}
