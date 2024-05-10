import 'dart:typed_data';

import 'package:fusion_app_store/core/cloud_storage/storage.dart';

class Resources {
  Resources._();

  static const _fusionAppIconPath = 'omegaui/fusion/icons/fusion-app-icon.png';

  static late Uint8List fusionAppIconBytes;

  static Future<void> init() async {
    fusionAppIconBytes = (await Storage.getData(path: _fusionAppIconPath))!;
  }
}
