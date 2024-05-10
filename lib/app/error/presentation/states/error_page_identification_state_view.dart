import 'package:flutter/material.dart';
import 'package:fusion_app_store/config/app_theme.dart';

class ErrorPageIdentificationStateView extends StatelessWidget {
  const ErrorPageIdentificationStateView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.background,
      body: Center(
        child: CircularProgressIndicator(
          color: AppTheme.foreground,
        ),
      ),
    );
  }
}
