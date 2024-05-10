import 'package:fusion_app_store/app/onboarding/domain/entities/user_entity.dart';
import 'package:fusion_app_store/app/store/domain/entities/app_entity.dart';

class UserViewPageEvent {}

class UserViewPageLoadingEvent extends UserViewPageEvent {}

class UserViewPageNotFoundEvent extends UserViewPageEvent {}

class UserViewPageInitializedEvent extends UserViewPageEvent {
  final UserEntity user;
  final List<AppEntity> apps;

  UserViewPageInitializedEvent({required this.user, required this.apps});
}

class UserViewPageState {}

class UserViewPageLoadingState extends UserViewPageState {}

class UserViewPageNotFoundState extends UserViewPageState {}

class UserViewPageInitializedState extends UserViewPageState {
  final UserEntity user;
  final List<AppEntity> apps;

  UserViewPageInitializedState({required this.user, required this.apps});
}
