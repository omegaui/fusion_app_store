import 'package:flutter/cupertino.dart';
import 'package:fusion_app_store/app/error/presentation/error_page_state_machine.dart';
import 'package:fusion_app_store/app/error/presentation/error_page_states_and_events.dart';
import 'package:fusion_app_store/core/logging/logger.dart';
import 'package:fusion_app_store/core/machine/controller.dart';
import 'package:fusion_app_store/core/routing/route_service.dart';
import 'package:get/get.dart';

class ErrorPageController extends Controller<ErrorState, ErrorEvent> {
  ErrorPageController() : super(stateMachine: ErrorPageStateMachine());

  @override
  void initListeners() {}

  void identifyError() {
    final error = Get.arguments;
    if (error == null) {
      Get.find<RouteService>().navigateTo(page: RouteService.homePage);
    } else {
      String message = Get.arguments[0].toString();
      String stackTrace = Get.arguments[1].toString();
      prettyLog(value: message, type: DebugType.error);
      WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
        onEvent(ErrorIdentifiedEvent(message, stackTrace));
      });
    }
  }
}
