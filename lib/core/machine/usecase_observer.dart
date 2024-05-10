import 'dart:ui';

import 'package:flutter_clean_architecture/flutter_clean_architecture.dart';
import 'package:fusion_app_store/core/global/ui_utils.dart';
import 'package:fusion_app_store/core/logging/logger.dart';

class UseCaseObserver<T> implements Observer<T> {
  final String name;
  VoidCallback? onFinish;
  void Function(T? t)? onNextValue;

  UseCaseObserver({required this.name, this.onFinish, this.onNextValue});

  @override
  void onComplete() {
    if (onFinish != null) {
      onFinish!();
    }
  }

  @override
  void onError(e) {
    prettyLog(
        value: "Error Occurred at ${name}UseCaseObserver",
        type: DebugType.error);
    prettyLog(value: e, type: DebugType.error);
    gotoErrorPage(e.toString(),
        "Error Caught by ${name}UseCaseObserver while listening for $T type value.");
  }

  @override
  void onNext(T? response) {
    if (onNextValue != null) {
      onNextValue!(response);
    }
  }
}
