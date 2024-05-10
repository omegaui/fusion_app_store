import 'package:get/get.dart';

enum DeviceType { mobile, desktop, tablet }

class RealDeviceType {
  RealDeviceType._();

  static DeviceType identify(DeviceType current, String canonicalName) {
    if (canonicalName.isEmpty) {
      return current;
    }
    const values = DeviceType.values;
    DeviceType? result;
    for (final value in values) {
      if (value.name.isCaseInsensitiveContains(canonicalName)) {
        result = value;
        break;
      }
    }
    return result ?? current;
  }
}
