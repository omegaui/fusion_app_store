import 'package:flutter/material.dart';
import 'package:fusion_app_store/config/app_theme.dart';

class UserViewPageNotFoundStateView extends StatelessWidget {
  const UserViewPageNotFoundStateView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.background,
      body: Center(
        child: Text(
          "User Not Found\nTry correcting the username in the url and try again.",
          style: AppTheme.fontSize(16).makeMedium(),
        ),
      ),
    );
  }
}
