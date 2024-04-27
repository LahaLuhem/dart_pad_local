import 'package:dart_pad_local/data/constants/const_media.dart';
import 'package:dart_pad_local/views/home_view_model.dart';
import 'package:fluent_ui/fluent_ui.dart';
import 'package:gap/gap.dart';
import 'package:veto/veto.dart';

class HomeView extends StatelessWidget {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder(
        viewModelBuilder: () => HomeViewModel(),
        builder: (context, model, isInitialised, _) {
          return ScaffoldPage(
            header: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Row(
                children: [
                  ConstMedia.buildIcon(
                    ConstMedia.dart_logo,
                    width: 28,
                    height: 28,
                  ),
                  const Gap(8),
                  Text(
                    'DartPad',
                    style: TextStyle(
                      fontSize: 18,
                    ),
                  ),
                ],
              ),
            ),
            content: Row(
              children: [
                Expanded(
                  child: Stack(
                    alignment: Alignment.topRight,
                    children: [
                      if (!isInitialised)
                        const ProgressRing()
                      else
                        TextBox(
                          maxLines: null,
                          controller: model.codeBoxController,
                        ),
                      Padding(
                        padding: const EdgeInsets.only(top: 32, right: 32),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            IconButton(
                              icon: Icon(FluentIcons.align_left),
                              onPressed: model.onFormatPressed,
                            ),
                            const Gap(8),
                            FilledButton(
                              child: const Text('Run'),
                              onPressed: model.onRunPressed,
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                const Gap(16),
                Expanded(
                  child: TextBox(
                    readOnly: true,
                    maxLines: null,
                    controller: model.outBoxController,
                  ),
                ),
              ],
            ),
          );
        });
  }
}
