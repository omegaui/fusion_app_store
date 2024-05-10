import 'package:fusion_app_store/app/analytics/data/analytics_repository_impl.dart';
import 'package:fusion_app_store/app/analytics/domain/repository/analytics_repository.dart';
import 'package:fusion_app_store/app/auth/data/auth_repository_impl.dart';
import 'package:fusion_app_store/app/auth/domain/repository/auth_repository.dart';
import 'package:fusion_app_store/app/auth/domain/usecases/user_join_status_usecase.dart';
import 'package:fusion_app_store/app/auth/domain/usecases/user_login_status_usecase.dart';
import 'package:fusion_app_store/app/auth/domain/usecases/user_login_with_google_usecase.dart';
import 'package:fusion_app_store/app/auth/domain/usecases/user_login_with_username_and_password_usecase.dart';
import 'package:fusion_app_store/app/auth/domain/usecases/user_logout_usecase.dart';
import 'package:fusion_app_store/app/auth/presentation/auth_page_presenter.dart';
import 'package:fusion_app_store/app/dashboard/data/dashboard_repository_impl.dart';
import 'package:fusion_app_store/app/dashboard/domain/repository/dashboard_repository.dart';
import 'package:fusion_app_store/app/dashboard/domain/usecases/delete_app_usecase.dart';
import 'package:fusion_app_store/app/dashboard/domain/usecases/upload_app_usecase.dart';
import 'package:fusion_app_store/app/dashboard/domain/usecases/watch_apps_by_user_usecase.dart';
import 'package:fusion_app_store/app/dashboard/domain/usecases/watch_current_user_usecase.dart';
import 'package:fusion_app_store/app/dashboard/domain/usecases/watch_liked_apps_usecase.dart';
import 'package:fusion_app_store/app/dashboard/domain/usecases/watch_reviewed_apps_usecase.dart';
import 'package:fusion_app_store/app/dashboard/presentation/dashboard_page_presenter.dart';
import 'package:fusion_app_store/app/onboarding/data/onboarding_repository_impl.dart';
import 'package:fusion_app_store/app/onboarding/domain/repository/onboarding_repository.dart';
import 'package:fusion_app_store/app/onboarding/domain/usecases/update_user_usecase.dart';
import 'package:fusion_app_store/app/onboarding/domain/usecases/username_available_usecase.dart';
import 'package:fusion_app_store/app/onboarding/presentation/onboarding_page_presenter.dart';
import 'package:fusion_app_store/app/search/data/search_repository_impl.dart';
import 'package:fusion_app_store/app/search/domain/repository/search_repository.dart';
import 'package:fusion_app_store/app/search/domain/usecases/search_apps_usecase.dart';
import 'package:fusion_app_store/app/search/presentation/search_page_presenter.dart';
import 'package:fusion_app_store/app/store/data/store_repository_impl.dart';
import 'package:fusion_app_store/app/store/domain/repository/store_repository.dart';
import 'package:fusion_app_store/app/store/domain/usecases/dislike_app_usecase.dart';
import 'package:fusion_app_store/app/store/domain/usecases/find_user_usecase.dart';
import 'package:fusion_app_store/app/store/domain/usecases/get_app_by_id_usecase.dart';
import 'package:fusion_app_store/app/store/domain/usecases/get_app_reviews_by_id_usecase.dart';
import 'package:fusion_app_store/app/store/domain/usecases/get_apps_by_user_usecase.dart';
import 'package:fusion_app_store/app/store/domain/usecases/get_current_user_usecase.dart';
import 'package:fusion_app_store/app/store/domain/usecases/get_local_apps_usecase.dart';
import 'package:fusion_app_store/app/store/domain/usecases/home_page_watch_apps_usecase.dart';
import 'package:fusion_app_store/app/store/domain/usecases/like_app_usecase.dart';
import 'package:fusion_app_store/app/store/domain/usecases/review_app_usecase.dart';
import 'package:fusion_app_store/app/store/domain/usecases/verify_app_usecase.dart';
import 'package:fusion_app_store/app/store/domain/usecases/watch_apps_by_page.dart';
import 'package:fusion_app_store/app/store/domain/usecases/watch_users_usecase.dart';
import 'package:fusion_app_store/app/store/presentation/appview/appview_page_presenter.dart';
import 'package:fusion_app_store/app/store/presentation/store/store_page_presenter.dart';
import 'package:fusion_app_store/app/store/presentation/userview/userview_page_presenter.dart';
import 'package:fusion_app_store/core/cloud_storage/data_listener.dart';
import 'package:fusion_app_store/core/local_storage/database.dart';
import 'package:fusion_app_store/core/logging/logger.dart';
import 'package:fusion_app_store/core/routing/route_service.dart';
import 'package:get/get.dart';

