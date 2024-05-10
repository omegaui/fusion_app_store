import 'dart:typed_data';

import 'package:flutter/material.dart';

class ImageTile extends StatefulWidget {
  const ImageTile({
    super.key,
    required this.bytes,
    required this.onPressed,
  });

  final Uint8List bytes;
  final void Function(ImageProvider image) onPressed;

  @override
  State<ImageTile> createState() => _ImageTileState();
}

class _ImageTileState extends State<ImageTile> {
  Size size = const Size(107, 60);
  bool hover = false;
  MemoryImage? image;

  @override
  void initState() {
    super.initState();
    (() async {
      final bytes = widget.bytes;
      image = MemoryImage(Uint8List.fromList(bytes));
      rebuild();
    })();
  }

  void rebuild() {
    if (mounted) {
      setState(() {
        // rebuild
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        widget.onPressed(image!);
      },
      child: MouseRegion(
        cursor: SystemMouseCursors.click,
        onEnter: (e) => setState(() => hover = true),
        onExit: (e) => setState(() => hover = false),
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 250),
          curve: Curves.easeIn,
          height: size.height,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(10),
            border:
                Border.all(color: hover ? Colors.red : Colors.blue, width: 2),
          ),
          child: Center(
              child: image == null
                  ? const CircularProgressIndicator()
                  : ClipRRect(
                      borderRadius: BorderRadius.circular(10),
                      child: Image(
                        image: image!,
                        fit: BoxFit.contain,
                      ),
                    )),
        ),
      ),
    );
  }
}
