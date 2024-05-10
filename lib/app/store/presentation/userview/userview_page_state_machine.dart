import 'package:fusion_app_store/app/store/presentation/userview/userview_page_states_and_events.dart';
import 'package:fusion_app_store/core/machine/state_machine.dart';

class UserViewPageStateMachine
    extends StateMachine<UserViewPageState, UserViewPageEvent> {
  UserViewPageStateMachine() : super(initialState: UserViewPageLoadingState());

  @override
  void changeStateOnEvent(UserViewPageEvent e) {
    switch (e.runtimeType) {
      case const (UserViewPageLoadingEvent):
        currentState = UserViewPageLoadingState();
        break;
      case const (UserViewPageNotFoundEvent):
        currentState = UserViewPageNotFoundState();
        break;
      case const (UserViewPageInitializedEvent):
        currentState = UserViewPageInitializedState(
          user: (e as UserViewPageInitializedEvent).user,
          apps: e.apps,
        );
        break;
    }
  }
}
