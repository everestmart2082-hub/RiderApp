import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:riderapp/features/dashboard/domain/entities/dashboard_entity.dart';
import 'package:riderapp/features/order/domain/entities/order_entity.dart';
import '../bloc/dashboard_bloc.dart';
import '../bloc/dashboard_event.dart';
import '../bloc/dashboard_state.dart';

class DashboardPage extends StatefulWidget {
  const DashboardPage({super.key});

  @override
  State<DashboardPage> createState() => _DashboardPageState();
}

class _DashboardPageState extends State<DashboardPage> {
  @override
  void initState() {
    super.initState();
    context.read<DashboardBloc>().add(LoadDashboard());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Dashboard'),
        actions: [
          IconButton(
            icon: const Icon(Icons.refresh),
            onPressed: () {
              context.read<DashboardBloc>().add(RefreshDashboard());
            },
          ),
        ],
      ),
      body: BlocBuilder<DashboardBloc, DashboardState>(
        builder: (context, state) {
          if (state is DashboardLoading) {
            return const Center(child: CircularProgressIndicator());
          }

          if (state is DashboardError) {
            return Center(child: Text(state.message));
          }

          if (state is DashboardLoaded) {
            return RefreshIndicator(
              onRefresh: () async {
                context.read<DashboardBloc>().add(RefreshDashboard());
              },
              child: _DashboardBody(dashboard: state.dashboard),
            );
          }

          return const SizedBox();
        },
      ),
    );
  }
}


class _DashboardBody extends StatelessWidget {
  final DashboardEntity dashboard;

  const _DashboardBody({required this.dashboard});

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.all(16),
      children: [
        _StatsGrid(dashboard: dashboard),
        const SizedBox(height: 20),
        _RecentOrders(dashboard.recentOrders),
      ],
    );
  }
}


class _StatsGrid extends StatelessWidget {
  final DashboardEntity dashboard;

  const _StatsGrid({required this.dashboard});

  Widget _card(String title, String value, IconData icon) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            Icon(icon, size: 28),
            const SizedBox(height: 8),
            Text(title),
            const SizedBox(height: 6),
            Text(
              value,
              style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return GridView.count(
      crossAxisCount: 2,
      crossAxisSpacing: 12,
      mainAxisSpacing: 12,
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      children: [
        _card("Today's Earnings", "Rs ${dashboard.todayEarnings}",
            Icons.today),
        _card("Total Earnings", "Rs ${dashboard.totalEarnings}",
            Icons.account_balance_wallet),
        _card("Completed Orders", "${dashboard.completedOrders}",
            Icons.check_circle),
        _card("Ongoing Orders", "${dashboard.ongoingOrders}",
            Icons.delivery_dining),
      ],
    );
  }
}


class _RecentOrders extends StatelessWidget {
  final List<OrderEntity> orders;

  const _RecentOrders(this.orders);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Recent Orders",
          style: Theme.of(context).textTheme.titleLarge,
        ),
        const SizedBox(height: 12),
        if (orders.isEmpty)
          const Text("No recent orders"),
        ...orders.map(
          (o) => Card(
            child: ListTile(
              title: Text(o.customerName),
              subtitle: Text(o.address),
              trailing: Text("Rs ${o.amount}"),
            ),
          ),
        ),
      ],
    );
  }
}
