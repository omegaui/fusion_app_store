import 'package:fusion_app_store/app/dashboard/presentation/states/desktop/desktop_dashboard_page_initialized_state_view.dart';
import 'package:fusion_app_store/app/onboarding/domain/entities/user_entity.dart';
import 'package:fusion_app_store/app/store/domain/entities/app_entity.dart';

class DashboardPageEvent {}

class DashboardPageLoadingEvent extends DashboardPageEvent {}

class DashboardPageInitializedEvent extends DashboardPageEvent {
  final UserEntity userEntity;
  final List<AppEntity> ownedApps;
  final List<AppEntity> likedApps;
  final List<AppEntity> reviewedApps;
  final ViewType? initialViewType;
  final bool isPremiumUser;

  DashboardPageInitializedEvent({
    required this.userEntity,
    required this.ownedApps,
    required this.likedApps,
    required this.reviewedApps,
    this.initialViewType,
    required this.isPremiumUser,
  });
}

class DashboardPageState {}

class DashboardPageLoadingState extends DashboardPageState {}

class DashboardPageInitializedState extends DashboardPageState {
  final UserEntity userEntity;
  final List<AppEntity> ownedApps;
  final List<AppEntity> likedApps;
  final List<AppEntity> reviewedApps;
  final ViewType? initialViewType;
  final bool isPremiumUser;

  DashboardPageInitializedState({
    required this.userEntity,
    required this.ownedApps,
    required this.likedApps,
    required this.reviewedApps,
    this.initialViewType,
    required this.isPremiumUser,
  });
}
