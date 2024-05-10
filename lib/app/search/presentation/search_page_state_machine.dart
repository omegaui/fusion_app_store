import 'package:fusion_app_store/app/search/presentation/search_page_states_and_events.dart';
import 'package:fusion_app_store/core/machine/state_machine.dart';

class SearchPageStateMachine
    extends StateMachine<SearchPageState, SearchPageEvent> {
  SearchPageStateMachine() : super(initialState: SearchPageLoadingState());

  @override
  void changeStateOnEvent(SearchPageEvent e) {
    switch (e.runtimeType) {
      case const (SearchPageLoadingEvent):
        currentState = SearchPageLoadingState();
        break;
      case const (SearchPageInitializedEvent):
        currentState = SearchPageInitializedState(
          userEntity: (e as SearchPageInitializedEvent).userEntity,
          searchQuery: e.searchQuery,
          platformType: e.platformType,
          apps: e.apps,
          localApps: e.localApps,
        );
        break;
    }
  }
}
