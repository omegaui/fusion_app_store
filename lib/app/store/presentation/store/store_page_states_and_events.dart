import 'package:fusion_app_store/app/onboarding/domain/entities/user_entity.dart';
import 'package:fusion_app_store/app/store/domain/entities/app_entity.dart';

class StorePageEvent {}

class StorePageLoadingEvent extends StorePageEvent {}

class StorePageInitializedEvent extends StorePageEvent {
  final UserEntity? userEntity;
  final List<AppEntity> apps;

  StorePageInitializedEvent({this.userEntity, required this.apps});
}

class StorePageState {}

class StorePageLoadingState extends StorePageState {}

class StorePageInitializedState extends StorePageState {
  final UserEntity? userEntity;
  final List<AppEntity> apps;

  StorePageInitializedState({this.userEntity, required this.apps});
}
