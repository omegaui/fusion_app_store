import 'package:fusion_app_store/app/home/presentation/home_page_states_and_events.dart';
import 'package:fusion_app_store/core/machine/state_machine.dart';

class HomePageStateMachine extends StateMachine<HomePageState, HomePageEvent> {
  HomePageStateMachine() : super(initialState: HomePageInitializedState());

  @override
  void changeStateOnEvent(HomePageEvent e) {
    // Home Page doesn't has any states
    // its just an overview of Fusion
  }
}
