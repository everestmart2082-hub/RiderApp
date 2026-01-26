import 'package:flutter_bloc/flutter_bloc.dart';
import '../domain/usecases/get_dashboard_usecases.dart';
import 'dashboard_event.dart';
import 'dashboard_state.dart';

class DashboardBloc extends Bloc<DashboardEvent, DashboardState> {
  final GetDashboard getDashboard;

  DashboardBloc(this.getDashboard) : super(DashboardInitial()) {
    on<LoadDashboard>(_load);
    on<RefreshDashboard>(_refresh);
  }

  Future<void> _load(
      LoadDashboard event, Emitter<DashboardState> emit) async {
    emit(DashboardLoading());
    try {
      final dashboard = await getDashboard();
      emit(DashboardLoaded(dashboard));
    } catch (e) {
      emit(DashboardError(e.toString()));
    }
  }

  Future<void> _refresh(
      RefreshDashboard event, Emitter<DashboardState> emit) async {
    try {
      final dashboard = await getDashboard();
      emit(DashboardLoaded(dashboard));
    } catch (e) {
      emit(DashboardError(e.toString()));
    }
  }
}
