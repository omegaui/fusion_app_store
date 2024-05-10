import 'package:flutter/material.dart';

class AddVersionButton extends StatefulWidget {
  const AddVersionButton({
    super.key,
    required this.onPressed,
  });

  final VoidCallback onPressed;

  @override
  State<AddVersionButton> createState() => _AddVersionButtonState();
}

class _AddVersionButtonState extends State<AddVersionButton> {
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
          padding: const EdgeInsets.all(10),
          decoration: BoxDecoration(
            color: Colors.blue.shade50,
            borderRadius: BorderRadius.circular(40),
            border: Border.all(
              color: hover ? Colors.blue : Colors.blue.shade50,
              width: 2,
            ),
            boxShadow: [
              BoxShadow(
                color: Colors.blue.withOpacity(0.2),
                blurRadius: hover ? 48 : 16,
              )
            ],
          ),
          child: const Icon(
            Icons.add_outlined,
            color: Colors.blue,
          ),
        ),
      ),
    );
  }
}
