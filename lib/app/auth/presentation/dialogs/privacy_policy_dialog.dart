import 'package:flutter/material.dart';
import 'package:fusion_app_store/config/app_theme.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';

class PrivacyPolicyDialog {
  PrivacyPolicyDialog._();

  static const fullText = """
1. Introduction

Fusion App Store ("we," "us," or "our") is committed to protecting the privacy of our users. This Privacy Policy explains what information we collect, how we use it, and your rights regarding your information.

2. Information We Collect

We collect limited information about users of the Fusion App Store. Here's what we collect:

Account Information: If you create an account, we may collect basic information such as your username and email address.
App Analytics Data: We may collect anonymous data about app usage within the Fusion App Store. This data helps us understand how users interact with the platform and improve the service.
User Growth Data: We may collect anonymous data about user growth on the platform, such as the number of new user registrations. This data helps us track the platform's growth and development.
3. How We Use Your Information

We use the information we collect for the following purposes:

To provide and maintain the Service.
To communicate with you about your account and the Service.
To analyze how users interact with the platform and improve the Service.
To track the growth and development of the platform.
4. Information Sharing

We do not share your personal information with any third parties except in the following limited circumstances:

Service Providers: We may share your information with third-party service providers who help us operate the Service. These service providers are contractually obligated to keep your information confidential.
Legal Requirements: We may disclose your information if we are required to do so by law or in the good faith belief that such disclosure is necessary to comply with a court order, subpoena, or other legal process.
5. Your Choices

You can access and update your account information at any time. You can also choose to delete your account by contacting us.

6. App Analytics

We may use third-party analytics tools to collect anonymous data about app usage within the Fusion App Store. These tools do not collect any personal information about users.

7. Security

We take reasonable steps to protect the information you provide to us from unauthorized access, disclosure, alteration, or destruction. However, no internet transmission or electronic storage is 100% secure.

8. Children's Privacy

The Fusion App Store is not directed to children under the age of 13. We do not knowingly collect personal information from children under 13. If you are a parent or guardian and you believe that your child has provided us with personal information, please contact us.

9. Changes to This Privacy Policy

We may update this Privacy Policy from time to time. We will notify you of any changes by posting the new Privacy Policy on this page.

10. Contact Us

If you have any questions about this Privacy Policy, please contact us at fusionpackagemanager@gmail.com.
""";

  static void view() {
    showDialog(
      context: Get.context!,
      barrierColor: Colors.transparent,
      builder: (context) {
        final size = MediaQuery.of(context).size;
        return Scaffold(
          backgroundColor: Colors.transparent,
          body: Center(
            child: Container(
              width: size.width * 0.5,
              height: size.height * 0.8,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(40),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.2),
                    blurRadius: 16,
                  ),
                ],
              ),
              child: Padding(
                padding: const EdgeInsets.all(32.0),
                child: Stack(
                  children: [
                    Align(
                      alignment: Alignment.topLeft,
                      child: SingleChildScrollView(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Privacy Policy",
                              style:
                                  AppTheme.fontSize(32).makeMedium().useSen(),
                            ),
                            Text(
                              "Please read the privacy policy carefully before using our services.",
                              style: AppTheme.fontSize(16).useSen(),
                            ),
                            const Gap(25),
                            Text(
                              fullText,
                              style: AppTheme.fontSize(14).makeMedium(),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
