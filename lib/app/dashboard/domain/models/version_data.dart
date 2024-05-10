import 'dart:typed_data';

class VersionData {
  final String name;
  final Uint8List bytes;
  bool isUploaded = false;

  VersionData({required this.name, required this.bytes});
}
