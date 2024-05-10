import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';

import '../../config/app_theme.dart';

class StatePanel extends StatefulWidget {
  const StatePanel({
    super.key,
    this.message,
  });

  final String? message;

  @override
  State<StatePanel> createState() => _StatePanelState();
}

class _StatePanelState extends State<StatePanel> {
  String? _message;
  bool _show = false;

  @override
  void initState() {
    Future.delayed(
      const Duration(milliseconds: 100),
      () {
        if (mounted) {
          showMessage(widget.message);
        }
      },
    );
    super.initState();
  }

  void showMessage(String? message) {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      if (mounted) {
        setState(() {
          _message = message;
          _show = true;
        });
      }
    });
  }

  void hide() {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      if (mounted) {
        setState(() {
          _show = false;
        });
      }
    });
  }

  Widget _buildContent() {
    if (!_show) {
      return const SizedBox(
        key: ValueKey('hidden-state'),
      );
    }
    return FittedBox(
      child: Container(
        decoration: BoxDecoration(
          color: AppTheme.messagePanelBackground,
          borderRadius: BorderRadius.circular(30),
          boxShadow: [
            BoxShadow(
              color: AppTheme.curvedTopBarDropShadowColor,
              blurRadius: 16,
            ),
          ],
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: 16.0,
            vertical: 16.0,
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              SizedBox(
                width: 24,
                height: 24,
                child: CircularProgressIndicator(
                  color: AppTheme.messagePanelForeground,
                ),
              ),
              if (_message != null) ...[
                const Gap(10),
                Text(
                  _message!,
                  style: AppTheme.fontSize(14)
                      .withColor(AppTheme.messagePanelForeground),
                ),
              ],
            ],
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedSwitcher(
      duration: const Duration(milliseconds: 500),
      transitionBuilder: (child, animation) {
        return FadeTransition(
          opacity: animation,
          child: SlideTransition(
            position: Tween<Offset>(
              begin: const Offset(0, 1),
              end: const Offset(0, 0),
            ).animate(animation),
            child: child,
          ),
        );
      },
      child: _buildContent(),
    );
  }
}

bool _alreadyVisible = false;
final _globalKey = GlobalKey<_StatePanelState>();

void showLoader(String? message, {duration}) {
  debugPrint("StatePanel [message]: $message");
  if (_alreadyVisible && _globalKey.currentState != null) {
    _globalKey.currentState!.showMessage(message);
  } else {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      _alreadyVisible = true;
      showDialog(
        context: Get.context!,
        barrierColor: Colors.transparent,
        builder: (context) {
          return Scaffold(
            backgroundColor: Colors.transparent,
            body: Stack(
              children: [
                Align(
                  alignment: Alignment.bottomCenter,
                  child: Padding(
                    padding: const EdgeInsets.only(bottom: 16.0),
                    child: StatePanel(
                      key: _globalKey,
                      message: message,
                    ),
                  ),
                ),
              ],
            ),
          );
        },
      );
      if (duration != null) {
        Future.delayed(
          duration,
          () {
            hideLoader();
          },
        );
      }
    });
  }
}

void hideLoader() {
  if (_alreadyVisible && _globalKey.currentState != null) {
    _globalKey.currentState!.hide();
    _alreadyVisible = false;
    Navigator.pop(Get.context!);
  }
}
