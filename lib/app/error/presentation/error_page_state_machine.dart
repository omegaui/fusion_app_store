import 'package:fusion_app_store/app/error/presentation/error_page_states_and_events.dart';
import 'package:fusion_app_store/core/machine/state_machine.dart';

class ErrorPageStateMachine extends StateMachine<ErrorState, ErrorEvent> {
  ErrorPageStateMachine() : super(initialState: ErrorIdentificationState());

  @override
  void changeStateOnEvent(ErrorEvent e) {
    switch (e.runtimeType) {
      case const (ErrorIdentificationEvent):
        currentState = ErrorIdentificationState();
        break;
      case const (ErrorIdentifiedEvent):
        currentState =
            ErrorIdentifiedState.fromEvent(e as ErrorIdentifiedEvent);
        break;
    }
  }
}
