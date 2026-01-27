

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:riderapp/drawers.dart';
import 'package:riderapp/features/auth/bloc/auth_bloc.dart';
import 'package:riderapp/features/auth/bloc/auth_event.dart';
import 'package:riderapp/features/tracking/bloc/tracking_bloc.dart';
import 'package:riderapp/features/tracking/bloc/tracking_event.dart';

class MainApp extends StatefulWidget{
  MainApp({super.key});

  @override
  State<MainApp> createState() => _MainAppState();
}

class _MainAppState extends State<MainApp> {


  @override
  void initState() {
    super.initState();
    final bloc = context.read<AuthBloc>();
    bloc.add(AuthCheckRequested());
    context.read<TrackingBloc>().add(StartTracking());
  }

  @override
  Widget build(BuildContext context) {
    

    return Scaffold(
      appBar: AppBar(title: const Text('EverestMart'), elevation: 0),
      drawer: buildAppDrawer(context),
      body: Column(
        children: [
          Container(
            width: double.infinity,
            padding: const EdgeInsets.symmetric(vertical: 32, horizontal: 20),
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [
                  Color(0xFF1E88E5),
                  Color(0xFF42A5F5),
                ],
              ),
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(20),
                bottomRight: Radius.circular(20),
              ),
            ),
            child: const Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Rider',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 28,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 8),
                Text(
                  'Welcome to EverestMart Rider App',
                  style: TextStyle(
                    color: Colors.white70,
                    fontSize: 14,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}