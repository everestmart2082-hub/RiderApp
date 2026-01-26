import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:riderapp/core/network/api_endpoints.dart';
import 'package:riderapp/core/network/dio_client.dart';
import 'package:riderapp/core/storage/local_storage.dart';
import 'package:riderapp/features/auth/bloc/auth_bloc.dart';
import 'package:riderapp/features/auth/data/datasources/auth_remote_datasource.dart';
import 'package:riderapp/features/auth/domain/repository/auth_repository.dart';
import 'package:riderapp/features/auth/domain/usecases/get_profile_usecases.dart';
import 'package:riderapp/features/auth/domain/usecases/login_usecases.dart';
import 'package:riderapp/features/auth/domain/usecases/logout_usecases.dart';
import 'package:riderapp/features/auth/domain/usecases/register_usecases.dart';
import 'package:riderapp/features/dashboard/bloc/dashboard_bloc.dart';
import 'package:riderapp/features/dashboard/data/datasources/dashboard_remote_datasource.dart';
import 'package:riderapp/features/dashboard/domain/repositories/dashboard_repository.dart';
import 'package:riderapp/features/dashboard/domain/usecases/get_dashboard_usecases.dart';
import 'package:riderapp/features/profile/bloc/profile_bloc.dart';
import 'package:riderapp/features/profile/data/datasources/profile_remote_datasources.dart';
import 'package:riderapp/features/profile/domain/repositories/profile_repository.dart';
import 'package:riderapp/features/profile/domain/usecases/get_profile_usecases.dart';
import 'package:riderapp/features/tracking/bloc/tracking_bloc.dart';
import 'package:riderapp/features/tracking/data/datasources/tracking_remote_datasource.dart';
import 'package:riderapp/features/tracking/domain/repositories/tracking_repository.dart';
import 'package:riderapp/features/tracking/domain/usecases/update_location_usecases.dart';

void main() async{
  
  WidgetsFlutterBinding.ensureInitialized();

  // final savedToken = await LocaleStorage.load();


  runApp(const MainApp());
}


class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    final dioClient = DioClient(baseUrl: ApiEndpoints.baseUrl);
    final dio = Dio(
      BaseOptions(
        baseUrl: ApiEndpoints.baseUrl,
        connectTimeout: const Duration(seconds: 10),
        receiveTimeout: const Duration(seconds: 10),
      )
    );

    return MultiRepositoryProvider(
      providers: [
        // ================= CORE =================
        RepositoryProvider<DioClient>(
          create: (_) => dioClient,
        ),

        // ================= AUTH =================
        RepositoryProvider<AuthRemoteDataSource>(
          create: (context) => AuthRemoteDataSourceImpl(
            dio
          ),
        ),

        RepositoryProvider<AuthRepository>(
          create: (context) => AuthRepositoryImpl(
            context.read<AuthRemoteDataSource>(),
          ),
        ),

        // ================= PROFILE =================
        RepositoryProvider<ProfileRemoteDataSource>(
          create: (context) => ProfileRemoteDataSourceImpl(
            dio
          ),
        ),

        RepositoryProvider<ProfileRepository>(
          create: (context) => ProfileRepositoryImpl(
            context.read<ProfileRemoteDataSource>(),
          ),
        ),

        // ================= DASHBOARD =================
        RepositoryProvider<DashboardRemoteDataSource>(
          create: (context) => DashboardRemoteDataSourceImpl(
            dio,
          ),
        ),

        RepositoryProvider<DashboardRepository>(
          create: (context) => DashboardRepositoryImpl(
            context.read<DashboardRemoteDataSource>()
          ),
        ),

        // ================= TRACKING =================
        RepositoryProvider<TrackingRemoteDataSource>(
          create: (context) => TrackingRemoteDataSourceImpl(
            dio,
          ),
        ),

        RepositoryProvider<TrackingRepository>(
          create: (context) => TrackingRepositoryImpl(
            context.read<TrackingRemoteDataSource>()
          ),
        ),
      ],
      child: MultiBlocProvider(
        providers: [
          // ================= AUTH =================
          BlocProvider<AuthBloc>(
            create: (context) => AuthBloc(
              loginUseCase: LoginUseCase(context.read<AuthRepository>()), 
              registerUseCase: RegisterUseCase(context.read<AuthRepository>()), 
              getProfileUseCase: GetAuthProfileUseCase(context.read<AuthRepository>()), 
              logoutUseCase: LogoutUseCase(context.read<AuthRepository>()),
              
            ),
          ),

          // ================= PROFILE =================
          BlocProvider<ProfileBloc>(
            create: (context) => ProfileBloc(
              GetProfileUseCase(context.read<ProfileRepository>())
            ),
          ),

          // ================= DASHBOARD =================
          BlocProvider<DashboardBloc>(
            create: (context) => DashboardBloc(
              GetDashboard(
                context.read<DashboardRepository>(),
              ),
            ),
          ),

          // ================= TRACKING =================
          BlocProvider<TrackingBloc>(
            create: (context) => TrackingBloc(
              UpdateLocationUseCase(
                context.read<TrackingRepository>(),
              ),
            ),
          ),
        ],
        child: MaterialApp(
          title: 'EverestMart Rider',
          debugShowCheckedModeBanner: false,
          theme: ThemeData.light(),
          darkTheme: ThemeData.dark(),
          themeMode: ThemeMode.light,
          home: MainApp(),
          routes: {
            '/mainapp': (context) => const MainApp(),
            '/login': (context) => const LoginPage(),
            '/register': (context) => const RegisterPage(),
            '/profile': (context) => const ProfilePage(),
            '/dashboard': (context) => const ProfilePage(),
            '/orders': (context) => const ProfilePage(),
          },
        ),
      ),
    );
  }
}
