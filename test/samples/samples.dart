import 'dart:convert';

import 'dart:io';

Future<Map<String, dynamic>> loadSample(String path) async =>
    jsonDecode(await File(path).readAsString()) as Map<String, dynamic>;
