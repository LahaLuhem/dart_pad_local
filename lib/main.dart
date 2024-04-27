import 'package:dart_pad_local/locator.dart';
import 'package:dart_pad_local/views/home_view.dart';
import 'package:fluent_ui/fluent_ui.dart';

Future<void> main() async {
  await Locator.setup();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return FluentApp(
      title: 'Flutter Demo',
      home: const HomeView(),
    );
  }
}
