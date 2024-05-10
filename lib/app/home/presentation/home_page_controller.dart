import 'package:fusion_app_store/app/home/presentation/home_page_state_machine.dart';
import 'package:fusion_app_store/app/home/presentation/home_page_states_and_events.dart';
import 'package:fusion_app_store/core/machine/controller.dart';
import 'package:fusion_app_store/core/routing/route_service.dart';
import 'package:get/get.dart';

class HomePageController extends Controller<HomePageState, HomePageEvent> {
  HomePageController() : super(stateMachine: HomePageStateMachine());

  @override
  void initListeners() {}

  void gotoAuthRoute() {
    Get.find<RouteService>()
        .navigateTo(page: RouteService.authPage, shouldReplace: true);
  }
}
