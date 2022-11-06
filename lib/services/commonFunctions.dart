import 'dart:convert';
import 'dart:typed_data';

import 'package:flutter/material.dart';

imageFromBase64String(String base64String) {
  String uri = base64String;
  Uint8List _bytes = base64.decode(uri.split(',').last);
  return MemoryImage(_bytes);
}
