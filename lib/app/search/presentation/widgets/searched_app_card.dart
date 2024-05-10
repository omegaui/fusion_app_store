import 'package:flutter/material.dart';
import 'package:fusion_app_store/app/search/presentation/search_page_controller.dart';
import 'package:fusion_app_store/app/store/domain/entities/app_entity.dart';
import 'package:fusion_app_store/app/store/domain/entities/models/app_category.dart';
import 'package:fusion_app_store/config/app_theme.dart';
import 'package:fusion_app_store/core/cache_storage/cache.dart';
import 'package:fusion_app_store/core/global/ui_utils.dart';
import 'package:gap/gap.dart';

class SearchedAppCard extends StatefulWidget {
  const SearchedAppCard({
    super.key,
    required this.app,
    required this.controller,
  });

  final AppEntity app;
  final SearchPageController controller;

  @override
  State<SearchedAppCard> createState() => _SearchedAppCardState();
}

class _SearchedAppCardState extends State<SearchedAppCard> {
  bool hover = false;

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
    return GestureDetector(
      onTap: () {
        widget.controller.viewApp(widget.app);
      },
      child: MouseRegion(
        cursor: SystemMouseCursors.click,
        onEnter: (e) => setState(() => hover = true),
        onExit: (e) => setState(() => hover = false),
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 250),
          curve: Curves.easeIn,
          margin: const EdgeInsets.only(right: 50, bottom: 20),
          height: 200,
          decoration: BoxDecoration(
            color: Color(hover ? 0xFFF0F0F0 : 0xFFF7F7F7),
            borderRadius: BorderRadius.circular(20),
          ),
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Stack(
              children: [
                Align(
                  alignment: Alignment.topLeft,
                  child: Row(
                    children: [
                      Container(
                        width: 120,
                        height: 120,
                        decoration: BoxDecoration(
                          color: primaryColor.withOpacity(0.2),
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: Center(
                          child: SizedBox.square(
                            dimension: 64,
                            child: Image.network(
                              widget.app.icon,
                            ),
                          ),
                        ),
                      ),
                      const Gap(10),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Gap(15),
                            Text(
                              widget.app.name,
                              style: AppTheme.fontSize(20).makeBold().useSen(),
                            ),
                            SizedBox(
                              width: 700,
                              child: Text(
                                widget.app.shortDescription,
                                style:
                                    AppTheme.fontSize(16).makeMedium().useSen(),
                                overflow: TextOverflow.ellipsis,
                              ),
                            ),
                            const Gap(4),
                            Container(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 10,
                                vertical: 6,
                              ),
                              decoration: BoxDecoration(
                                color: primaryColor.withOpacity(0.2),
                                borderRadius: BorderRadius.circular(20),
                              ),
                              child: Text(
                                parseAppCategory(widget.app.category),
                                style:
                                    AppTheme.fontSize(14).makeBold().useSen(),
                              ),
                            ),
                            const Gap(10),
                            Wrap(
                              spacing: 15,
                              children: widget.app.supportedPlatforms
                                  .map(
                                    (e) => Image.asset(
                                      getPlatformIcon(e.type),
                                      width: 32,
                                    ),
                                  )
                                  .toList(),
                            )
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                Align(
                  alignment: Alignment.topRight,
                  child: Image.asset(
                    getEsrbRatingIcon(widget.app.esrbRating),
                    width: 48,
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
