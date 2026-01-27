import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:riderapp/drawers.dart';
import '../bloc/profile_bloc.dart';
import '../bloc/profile_event.dart';
import '../bloc/profile_state.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  @override
  void initState() {
    super.initState();
    context.read<ProfileBloc>().add(LoadProfileRequested());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('My Profile'),
        centerTitle: true,
      ),
      drawer: buildAppDrawer(context),
      body: BlocBuilder<ProfileBloc, ProfileState>(
        builder: (context, state) {
          if (state is ProfileLoading) {
            return const Center(child: CircularProgressIndicator());
          }

          if (state is ProfileError) {
            return Center(child: Text(state.message));
          }

          if (state is ProfileLoaded) {
            final p = state.profile;

            return RefreshIndicator(
              onRefresh: () async {
                context.read<ProfileBloc>().add(LoadProfileRequested());
              },
              child: ListView(
                padding: const EdgeInsets.all(16),
                children: [
                  _header(p),
                  const SizedBox(height: 24),
                  _card("Name", p.name),
                  _card("Email", p.email),
                  _card("Phone", p.phone),
                  // _card("Status", p.status),
                  _card("Bike Model", p.bikeModel),
                  _card("Bike Number", p.bikeRegistrationNumber),
                ],
              ),
            );
          }

          return const SizedBox();
        },
      ),
    );
  }

  Widget _header(dynamic p) {
    return Column(
      children: [
        // CircleAvatar(
        //   radius: 50,
        //   backgroundImage: p.photo != null
        //       ? NetworkImage(p.photo!)
        //       : null,
        //   child: p.photo == null
        //       ? const Icon(Icons.person, size: 50)
        //       : null,
        // ),
        // const SizedBox(height: 12),
        Text(
          p.name,
          style: const TextStyle(
            fontSize: 22,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 4),
        Text(
          p.email,
          style: const TextStyle(color: Colors.grey),
        ),
      ],
    );
  }

  Widget _card(String title, String value) {
    return Card(
      margin: const EdgeInsets.only(bottom: 12),
      child: ListTile(
        title: Text(title),
        subtitle: Text(value),
      ),
    );
  }
}
