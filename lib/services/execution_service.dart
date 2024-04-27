import 'package:dart_pad_local/locator.dart';
import 'package:dart_pad_local/services/file_io_service.dart';

import '/data/constants/const_values.dart';
import 'package:process_run/shell.dart';

class ExecutionService {
  final FileIOService _fileIOService;

  ExecutionService({
    required FileIOService fileIOService,
  }) : _fileIOService = fileIOService;

  final _shell = Shell();

  Future<({String result, bool wasError})> runFile() async {
    try {
      final results = await _shell.run('dart run ${_fileIOService.scratchFilePath}');
      return (result: results.outText, wasError: false);
    } on ShellException catch (ex) {
      return (result: ex.message, wasError: true);
    }
  }

  Future<void> formatFile() async {
    await _shell.run('dart format ${_fileIOService.scratchFilePath}');
  }

  static ExecutionService get locate => Locator.locate();
}