class Injector {
  Injector._();

  static void init() {
    prettyLog(value: 'Initializing Dependencies ...', tag: 'Injector');
    // adding permanent dependencies
    Get.put<RouteService>(RouteService(), permanent: true);
    Get.put<FusionDatabase>(FusionDatabase.getInstance(), permanent: true);
    Get.put<DataListener>(DataListener(), permanent: true);

    // caching repositories
    Get.put<AnalyticsRepository>(AnalyticsRepositoryImpl());
    Get.put<AuthRepository>(AuthRepositoryImpl());
    Get.put<OnBoardingRepository>(OnBoardingRepositoryImpl());
    Get.put<DashboardRepository>(DashboardRepositoryImpl());
    Get.put<StoreRepository>(StoreRepositoryImpl());
    Get.put<SearchRepository>(SearchRepositoryImpl());

    // caching use cases
    Get.put(UserLoginStatusUseCase(Get.find()));
    Get.put(UserLoginWithGoogleUseCase(Get.find()));
    Get.put(UserLoginWithUsernameAndPasswordUseCase(Get.find()));
    Get.put(UserLogOutUseCase(Get.find()));
    Get.put(UserJoinStatusUseCase(Get.find()));
    Get.put(UpdateUserUseCase(Get.find()));
    Get.put(UsernameAvailableUseCase(Get.find()));
    Get.put(WatchUsersUseCase(Get.find()));
    Get.put(WatchCurrentUserUseCase(Get.find()));
    Get.put(WatchAppsByUserUseCase(Get.find()));
    Get.put(UploadAppUseCase(Get.find()));
    Get.put(GetCurrentUserUseCase(Get.find()));
    Get.put(WatchHomePageAppsUseCase(Get.find()));
    Get.put(WatchAppsByPageUseCase(Get.find()));
    Get.put(GetAppByIDUseCase(Get.find()));
    Get.put(LikeAppUseCase(Get.find()));
    Get.put(DislikeAppUseCase(Get.find()));
    Get.put(WatchLikedAppsUseCase(Get.find()));
    Get.put(GetAppReviewsByIDUseCase(Get.find()));
    Get.put(ReviewAppUseCase(Get.find()));
    Get.put(WatchReviewedAppsUseCase(Get.find()));
    Get.put(DeleteAppUseCase(Get.find()));
    Get.put(SearchAppsUsecase(Get.find()));
    Get.put(GetLocalAppsUseCase(Get.find()));
    Get.put(FindUserUseCase(Get.find()));
    Get.put(GetAppsByUserUseCase(Get.find()));
    Get.put(VerifyAppUseCase(Get.find()));

    // caching presenters
    Get.put(
      AuthPagePresenter(
        Get.find(),
        Get.find(),
        Get.find(),
        Get.find(),
        Get.find(),
      ),
    );
    Get.put(
      OnBoardingPagePresenter(
        Get.find(),
        Get.find(),
        Get.find(),
        Get.find(),
      ),
    );
    Get.put(
      DashboardPagePresenter(
        Get.find(),
        Get.find(),
        Get.find(),
        Get.find(),
        Get.find(),
        Get.find(),
        Get.find(),
        Get.find(),
        Get.find(),
        Get.find(),
      ),
    );
    Get.put(
      StorePagePresenter(
        Get.find(),
        Get.find(),
        Get.find(),
        Get.find(),
      ),
    );
    Get.put(
      AppViewPagePresenter(
        Get.find(),
        Get.find(),
        Get.find(),
        Get.find(),
        Get.find(),
        Get.find(),
        Get.find(),
      ),
    );
    Get.put(SearchPagePresenter(
      Get.find(),
      Get.find(),
      Get.find(),
    ));
    Get.put(UserViewPagePresenter(
      Get.find(),
      Get.find(),
    ));
  }
}
