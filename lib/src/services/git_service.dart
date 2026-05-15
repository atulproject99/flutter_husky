import 'dart:io';

class GitService {
  static Future<bool> hasGitDirectory() async {
    final gitDir = Directory('.git');
    return gitDir.existsSync();
  }
}
