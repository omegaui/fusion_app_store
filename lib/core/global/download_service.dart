import 'package:http/http.dart' as http;

class DownloadService {
  DownloadService._();

  static Future<void> download({
    required String url,
    required void Function(int progress) onProgress,
    required Future<void> Function(List<int> bytes) onComplete,
    required void Function() onError,
  }) async {
    final request = http.Request('GET', Uri.parse(url));
    final response = await http.Client().send(request);
    final total = response.contentLength ?? 0;
    int received = 0;
    final List<int> bytes = [];
    final subscription = response.stream.listen((value) {
      bytes.addAll(value);
      received += value.length;
      if (total != 0) {
        onProgress(((received * 100) / total).round());
      }
    });
    await subscription.asFuture();
    await onComplete(bytes);
  }
}
