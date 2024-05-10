import 'package:flutter_clean_architecture/flutter_clean_architecture.dart';
import 'package:fusion_app_store/app/dashboard/domain/usecases/watch_current_user_usecase.dart';
import 'package:fusion_app_store/app/store/domain/entities/app_entity.dart';
import 'package:fusion_app_store/app/store/domain/entities/models/app_review.dart';
import 'package:fusion_app_store/app/store/domain/usecases/dislike_app_usecase.dart';
import 'package:fusion_app_store/app/store/domain/usecases/get_app_by_id_usecase.dart';
import 'package:fusion_app_store/app/store/domain/usecases/get_app_reviews_by_id_usecase.dart';
import 'package:fusion_app_store/app/store/domain/usecases/like_app_usecase.dart';
import 'package:fusion_app_store/app/store/domain/usecases/review_app_usecase.dart';
import 'package:fusion_app_store/app/store/domain/usecases/verify_app_usecase.dart';
import 'package:fusion_app_store/core/machine/usecase_observer.dart';

class AppViewPagePresenter extends Presenter {
  final WatchCurrentUserUseCase _watchCurrentUserUseCase;
  final GetAppByIDUseCase _getAppByIDUseCase;
  final LikeAppUseCase _likeAppUseCase;
  final DislikeAppUseCase _dislikeAppUseCase;
  final GetAppReviewsByIDUseCase _getAppReviewsByIDUseCase;
  final ReviewAppUseCase _reviewAppUseCase;
  final VerifyAppUseCase _verifyAppUseCase;

  AppViewPagePresenter(
    this._watchCurrentUserUseCase,
    this._getAppByIDUseCase,
    this._likeAppUseCase,
    this._dislikeAppUseCase,
    this._getAppReviewsByIDUseCase,
    this._reviewAppUseCase,
    this._verifyAppUseCase,
  );

  @override
  void dispose() {
    _watchCurrentUserUseCase.dispose();
    _getAppByIDUseCase.dispose();
    _likeAppUseCase.dispose();
    _dislikeAppUseCase.dispose();
    _getAppReviewsByIDUseCase.dispose();
    _reviewAppUseCase.dispose();
    _verifyAppUseCase.dispose();
  }

  void watchCurrentUser({required UseCaseObserver observer}) {
    _watchCurrentUserUseCase.execute(observer);
  }

  void getAppByID({required UseCaseObserver observer, required String appID}) {
    _getAppByIDUseCase.execute(observer, appID);
  }

  void likeApp(
      {required UseCaseObserver observer, required AppEntity appEntity}) {
    _likeAppUseCase.execute(observer, appEntity);
  }

  void dislikeApp(
      {required UseCaseObserver observer, required AppEntity appEntity}) {
    _dislikeAppUseCase.execute(observer, appEntity);
  }

  void getAppReviewsByID({
    required UseCaseObserver observer,
    required String appID,
  }) {
    _getAppReviewsByIDUseCase.execute(observer, appID);
  }

  void reviewApp({
    required UseCaseObserver observer,
    required AppEntity appEntity,
    required AppReview appReview,
  }) {
    _reviewAppUseCase.execute(observer, {
      'appEntity': appEntity,
      'appReview': appReview,
    });
  }
  
  void verifyApp(
      {required UseCaseObserver observer, required AppEntity appEntity}) {
    _verifyAppUseCase.execute(observer, appEntity);
  }

}
