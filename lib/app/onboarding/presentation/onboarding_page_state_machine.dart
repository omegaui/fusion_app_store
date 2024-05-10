import 'package:fusion_app_store/app/onboarding/presentation/onboarding_page_states_and_events.dart';
import 'package:fusion_app_store/core/machine/state_machine.dart';

class OnBoardingStateMachine
    extends StateMachine<OnBoardingPageState, OnBoardingPageEvent> {
  OnBoardingStateMachine() : super(initialState: OnBoardingPageLoadingState());

  @override
  void changeStateOnEvent(OnBoardingPageEvent e) {
    switch (e.runtimeType) {
      case const (OnBoardingPageLoadingEvent):
        currentState = OnBoardingPageLoadingState();
        break;
      case const (OnBoardingPageInitializedEvent):
        final event = e as OnBoardingPageInitializedEvent;
        currentState = OnBoardingPageInitializedState(
          usernameAvailable: event.usernameAvailable,
          deviceType: event.deviceType,
        );
    }
  }
}
