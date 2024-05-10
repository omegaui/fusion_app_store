import 'package:fusion_app_store/app/auth/presentation/auth_page_states_and_machine.dart.dart';
import 'package:fusion_app_store/core/machine/state_machine.dart';

class AuthPageStateMachine extends StateMachine<AuthPageState, AuthPageEvent> {
  AuthPageStateMachine() : super(initialState: AuthPageLoadingState());

  @override
  void changeStateOnEvent(AuthPageEvent e) {
    switch (e.runtimeType) {
      case const (AuthPageLoadingEvent):
        currentState = AuthPageLoadingState();
      case const (AuthPageInitializedEvent):
        currentState = AuthPageInitializedState();
    }
  }
}
