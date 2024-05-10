import 'package:flutter/material.dart';

class LikeButton extends StatefulWidget {
  const LikeButton({super.key, required this.liked, required this.onPressed});

  final bool liked;
  final VoidCallback onPressed;

  @override
  State<LikeButton> createState() => _LikeButtonState();
}

class _LikeButtonState extends State<LikeButton> {
  bool hover = false;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: widget.onPressed,
      child: MouseRegion(
        cursor: SystemMouseCursors.click,
        onEnter: (e) => setState(() => hover = true),
        onExit: (e) => setState(() => hover = false),
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 250),
          curve: Curves.easeIn,
          width: 50,
          height: 50,
          padding: EdgeInsets.all(hover ? 5 : 0),
          decoration: BoxDecoration(
            color: hover ? Colors.grey.shade200 : Colors.white,
            borderRadius: BorderRadius.circular(15),
            border: Border.all(
              color: const Color(0xFF444B54).withOpacity(0.1),
              width: 2,
            ),
          ),
          child: Center(
            child: AnimatedScale(
              duration: const Duration(milliseconds: 250),
              curve: Curves.easeIn,
              scale: hover ? 0.85 : 1.0,
              child: Icon(
                widget.liked ? Icons.favorite : Icons.heart_broken_rounded,
                color: widget.liked ? Colors.red : Colors.grey.shade800,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
