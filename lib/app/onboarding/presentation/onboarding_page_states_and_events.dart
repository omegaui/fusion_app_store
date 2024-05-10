import 'package:fusion_app_store/app/store/domain/entities/models/device_type.dart';

class OnBoardingPageEvent {}

class OnBoardingPageLoadingEvent extends OnBoardingPageEvent {}

class OnBoardingPageInitializedEvent extends OnBoardingPageEvent {
  final bool? usernameAvailable;
  final DeviceType deviceType;

  OnBoardingPageInitializedEvent({
    this.usernameAvailable,
    required this.deviceType,
  });
}

class OnBoardingPageState {}

class OnBoardingPageLoadingState extends OnBoardingPageState {}

class OnBoardingPageInitializedState extends OnBoardingPageState {
  final bool? usernameAvailable;
  final DeviceType deviceType;

  OnBoardingPageInitializedState({
    this.usernameAvailable,
    required this.deviceType,
  });
}
