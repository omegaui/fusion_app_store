import 'package:flutter/material.dart';
import 'package:fusion_app_store/config/app_theme.dart';

class StepBox extends StatefulWidget {
  const StepBox({
    super.key,
    required this.step,
    this.done = false,
    required this.onPressed,
    this.showLine = true,
  });

  final String step;
  final bool done;
  final bool showLine;
  final VoidCallback onPressed;

  @override
  State<StepBox> createState() => _StepBoxState();
}

class _StepBoxState extends State<StepBox> {
  bool hover = false;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        GestureDetector(
          onTap: () {
            if (widget.done) {
              widget.onPressed();
            }
          },
          child: MouseRegion(
            cursor: widget.done
                ? SystemMouseCursors.click
                : SystemMouseCursors.basic,
            onEnter: (event) => setState(() => hover = (widget.done)),
            onExit: (event) => setState(() => hover = false),
            child: AnimatedContainer(
              duration: const Duration(milliseconds: 250),
              curve: Curves.easeIn,
              width: 48,
              height: 48,
              decoration: BoxDecoration(
                color: (hover || widget.done)
                    ? AppTheme.stepBoxHoverColor
                    : AppTheme.foreground,
                borderRadius: BorderRadius.circular(40),
              ),
              child: widget.done
                  ? Icon(
                      Icons.done,
                      color: AppTheme.background,
                    )
                  : Center(
                      child: Text(
                        widget.step,
                        style: AppTheme.fontSize(20)
                            .withColor(AppTheme.background)
                            .makeBold(),
                      ),
                    ),
            ),
          ),
        ),
        if (widget.showLine)
          Container(
            width: 60,
            height: 2,
            color:
                widget.done ? AppTheme.stepBoxHoverColor : AppTheme.foreground,
          ),
      ],
    );
  }
}
