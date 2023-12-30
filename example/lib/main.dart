import 'package:flutter/material.dart';
import 'package:on_popup_window_widget/on_popup_window_widget.dart';
import 'package:on_process_button_widget/on_process_button_widget.dart';

void main(List<String> args) {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        buttonTheme: const ButtonThemeData(height: 24 * 2),
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.amber, brightness: Brightness.light),
      ),
      darkTheme: ThemeData(
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.amber, brightness: Brightness.dark),
      ),
      themeMode: ThemeMode.light,
      // themeMode: ThemeMode.dark,
      home: Scaffold(
        body: Padding(
          padding: EdgeInsets.symmetric(vertical: 24),
          child: Center(
            child: MainWidget(),
          ),
        ),
      ),
    );
  }
}

class MainWidget extends StatelessWidget {
  const MainWidget({super.key});

  final String s = "Text(String data, {Key? key, TextStyle? style, StrutStyle? strutStyle, TextAlign? textAlign, TextDirection? textDirection, Locale? locale, bool? softWrap, TextOverflow? overflow, double? textScaleFactor, TextScaler? textScaler, int? maxLines, String? semanticsLabel, TextWidthBasis? textWidthBasis, TextHeightBehavior? textHeightBehavior, Color? selectionColor})";

  @override
  Widget build(BuildContext context) {
    return OnPopupWindowWidget(
      // contentPadding: 24,
      title: Container(
        color: Colors.green,
        child: const Text("I am a title."),
      ),
      footer: Container(
        color: Colors.blue,
        child: const Text("I am a title."),
      ),
      child: Container(
        color: Colors.blue,
        child: Column(
          children: [
            // Text(s),
            // Text(s),
            // Text(s),
            // Text(s),
            // Text(s),
            Text(s),
          ],
        ),
      ),
    );
  }
}
