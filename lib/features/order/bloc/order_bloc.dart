import 'package:flutter_bloc/flutter_bloc.dart';
import '../domain/usecases/accept_order.dart';
import '../domain/usecases/get_available_orders.dart';
import '../domain/usecases/get_my_order.dart';
import '../domain/usecases/place_order.dart';
import '../domain/usecases/verify_order.dart';
import 'order_event.dart';
import 'order_state.dart';


class OrdersBloc extends Bloc<OrdersEvent, OrdersState> {
  final GetAvailableOrders getAvailable;
  final GetMyOrders getMyOrders;
  final AcceptOrder acceptOrder;
  final PickupOrder pickupOrder;
  final VerifyDelivery verifyDelivery;

  OrdersBloc({
    required this.getAvailable,
    required this.getMyOrders,
    required this.acceptOrder,
    required this.pickupOrder,
    required this.verifyDelivery,
  }) : super(OrdersInitial()) {
    on<LoadAvailableOrders>(_loadAvailable);
    on<LoadMyOrders>(_loadMy);
    on<AcceptOrderEvent>(_accept);
    on<PickupOrderEvent>(_pickup);
    on<VerifyDeliveryEvent>(_verify);
  }

  Future<void> _loadAvailable(
      LoadAvailableOrders event, Emitter<OrdersState> emit) async {
    emit(OrdersLoading());
    try {
      final orders = await getAvailable();
      emit(OrdersLoaded(orders));
    } catch (e) {
      emit(OrdersError(e.toString()));
    }
  }

  Future<void> _loadMy(
      LoadMyOrders event, Emitter<OrdersState> emit) async {
    emit(OrdersLoading());
    try {
      final orders = await getMyOrders();
      emit(OrdersLoaded(orders));
    } catch (e) {
      emit(OrdersError(e.toString()));
    }
  }

  Future<void> _accept(
      AcceptOrderEvent event, Emitter<OrdersState> emit) async {
    emit(OrdersLoading());
    try {
      await acceptOrder(event.id);
      emit(OrdersActionSuccess());
    } catch (e) {
      emit(OrdersError(e.toString()));
    }
  }

  Future<void> _pickup(
      PickupOrderEvent event, Emitter<OrdersState> emit) async {
    emit(OrdersLoading());
    try {
      await pickupOrder(event.id);
      emit(OrdersActionSuccess());
    } catch (e) {
      emit(OrdersError(e.toString()));
    }
  }

  Future<void> _verify(
      VerifyDeliveryEvent event, Emitter<OrdersState> emit) async {
    emit(OrdersLoading());
    try {
      await verifyDelivery(event.id, event.otp);
      emit(OrdersActionSuccess());
    } catch (e) {
      emit(OrdersError(e.toString()));
    }
  }
}
