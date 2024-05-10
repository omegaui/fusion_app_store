import 'package:fusion_app_store/app/dashboard/presentation/states/desktop/desktop_dashboard_page_initialized_state_view.dart';

class DashboardPageArguments {
  final bool isOnBoarded;
  final bool isUserLoggedIn;
  final ViewType? initialViewType;

  DashboardPageArguments({
    required this.isOnBoarded,
    required this.isUserLoggedIn,
    this.initialViewType,
  });
}
