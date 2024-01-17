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
      debugShowCheckedModeBanner: false,
      theme: ThemeData(useMaterial3: false, colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue, brightness: Brightness.dark)),
      darkTheme: ThemeData(useMaterial3: false, colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue, brightness: Brightness.dark)),
      themeMode: ThemeMode.light,
      // themeMode: ThemeMode.dark,
      home: Scaffold(
        body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 24),
            child: Center(
              child: MainWidget(),
            ),
          ),
        ),
      ),
    );
  }
}

class MainWidget extends StatelessWidget {
  MainWidget({super.key});

  final List<String> lan = [
    "Bangle",
    "English",
    "Spanish",
    "French",
    "German",
    "Chinese",
    "Hindi",
    "Arabic",
    "Russian",
    "Portuguese",
    "Japanese",
    "Italian",
  ];

  List<Widget> children(BuildContext context) {
    List<Widget> res = lan
        .map(
          (e) => Text(e),
        )
        .toList();

    return res + res;
  }

  Future<void> showCustomDialog(BuildContext context, int intend) {
    return showDialog(
      context: context,
      builder: (context) => OnPopupWindowWidget(
        intend: intend,
        title: const Text("Please select your Language"),
        footer: OnProcessButtonWidget(
          expanded: false,
          onTap: () async {
            await showCustomDialog(context, intend + 1);
            return;
          },
          child: const Text("Okay"),
        ),
        overlapChildren: const [
          Positioned(
            right: -10,
            top: -10,
            child: OnProcessButtonWidget(
              contentPadding: EdgeInsets.zero,
              child: Icon(Icons.cancel, color: Colors.white),
            ),
          ),
        ],
        child: Column(children: children(context)),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        //! Responsive
        OnProcessButtonWidget(
          expanded: false,
          onTap: () => showDialog(
            context: context,
            builder: (context) => OnPopupWindowWidget(
              title: const Text("Please select your Language"),
              footer: const OnProcessButtonWidget(expanded: false, child: Text("Okay")),
              child: Column(children: children(context)),
            ),
          ),
          child: const Text("Press here"),
        ),

        //! Overlay Widget
        OnProcessButtonWidget(
          expanded: false,
          onTap: () async {
            await showCustomDialog(context, 1);
            return;
          },
          child: const Text("Overlay Widget"),
        ),

        //! Widget Mode
        Expanded(
          child: Center(
            child: OnPopupWindowWidget.widgetMode(
              title: const Text("Please select your Language"),
              footer: const OnProcessButtonWidget(
                expanded: false,
                child: Text("Okay"),
              ),
              overlapChildren: const [
                Positioned(
                  right: -10,
                  top: -10,
                  child: OnProcessButtonWidget(
                    contentPadding: EdgeInsets.zero,
                    child: Icon(Icons.cancel, color: Colors.white),
                  ),
                ),
              ],
              child: Column(children: children(context)),
            ),
          ),
        )
      ],
    );
  }
}
