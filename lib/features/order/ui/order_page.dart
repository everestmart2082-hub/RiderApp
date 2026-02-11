import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:riderapp/drawers.dart';
import 'package:riderapp/helper.dart';
import '../bloc/order_bloc.dart';
import '../bloc/order_event.dart';
import '../bloc/order_state.dart';
import '../domain/entities/order_entity.dart';

class OrdersPage extends StatefulWidget {
  const OrdersPage({super.key});

  @override
  State<OrdersPage> createState() => _OrdersPageState();
}

class _OrdersPageState extends State<OrdersPage>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);

    context.read<OrdersBloc>().add(LoadAvailableOrders());
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  void _loadTab(int index) {
    if (index == 0) {
      context.read<OrdersBloc>().add(LoadAvailableOrders());
    } else {
      context.read<OrdersBloc>().add(LoadMyOrders());
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Orders'),
        bottom: TabBar(
          controller: _tabController,
          onTap: _loadTab,
          tabs: const [
            Tab(text: 'Available'),
            Tab(text: 'My Orders'),
          ],
        ),
      ),
      drawer: buildAppDrawer(context),
      body: BlocConsumer<OrdersBloc, OrdersState>(
        listener: (context, state) {
          if (state is OrdersActionSuccess) {
            final index = _tabController.index;
            _loadTab(index);
          }

          if (state is OrdersError) {
            ScaffoldMessenger.of(context)
                .showSnackBar(SnackBar(content: Text(state.message)));
          }
        },
        builder: (context, state) {
          if (state is OrdersLoading) {
            return const Center(child: CircularProgressIndicator());
          }

          if (state is OrdersLoaded) {
            if (state.orders.isEmpty) {
              return const Center(child: Text('No orders found'));
            }

            return ListView.builder(
              padding: const EdgeInsets.all(12),
              itemCount: state.orders.length,
              itemBuilder: (_, i) {
                return _OrderCard(order: state.orders[i]);
              },
            );
          }

          return const SizedBox();
        },
      ),
    );
  }
}


class _OrderCard extends StatelessWidget {
  final OrderEntity order;

  const _OrderCard({required this.order});

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.only(bottom: 12),
      child: Padding(
        padding: const EdgeInsets.all(14),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(order.customerName,
                style: Theme.of(context).textTheme.titleMedium),
            const SizedBox(height: 6),
            GestureDetector(
              onTap: () => openMap(order.address),
              child: Text(
                order.address,
                style: const TextStyle(
                  decoration: TextDecoration.underline,
                  color: Colors.blue,
                ),
              ),
            ),

            const SizedBox(height: 6),
            Text("Amount: Rs ${order.amount}"),
            const SizedBox(height: 6),
            Text("Status: ${order.status}"),
            const SizedBox(height: 12),
            _buildActions(context),
          ],
        ),
      ),
    );
  }

  Widget _buildActions(BuildContext context) {
    if (order.status == 'pending') {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            children: [
              ElevatedButton(
                onPressed: () {
                  context.read<OrdersBloc>().add(AcceptOrderEvent(order.id));
                },
                child: const Text('Accept'),
              ),
              ElevatedButton(
                onPressed: () {
                  openMap(order.address);
                },
                child: const Text('Navigate'),
              ),
            ],
          ),
        ],
      );
    }


    if (order.status == 'preparing') {
      return Row(
        mainAxisAlignment: MainAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,
        children: [
          ElevatedButton(
            onPressed: () {
              context.read<OrdersBloc>().add(PickupOrderEvent(order.id));
            },
            child: const Text('Pickup'),
          ),
          ElevatedButton(
            onPressed: () {
              openMap(order.address);
            },
            child: const Text('Navigate'),
          ),
        ]
      );
    }

    if (order.status == 'out_for_delivery') {
      return Row(
        mainAxisAlignment: MainAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,
        children: [
          ElevatedButton(
            onPressed: () {
              _showOtpDialog(context);
            },
            child: const Text('Verify Delivery'),
          ),
          
          ElevatedButton(
            onPressed: () {
              openMap(order.address);
            },
            child: const Text('Navigate'),
          ),
        ],
      );
    }

    return const SizedBox();
  }

  void _showOtpDialog(BuildContext context) {
    final controller = TextEditingController();

    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: const Text('Enter OTP'),
        content: TextField(
          controller: controller,
          keyboardType: TextInputType.number,
          decoration: const InputDecoration(hintText: 'OTP'),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel'),
          ),
          ElevatedButton(
            onPressed: () {
              context.read<OrdersBloc>().add(
                    VerifyDeliveryEvent(order.id, controller.text),
                  );
              Navigator.pop(context);
            },
            child: const Text('Verify'),
          ),
        ],
      ),
    );
  }
}
