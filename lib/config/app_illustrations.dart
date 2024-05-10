/*
 * App Illustration primary color: #FF677F
 */

import 'package:fusion_app_store/constants/user_type.dart';

class AppIllustrations {
  AppIllustrations._();

  static const onBoardingShape = 'assets/illustrations/onboarding-shape.png';
  static const dashboardShape = 'assets/illustrations/dashboard-shape.png';
  static const credentials = 'assets/illustrations/credentials.png';
  static const avatar = 'assets/illustrations/avatar.png';
  static const developer = 'assets/illustrations/developer.png';
  static const designer = 'assets/illustrations/designer.png';
  static const student = 'assets/illustrations/student.png';
  static const company = 'assets/illustrations/company.png';
  static const other = 'assets/illustrations/other.png';
  static const userType = 'assets/illustrations/user-type.png';
  static const rocket = 'assets/illustrations/rocket.png';

  static String getUserTypeIllustration(UserType userType) {
    switch (userType) {
      case UserType.developer:
        return AppIllustrations.developer;
      case UserType.designer:
        return AppIllustrations.designer;
      case UserType.student:
        return AppIllustrations.student;
      case UserType.company:
        return AppIllustrations.company;
      case UserType.other:
        return AppIllustrations.other;
    }
  }
}
