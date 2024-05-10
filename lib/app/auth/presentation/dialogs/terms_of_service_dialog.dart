import 'package:flutter/material.dart';
import 'package:fusion_app_store/app/home/presentation/widgets/app_button.dart';
import 'package:fusion_app_store/config/app_theme.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';

import '../../../../core/global/core_app_button.dart';

class TermsOfServiceDialog {
  TermsOfServiceDialog._();

  static const fullText = """
1. Introduction:

These Terms and Conditions ("Terms") govern your access to and use of the Fusion App Store (the "Service") operated by [Your Company Name] ("we," "us," or "our"). By accessing or using the Service, you agree to be bound by these Terms. If you disagree with any part of these Terms, you may not access or use the Service.

2. User Eligibility:

You must be at least 13 years old to access or use the Service. If you are under 18, you must have your parent or legal guardian's permission to use the Service.

3. Account Creation:

To access certain features of the Service, you may be required to create an account. You are responsible for maintaining the confidentiality of your account information, including your username and password. You are also responsible for all activity that occurs under your account.

4. User Content:

You are responsible for all content (including text, data, images, videos, and other information) that you submit to the Service ("User Content"). You retain all ownership rights to your User Content, but by submitting it to the Service, you grant us a non-exclusive, worldwide, royalty-free license to use, reproduce, modify, publish, and distribute your User Content in connection with the Service.

5. App Submissions:

If you are a developer, you may submit apps ("Apps") to the Service. You are solely responsible for the content and functionality of your Apps. You warrant that your Apps do not violate any third-party rights, including intellectual property rights. You further warrant that your Apps do not contain malware or other harmful code.

6. Age Restrictions:

You may not publish Apps that are intended for users under the age of 13 without appropriate age gating and parental controls. You are responsible for determining the appropriate age rating for your App based on its content.

7. Prohibited Content:

You agree not to submit any User Content or Apps that are:

Illegal or promote illegal activities.
Obscene, indecent, or hateful.
Defamatory or violate the privacy of others.
Infringe on the intellectual property rights of others.
Contain malware or other harmful code.
8. Termination:

We may terminate your access to the Service at any time, for any reason, with or without notice. We may also remove any User Content or Apps that violate these Terms.

9. Disclaimer:

The Service is provided "as is" and without warranties of any kind, express or implied. We disclaim all warranties, including, but not limited to, warranties of merchantability, fitness for a particular purpose, and non-infringement.

10. Limitation of Liability:

We will not be liable for any damages arising out of your use of the Service, including, but not limited to, direct, indirect, incidental, consequential, or punitive damages.

11. Governing Law:

These Terms shall be governed by and construed in accordance with the laws of [Your Country], without regard to its conflict of laws provisions.

12. Entire Agreement:

These Terms constitute the entire agreement between you and us regarding your use of the Service. These Terms supersede all prior or contemporaneous communications and agreements, whether oral or written.
""";

  static final termsOfService = {
    'Acceptable Use':
        'You agree to use Fusion App Store for lawful purposes and in accordance with our terms\nand any applicable developer terms.',
    'Content Restrictions':
        'Don\'t distribute malware, violate copyrights, infringe on privacy, or submit harmful content.',
    'User Responsibility':
        'You\'re responsible for the legality and content of any apps you publish.',
    'Account Management':
        'You\'re responsible for maintaining the security of your account.',
    'Termination':
        'We reserve the right to terminate accounts or remove content violating our terms.',
    'Modification':
        'We can modify these terms at any time. Continued use signifies your acceptance.',
    'Disclaimer':
        'Fusion App Store is provided "as-is". We make no warranties about its functionality or content.',
    'Governing Law':
        'Any disputes will be governed by the laws of [Your Country].',
  }.entries;

  static void open(VoidCallback onAccepted, VoidCallback onRejected) {
    showDialog(
      context: Get.context!,
      barrierDismissible: false,
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
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Our Terms of Service",
                            style: AppTheme.fontSize(32).makeMedium().useSen(),
                          ),
                          Text(
                            "Kindly go through the below terms and conditions carefully before using our services.",
                            style: AppTheme.fontSize(16).useSen(),
                          ),
                          const Gap(25),
                          for (final term in termsOfService) ...[
                            Padding(
                              padding: const EdgeInsets.only(bottom: 8.0),
                              child: Column(
                                mainAxisSize: MainAxisSize.min,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    "${term.key}:",
                                    style: AppTheme.fontSize(20)
                                        .makeMedium()
                                        .useSen(),
                                  ),
                                  const Gap(4),
                                  Text(
                                    term.value,
                                    style: AppTheme.fontSize(16).useSen(),
                                  ),
                                ],
                              ),
                            ),
                          ]
                        ],
                      ),
                    ),
                    Align(
                      alignment: Alignment.bottomRight,
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          CoreAppButton(
                            text: "I Accept",
                            onPressed: onAccepted,
                          ),
                          const Gap(10),
                          CoreAppButton(
                            text: "I Deny",
                            onPressed: onRejected,
                          ),
                        ],
                      ),
                    ),
                    const Align(
                      alignment: Alignment.bottomLeft,
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          AppButton(
                            text: "See more about the Terms of Service",
                            onPressed: view,
                          ),
                        ],
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
                              "Terms of Service",
                              style:
                                  AppTheme.fontSize(32).makeMedium().useSen(),
                            ),
                            Text(
                              "Please read the conditions carefully before using our services.",
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
