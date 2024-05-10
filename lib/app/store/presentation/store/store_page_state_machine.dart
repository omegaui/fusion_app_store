import 'package:fusion_app_store/app/store/presentation/store/store_page_states_and_events.dart';
import 'package:fusion_app_store/core/machine/state_machine.dart';

class StorePageStateMachine
    extends StateMachine<StorePageState, StorePageEvent> {
  StorePageStateMachine() : super(initialState: StorePageLoadingState());

  @override
  void changeStateOnEvent(StorePageEvent e) {
    switch (e.runtimeType) {
      case const (StorePageLoadingEvent):
        currentState = StorePageLoadingState();
        break;
      case const (StorePageInitializedEvent):
        currentState = StorePageInitializedState(
          userEntity: (e as StorePageInitializedEvent).userEntity,
          apps: e.apps,
        );
        break;
    }
  }
}
