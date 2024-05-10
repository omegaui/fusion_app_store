import 'package:flutter/foundation.dart';

enum DebugType { error, info, warning, url, response, statusCode }

prettyLog({
  String? tag,
  required dynamic value,
  DebugType type = DebugType.info,
}) {
  switch (type) {
    case DebugType.statusCode:
      debugPrint(
          '\x1B[33m${"💎 STATUS CODE ${tag != null ? "$tag: " : ""}$value"}\x1B[0m');
      break;
    case DebugType.info:
      debugPrint("⚡ ${tag != null ? "$tag: " : ""}$value");
      break;
    case DebugType.warning:
      debugPrint(
          '\x1B[36m${"⚠️ Warning ${tag != null ? "$tag: " : ""}$value"}\x1B[0m');
      break;
    case DebugType.error:
      debugPrint(
          '\x1B[31m${">> ERROR ${tag != null ? "$tag: " : ""}$value"}\x1B[0m');
      break;
    case DebugType.response:
      debugPrint('\x1B[36m${">> ${tag != null ? "$tag: " : ""}$value"}\x1B[0m');
      break;
    case DebugType.url:
      debugPrint(
          '\x1B[34m${">> URL ${tag != null ? "$tag: " : ""}$value"}\x1B[0m');
      break;
  }
}
