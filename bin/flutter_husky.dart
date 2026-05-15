import 'package:flutter_husky/src/commands/init_command.dart';

Future<void> main(List<String> args) async {
  if (args.isEmpty) {
    print('Available commands:');
    print('');
    print('flutter_husky init');
    return;
  }

  switch (args.first) {
    case 'init':
      await InitCommand().run();
      break;

    default:
      print('Unknown command');
  }
}
