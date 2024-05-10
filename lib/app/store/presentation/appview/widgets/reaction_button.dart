import 'package:flutter/material.dart';
import 'package:fusion_app_store/app/store/domain/entities/models/reactions.dart';
import 'package:fusion_app_store/config/app_theme.dart';
import 'package:gap/gap.dart';

class ReactionButton extends StatefulWidget {
  const ReactionButton({
    super.key,
    required this.reaction,
    required this.active,
    required this.onPressed,
    required this.bottomText,
  });

  final Reaction reaction;
  final bool active;
  final VoidCallback onPressed;
  final String bottomText;

  @override
  State<ReactionButton> createState() => _ReactionButtonState();
}

class _ReactionButtonState extends State<ReactionButton> {
  bool hover = false;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        GestureDetector(
          onTap: () {
            if (!widget.active) {
              widget.onPressed();
            }
          },
          child: MouseRegion(
            cursor: SystemMouseCursors.click,
            onEnter: (e) => setState(() => hover = true),
            onExit: (e) => setState(() => hover = false),
            child: AnimatedContainer(
              duration: const Duration(milliseconds: 250),
              curve: Curves.easeIn,
              width: 52,
              height: 52,
              decoration: BoxDecoration(
                color: widget.active
                    ? Colors.pink
                    : (hover ? Colors.blue : AppTheme.appViewBackground),
                borderRadius: BorderRadius.circular(30),
              ),
              child: Center(
                child: Image.asset(
                  getReactionIcon(widget.reaction),
                  width: 32,
                ),
              ),
            ),
          ),
        ),
        if (widget.bottomText.isNotEmpty) ...[
          const Gap(3),
          Text(
            widget.bottomText,
            style: AppTheme.fontSize(12).makeMedium().useSen(),
          ),
        ],
      ],
    );
  }
}
