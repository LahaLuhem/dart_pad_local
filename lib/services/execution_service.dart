import '/data/constants/const_values.dart';
import 'package:process_run/shell.dart';

class ExecutionService {
  final _shell = Shell();

  Future<({String result, bool wasError})> runFile() async {
    try {
      final results = await _shell.run('dart run ${ConstValues.scratchFilePath}');
      return (result: results.outText, wasError: false);
    } on ShellException catch (ex) {
      return (result: ex.message, wasError: true);
    }
  }

  Future<void> formatFile() async {
    await _shell.run('dart format ${ConstValues.scratchFilePath}');
  }
}
