import 'package:fusion_app_store/app/onboarding/domain/entities/user_entity.dart';
import 'package:fusion_app_store/app/store/domain/entities/app_entity.dart';
import 'package:fusion_app_store/app/store/domain/entities/models/supported_platform.dart';

class SearchPageEvent {}

class SearchPageLoadingEvent extends SearchPageEvent {}

class SearchPageInitializedEvent extends SearchPageEvent {
  final UserEntity userEntity;
  final String searchQuery;
  final PlatformType platformType;
  final List<AppEntity> apps;
  final List<AppEntity> localApps;

  SearchPageInitializedEvent({
    required this.userEntity,
    required this.searchQuery,
    required this.platformType,
    required this.apps,
    required this.localApps,
  });
}

class SearchPageState {}

class SearchPageLoadingState extends SearchPageState {}

class SearchPageInitializedState extends SearchPageState {
  final UserEntity userEntity;
  final String searchQuery;
  final PlatformType platformType;
  final List<AppEntity> apps;
  final List<AppEntity> localApps;

  SearchPageInitializedState({
    required this.userEntity,
    required this.searchQuery,
    required this.platformType,
    required this.apps,
    required this.localApps,
  });
}
