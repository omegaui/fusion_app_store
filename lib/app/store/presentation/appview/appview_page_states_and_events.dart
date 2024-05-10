import 'package:fusion_app_store/app/onboarding/domain/entities/user_entity.dart';
import 'package:fusion_app_store/app/store/domain/entities/app_entity.dart';
import 'package:fusion_app_store/app/store/domain/entities/app_review_entity.dart';

class AppViewPageEvent {}

class AppViewPageLoadingEvent extends AppViewPageEvent {}

class AppViewPageInitializedEvent extends AppViewPageEvent {
  final UserEntity publisher;
  final AppEntity appEntity;
  final AppReviewEntity appReviewEntity;
  final List<UserEntity> usersWhoReviewed;
  final List<AppEntity> moreAppsByPublisher;

  AppViewPageInitializedEvent({
    required this.publisher,
    required this.appEntity,
    required this.appReviewEntity,
    required this.usersWhoReviewed,
    required this.moreAppsByPublisher,
  });
}

class AppViewPageState {}

class AppViewPageLoadingState extends AppViewPageState {}

class AppViewPageInitializedState extends AppViewPageState {
  final UserEntity publisher;
  final AppEntity appEntity;
  final AppReviewEntity appReviewEntity;
  final List<UserEntity> usersWhoReviewed;
  final List<AppEntity> moreAppsByPublisher;

  AppViewPageInitializedState({
    required this.publisher,
    required this.appEntity,
    required this.appReviewEntity,
    required this.usersWhoReviewed,
    required this.moreAppsByPublisher,
  });
}
