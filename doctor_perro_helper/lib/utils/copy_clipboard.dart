import 'package:flutter/services.dart';

void copy(String content) {
  Clipboard.setData(ClipboardData(text: content));
}
