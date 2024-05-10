import 'package:fusion_app_store/constants/on_changed.dart';
import 'package:fusion_app_store/core/logging/logger.dart';

class AppCache {
  AppCache._();

  static final Map<String, dynamic> _cacheMap = {};
  static final Map<String, List<ChangeListener>> _listeners = {};

  static void put({required String key, required dynamic value}) {
    _cacheMap[key] = value;
    if (_listeners.containsKey(key)) {
      for (var element in _listeners[key]!) {
        element.notify(value);
      }
    }
    prettyLog(
      value: "Setting `$key` to `$value`",
      tag: "AppCache",
    );
  }

  static dynamic get({
    required String key,
    required dynamic fallback,
  }) {
    final value = _cacheMap[key] ?? fallback;
    return value;
  }

  static void listenOn({
    required String key,
    required ChangeListener onChanged,
  }) {
    final existing = _listeners[key];
    if (existing == null) {
      _listeners[key] = [onChanged];
    } else {
      _listeners[key] = [...existing, onChanged];
    }
  }
}
