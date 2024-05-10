import 'package:flutter/material.dart';
import 'package:flutter_clean_architecture/flutter_clean_architecture.dart'
    as arch;
import 'package:fusion_app_store/core/logging/logger.dart';
import 'package:fusion_app_store/core/machine/background_event.dart';
import 'package:fusion_app_store/core/machine/state_machine.dart';

abstract class Controller<State, Event> extends arch.Controller {
  final StateMachine<State, Event> stateMachine;

  Controller({required this.stateMachine});

  void onEvent(Event e) {
    stateMachine.changeStateOnEvent(e);
    if (e is BackgroundEvent) {
      if (!e.shouldUpdateUI()) {
        return;
      }
    }
    prettyLog(value: ">> Firing Event -> ${e.runtimeType}");
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      refreshUI();
    });
  }

  State getCurrentState() {
    return stateMachine.currentState;
  }
}
