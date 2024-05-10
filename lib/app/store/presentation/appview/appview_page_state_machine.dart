import 'package:fusion_app_store/app/store/presentation/appview/appview_page_states_and_events.dart';
import 'package:fusion_app_store/core/machine/state_machine.dart';

class AppViewPageStateMachine
    extends StateMachine<AppViewPageState, AppViewPageEvent> {
  AppViewPageStateMachine() : super(initialState: AppViewPageLoadingState());

  @override
  void changeStateOnEvent(AppViewPageEvent e) {
    switch (e.runtimeType) {
      case const (AppViewPageLoadingEvent):
        currentState = AppViewPageLoadingState();
        break;
      case const (AppViewPageInitializedEvent):
        currentState = AppViewPageInitializedState(
          publisher: (e as AppViewPageInitializedEvent).publisher,
          appEntity: e.appEntity,
          appReviewEntity: e.appReviewEntity,
          usersWhoReviewed: e.usersWhoReviewed,
          moreAppsByPublisher: e.moreAppsByPublisher,
        );
        break;
    }
  }
}
