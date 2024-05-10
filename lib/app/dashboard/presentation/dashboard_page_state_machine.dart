import 'package:fusion_app_store/app/dashboard/presentation/dashboard_page_states_and_events.dart';
import 'package:fusion_app_store/core/machine/state_machine.dart';

class DashboardStateMachine
    extends StateMachine<DashboardPageState, DashboardPageEvent> {
  DashboardStateMachine() : super(initialState: DashboardPageLoadingState());

  @override
  void changeStateOnEvent(DashboardPageEvent e) {
    switch (e.runtimeType) {
      case const (DashboardPageLoadingEvent):
        currentState = DashboardPageLoadingState();
        break;
      case const (DashboardPageInitializedEvent):
        final event = e as DashboardPageInitializedEvent;
        currentState = DashboardPageInitializedState(
          userEntity: event.userEntity,
          ownedApps: event.ownedApps,
          likedApps: event.likedApps,
          reviewedApps: event.reviewedApps,
          initialViewType: event.initialViewType,
          isPremiumUser: event.isPremiumUser,
        );
        break;
    }
  }
}
