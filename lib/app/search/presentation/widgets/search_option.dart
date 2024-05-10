import 'package:flutter/material.dart';
import 'package:fusion_app_store/config/app_theme.dart';

class SearchOption extends StatefulWidget {
  const SearchOption({
    super.key,
    required this.option,
    required this.onSelected,
  });

  final String option;
  final void Function(String) onSelected;

  @override
  State<SearchOption> createState() => _SearchOptionState();
}

class _SearchOptionState extends State<SearchOption> {
  bool hover = false;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        widget.onSelected(widget.option);
      },
      child: MouseRegion(
        cursor: SystemMouseCursors.click,
        onEnter: (e) => setState(() => hover = true),
        onExit: (e) => setState(() => hover = false),
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 250),
          curve: Curves.easeIn,
          height: 40,
          width: MediaQuery.sizeOf(context).width,
          decoration: BoxDecoration(
            color: Color(hover ? 0xFFF0F0F5 : 0xFFF7F7F7),
          ),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              widget.option,
              style: AppTheme.fontSize(14).makeMedium().useSen(),
            ),
          ),
        ),
      ),
    );
  }
}
