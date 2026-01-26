# riderapp

A new Flutter project.


features/
│
├── auth/
│   ├── data/
│   │   ├── models/
│   │   │   └── rider_model.dart
│   │   ├── datasources/
│   │   │   └── auth_remote_datasource.dart
│   │   ├── repositories/
│   │   │   └── auth_repository_impl.dart
│   │   └── mappers/
│   │       └── rider_mapper.dart
│   │
│   ├── domain/
│   │   ├── entities/
│   │   │   └── rider_entity.dart
│   │   ├── repositories/
│   │   │   └── auth_repository.dart
│   │   └── usecases/
│   │       ├── login_usecase.dart
│   │       ├── register_usecase.dart
│   │       ├── get_profile_usecase.dart
│   │       └── logout_usecase.dart
│   │
│   ├── bloc/
│   │   ├── auth_bloc.dart
│   │   ├── auth_event.dart
│   │   └── auth_state.dart
│   │
│   └── ui/
│       ├── pages/
│       │   ├── login_page.dart
│       │   ├── register_page.dart
│       │   └── splash_page.dart
│       └── widgets/
│           └── auth_form.dart
│
├── orders/
│   ├── data/
│   │   ├── models/
│   │   │   └── order_model.dart
│   │   ├── datasources/
│   │   │   └── orders_remote_datasource.dart
│   │   ├── repositories/
│   │   │   └── orders_repository_impl.dart
│   │   └── mappers/
│   │       └── order_mapper.dart
│   │
│   ├── domain/
│   │   ├── entities/
│   │   │   └── order_entity.dart
│   │   ├── repositories/
│   │   │   └── orders_repository.dart
│   │   └── usecases/
│   │       ├── get_available_orders.dart
│   │       ├── get_my_orders.dart
│   │       ├── accept_order.dart
│   │       ├── pickup_order.dart
│   │       └── verify_delivery.dart
│   │
│   ├── bloc/
│   │   ├── orders_bloc.dart
│   │   ├── orders_event.dart
│   │   └── orders_state.dart
│   │
│   └── ui/
│       ├── pages/
│       │   ├── orders_page.dart
│       │   ├── order_detail_page.dart
│       │   └── otp_verify_page.dart
│       └── widgets/
│           └── order_tile.dart
│
├── dashboard/
│   ├── data/
│   │   ├── datasources/
│   │   │   └── dashboard_remote_datasource.dart
│   │   ├── models/
│   │   │   └── earnings_model.dart
│   │   └── repositories/
│   │       └── dashboard_repository_impl.dart
│   │
│   ├── domain/
│   │   ├── entities/
│   │   │   └── earnings_entity.dart
│   │   ├── repositories/
│   │   │   └── dashboard_repository.dart
│   │   └── usecases/
│   │       └── get_earnings.dart
│   │
│   ├── bloc/
│   │   ├── dashboard_bloc.dart
│   │   ├── dashboard_event.dart
│   │   └── dashboard_state.dart
│   │
│   └── ui/
│       ├── pages/
│       │   └── dashboard_page.dart
│       └── widgets/
│           └── earnings_card.dart
│
├── tracking/
│   ├── data/
│   │   ├── datasources/
│   │   │   └── location_remote_datasource.dart
│   │   ├── repositories/
│   │   │   └── tracking_repository_impl.dart
│   │
│   ├── domain/
│   │   ├── repositories/
│   │   │   └── tracking_repository.dart
│   │   └── usecases/
│   │       └── update_location.dart
│   │
│   ├── bloc/
│   │   ├── tracking_bloc.dart
│   │   ├── tracking_event.dart
│   │   └── tracking_state.dart
│   │
│   └── ui/
│       └── widgets/
│           └── location_updater.dart
│
├── profile/
│   ├── data/
│   │   ├── datasources/
│   │   │   └── profile_remote_datasource.dart
│   │   ├── models/
│   │   │   └── profile_model.dart
│   │   └── repositories/
│   │       └── profile_repository_impl.dart
│   │
│   ├── domain/
│   │   ├── entities/
│   │   │   └── profile_entity.dart
│   │   ├── repositories/
│   │   │   └── profile_repository.dart
│   │   └── usecases/
│   │       └── get_profile.dart
│   │
│   ├── bloc/
│   │   ├── profile_bloc.dart
│   │   ├── profile_event.dart
│   │   └── profile_state.dart
│   │
│   └── ui/
│       ├── pages/
│       │   └── profile_page.dart
│       └── widgets/
│           └── profile_header.dart
│
├── availability/
│   ├── data/
│   │   ├── datasources/
│   │   │   └── availability_remote_datasource.dart
│   │   └── repositories/
│   │       └── availability_repository_impl.dart
│   │
│   ├── domain/
│   │   ├── repositories/
│   │   │   └── availability_repository.dart
│   │   └── usecases/
│   │       └── update_availability.dart
│   │
│   ├── bloc/
│   │   ├── availability_bloc.dart
│   │   ├── availability_event.dart
│   │   └── availability_state.dart
│   │
│   └── ui/
│       └── widgets/
│           └── online_switch.dart
│
└── common/
    ├── ui/
    │   ├── pages/
    │   │   └── home_shell.dart
    │   └── widgets/
    │       ├── app_loader.dart
    │       └── error_view.dart
