import 'dart:io';

import 'package:path/path.dart' as path;

class HookService {
  static Future<void> createHook({
    required String name,
    required String content,
  }) async {
    final hookPath = path.join('.git', 'hooks', name);

    final file = File(hookPath);

    await file.writeAsString(content);

    if (!Platform.isWindows) {
      await Process.run('chmod', ['+x', hookPath]);
    }
  }
}
