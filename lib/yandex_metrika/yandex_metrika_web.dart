// ignore_for_file: avoid_web_libraries_in_flutter, deprecated_member_use, avoid_print
import 'dart:js' as js;

void trackPage(String path, {String? title}) {
  try {
    js.context.callMethod('ym', [
      110230855,
      'hit',
      path,
    ]);
  } catch (e) {
    print('Yandex Metrika error: $e');
  }
}
