abstract class OrdersEvent {}

class LoadAvailableOrders extends OrdersEvent {}

class LoadMyOrders extends OrdersEvent {}

class AcceptOrderEvent extends OrdersEvent {
  final String id;

  AcceptOrderEvent(this.id);
}

class PickupOrderEvent extends OrdersEvent {
  final String id;

  PickupOrderEvent(this.id);
}

class VerifyDeliveryEvent extends OrdersEvent {
  final String id;
  final String otp;

  VerifyDeliveryEvent(this.id, this.otp);
}
