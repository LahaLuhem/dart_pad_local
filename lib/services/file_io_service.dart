import 'dart:async';
import 'dart:io';

import 'package:dart_pad_local/locator.dart';
import 'package:path_provider/path_provider.dart';

class FileIOService {
  late final Directory _tempDir;
  late final File _scratchPadFile;

  FileIOService() {
    unawaited(_initialise());
  }

  static const _scratchFilePath = 'scratchpad.dart';
  String get scratchFilePath => '${_tempDir.path}/$_scratchFilePath';

  final _initialiseCompleter = Completer<void>();
  Future<void> get initialiseAwaiter => _initialiseCompleter.future;

  Future<void> _initialise() async {
    _tempDir = await getApplicationCacheDirectory();
    _scratchPadFile = File(scratchFilePath);

    await _scratchPadFile.writeAsString('''
void main() {
  for (int i = 0; i < 10; i++) {
    print('hello \${i + 1}');
  }
}
''', mode: FileMode.writeOnly);
    _initialiseCompleter.complete();
  }

  Future<String> fileContents() => _scratchPadFile.readAsString();

  Future<void> saveToFile({required String fileContents}) =>
      _scratchPadFile.writeAsString(fileContents);

  static FileIOService get locate => Locator.locate();
}
