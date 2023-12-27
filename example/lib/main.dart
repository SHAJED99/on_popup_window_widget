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
    return SingleChildScrollView(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          OnProcessButtonWidget(
            onTap: () async {
              await showDialog(
                context: context,
                builder: (context) {
                  return OnPopupWindowWidget(
                    // title: const Text("I am a title."),
                    // footer: Text(s),
                    footer: Container(
                      color: Colors.amber,
                      child: Column(
                        children: [
                          Text(s),
                          Text(s),
                          Text(s),
                          Text(s),
                          Text(s),
                          Text(s),
                        ],
                      ),
                    ),
                    child: Container(
                      color: Colors.blue,
                      child: Column(
                        children: [
                          Text(s),
                          Text(s),
                          Text(s),
                          Text(s),
                          Text(s),
                          Text(s),
                        ],
                      ),
                    ),
                    // child: Text(s),
                  );
                },
              );
              return;
            },
          ),
          // Spacer(),
          // BottomAppBar(),
          // OnPopupWindowWidget(
          //   title: const Text("I am a title."),
          //   footer: Text(s),
          //   child: Text(s),
          // ),
          // TimePickerDialog(initialTime: TimeOfDay.now()),

          // DatePickerDialog(
          //   firstDate: DateTime.now().subtract(Duration(days: 30)),
          //   lastDate: DateTime.now().add(Duration(days: 30)),
          // ),
        ],
      ),
    );
  }
}
