import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:fusion_app_store/app/store/domain/entities/app_entity.dart';
import 'package:fusion_app_store/config/app_theme.dart';
import 'package:fusion_app_store/core/cache_storage/cache.dart';
import 'package:fusion_app_store/core/global/ui_utils.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';

class StoreAppCard extends StatefulWidget {
  const StoreAppCard({
    super.key,
    required this.app,
    required this.onPressed,
  });

  final AppEntity app;
  final VoidCallback onPressed;

  @override
  State<StoreAppCard> createState() => _StoreAppCardState();
}

class _StoreAppCardState extends State<StoreAppCard> {
  // ui keys
  bool hover = false;
  bool pressed = false;

  // app card color
  Color primaryColor = Colors.blue.shade100;

  @override
  void initState() {
    super.initState();
    final color = AppCache.get(
      key: '${widget.app.appID}-Card-Color',
      fallback: null,
    );
    if (color != null) {
      primaryColor = color;
    } else {
      Future(() async {
        await cacheDominantColor(
            '${widget.app.appID}-Card-Color', widget.app.icon);
        setState(() {
          final color = AppCache.get(
            key: '${widget.app.appID}-Card-Color',
            fallback: null,
          );
          if (color != null) {
            primaryColor = color;
          }
        });
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    const width = 190.0;
    const height = 240.0;
    const imageHeight = 140.0;
    return GestureDetector(
      onTap: () {
        setState(() {
          pressed = true;
          Future.delayed(
            const Duration(seconds: 1),
            () {
              if (mounted) {
                setState(() {
                  pressed = false;
                });
              }
            },
          );
        });
        widget.onPressed();
      },
      child: MouseRegion(
        cursor: SystemMouseCursors.click,
        onEnter: (e) => setState(() => hover = true),
        onExit: (e) => setState(() => hover = false),
        child: AnimatedSlide(
          duration: const Duration(milliseconds: 250),
          offset: hover ? const Offset(0, -0.02) : const Offset(0, 0),
          child: Container(
            width: width,
            height: height,
            decoration: BoxDecoration(
              color: AppTheme.background,
              borderRadius: BorderRadius.circular(10),
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(hover ? 0.4 : 0.3),
                  blurRadius: hover ? 16 : 8,
                ),
              ],
            ),
            child: Column(
              children: [
                AnimatedContainer(
                  duration: const Duration(milliseconds: 250),
                  curve: Curves.easeIn,
                  width: width,
                  height: imageHeight,
                  decoration: BoxDecoration(
                    gradient: RadialGradient(colors: [
                      primaryColor.withOpacity(hover ? 0.2 : 0.1),
                      primaryColor.withOpacity(hover ? 0.2 : 0.2),
                    ]),
                    borderRadius: const BorderRadius.only(
                        topLeft: Radius.circular(10),
                        topRight: Radius.circular(10)),
                  ),
                  child: ClipRect(
                    child: BackdropFilter(
                      filter: ImageFilter.blur(sigmaX: 1, sigmaY: 1),
                      blendMode: BlendMode.srcIn,
                      child: Center(
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Image.network(
                              widget.app.icon,
                              width: 64,
                            ),
                            if (pressed) ...[
                              const Gap(10),
                              const SizedBox(
                                width: 24,
                                height: 24,
                                child: CircularProgressIndicator(),
                              ),
                            ],
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  width: width,
                  height: height - imageHeight,
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Stack(
                      children: [
                        Align(
                          alignment: Alignment.topLeft,
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Text(
                                widget.app.name,
                                style: AppTheme.fontSize(16).makeBold(),
                              ),
                              if (widget.app.verified) ...[
                                const Gap(10),
                                const Icon(
                                  Icons.verified_rounded,
                                  color: Colors.blue,
                                ),
                              ],
                            ],
                          ),
                        ),
                        Align(
                          alignment: Alignment.bottomRight,
                          child: Container(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 6, vertical: 2),
                            decoration: BoxDecoration(
                              color: Colors.blue.shade100.withOpacity(0.2),
                              borderRadius: BorderRadius.circular(5),
                            ),
                            child: Text(
                              widget.app.pricingModel.type.name.capitalize!,
                              style: AppTheme.fontSize(14)
                                  .makeMedium()
                                  .withColor(Colors.grey.shade600),
                            ),
                          ),
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
  }
}
