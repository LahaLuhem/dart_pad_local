import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:dart_pad_local/data/constants/const_values.dart';

class FileIOService {
  final _scratchPadFile = File(ConstValues.scratchFilePath);

  FileIOService() {
    unawaited(_initialise());
  }

  final _initialiseCompleter = Completer<void>();
  Future<void> get initialiseAwaiter => _initialiseCompleter.future;

  Future<void> _initialise() async {
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
}
