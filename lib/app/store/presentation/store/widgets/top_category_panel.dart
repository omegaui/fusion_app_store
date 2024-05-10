import 'package:flutter/material.dart';
import 'package:fusion_app_store/app/store/presentation/store/store_page_controller.dart';
import 'package:fusion_app_store/config/app_theme.dart';
import 'package:fusion_app_store/constants/store_pages.dart';
import 'package:gap/gap.dart';

class StoreTopCategoryPanel extends StatefulWidget {
  const StoreTopCategoryPanel({
    super.key,
    required this.controller,
  });

  final StorePageController controller;

  @override
  State<StoreTopCategoryPanel> createState() => _StoreTopCategoryPanelState();
}

class _StoreTopCategoryPanelState extends State<StoreTopCategoryPanel> {
  List<String> types = StorePages.pages;

  String activeType = "Home";

  @override
  void initState() {
    super.initState();
    activeType = widget.controller.activeStorePage;
  }

  @override
  Widget build(BuildContext context) {
    return Wrap(
      spacing: 20,
      children: types.map((e) {
        return CategoryOption(
          categoryName: e,
          active: activeType == e,
          onSelected: () {
            setState(() {
              activeType = e;
              widget.controller.onStorePageChanged(activeType);
            });
          },
        );
      }).toList(),
    );
  }
}

class CategoryOption extends StatefulWidget {
  const CategoryOption({
    super.key,
    required this.categoryName,
    required this.active,
    required this.onSelected,
  });

  final String categoryName;
  final bool active;
  final VoidCallback onSelected;

  @override
  State<CategoryOption> createState() => _CategoryOptionState();
}

class _CategoryOptionState extends State<CategoryOption> {
  bool hover = false;

  Widget _getContent() {
    if (widget.active) {
      const gradient = LinearGradient(colors: [Colors.blue, Colors.pink]);
      return Column(
        mainAxisSize: MainAxisSize.min,
        key: const ValueKey("active-state"),
        children: [
          ShaderMask(
            shaderCallback: (bounds) => gradient.createShader(bounds),
            child: Text(
              widget.categoryName,
              style: AppTheme.fontSize(14).withColor(Colors.blue).makeMedium(),
            ),
          ),
          const Gap(6),
          Container(
            width: 50,
            height: 4,
            decoration: const BoxDecoration(
              gradient: gradient,
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(10),
                topRight: Radius.circular(10),
              ),
            ),
          ),
        ],
      );
    }
    if (hover) {
      return Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            widget.categoryName,
            key: const ValueKey("hover-state"),
            style: AppTheme.fontSize(14)
                .withColor(Colors.blue.shade800)
                .makeMedium(),
          ),
          const SizedBox(width: 50, height: 10),
        ],
      );
    }
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(
          widget.categoryName,
          key: const ValueKey("idle-state"),
          style: AppTheme.fontSize(14)
              .withColor(Colors.grey.shade800)
              .makeMedium(),
        ),
        const SizedBox(width: 50, height: 10),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: widget.onSelected,
      child: MouseRegion(
        cursor: SystemMouseCursors.click,
        onEnter: (e) => setState(() => hover = true),
        onExit: (e) => setState(() => hover = false),
        child: AnimatedSwitcher(
          duration: const Duration(milliseconds: 500),
          child: _getContent(),
        ),
      ),
    );
  }
}
