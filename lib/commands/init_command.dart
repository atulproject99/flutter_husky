import 'package:flutter_husky/generators/pre_commit_generator.dart';
import 'package:flutter_husky/generators/pre_push_generator.dart';
import 'package:flutter_husky/services/git_service.dart';
import 'package:flutter_husky/services/hook_service.dart';

class InitCommand {
  Future<void> run() async {
    final hasGit = await GitService.hasGitDirectory();

    if (!hasGit) {
      print('Git repository not found.');
      return;
    }

    await HookService.createHook(
      name: 'pre-commit',
      content: PreCommitGenerator.generate(),
    );

    await HookService.createHook(
      name: 'pre-push',
      content: PrePushGenerator.generate(),
    );

    print('');
    print('✔ pre-commit hook installed');
    print('✔ pre-push hook installed');
    print('');
    print('Flutter Husky initialized successfully');
  }
}
