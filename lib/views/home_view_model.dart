import 'dart:async';

import 'package:dart_pad_local/locator.dart';
import 'package:dart_pad_local/services/execution_service.dart';
import 'package:dart_pad_local/services/file_io_service.dart';
import 'package:fluent_ui/fluent_ui.dart';
import 'package:syntax_highlight/syntax_highlight.dart';
import 'package:veto/data/models/base_view_model.dart';

class HomeViewModel extends BaseViewModel<void> {
  final FileIOService _fileIOService;
  final ExecutionService _executionService;

  HomeViewModel({
    required FileIOService fileIOService,
    required ExecutionService executionService,
  })  : _fileIOService = fileIOService,
        _executionService = executionService;

  late final codeBoxController;
  final outBoxController = TextEditingController();

  @override
  Future<void> initialise() async {
    await _fileIOService.initialiseAwaiter;

    await Highlighter.initialize(['dart']);
    codeBoxController = _SyntaxTextEditingController(
      codeHighlighter: Highlighter(
        language: 'dart',
        theme: await HighlighterTheme.loadForContext(context!),
      ),
    );
    codeBoxController.text = await _fileIOService.fileContents();

    super.initialise();
  }

  Future<void> onFormatPressed() async {
    await _executionService.formatFile();
    codeBoxController.text = await _fileIOService.fileContents();
  }

  Future<void> onRunPressed() async {
    await _fileIOService.saveToFile(fileContents: codeBoxController.text);
    final commandOutput = await _executionService.runFile();
    outBoxController.text = commandOutput.result;
  }

  @override
  void dispose() {
    codeBoxController.dispose();

    super.dispose();
  }

  static HomeViewModel get locate => Locator.locate();
}

class _SyntaxTextEditingController extends TextEditingController {
  final Highlighter codeHighlighter;

  _SyntaxTextEditingController({
    required this.codeHighlighter,
  });

  @override
  TextSpan buildTextSpan({
    required BuildContext context,
    TextStyle? style,
    bool? withComposing,
  }) =>
      codeHighlighter.highlight(text);
}
