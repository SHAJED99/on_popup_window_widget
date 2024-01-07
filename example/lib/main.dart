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
      theme: ThemeData(useMaterial3: true, colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue, brightness: Brightness.light)),
      darkTheme: ThemeData(useMaterial3: true, colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue, brightness: Brightness.dark)),
      // themeMode: ThemeMode.light,
      themeMode: ThemeMode.dark,
      home: Scaffold(
        body: Padding(
          padding: const EdgeInsets.symmetric(vertical: 24),
          child: Center(
            child: MainWidget(),
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
    return lan
        .map(
          (e) => OnProcessButtonWidget(
            backgroundColor: Theme.of(context).colorScheme.primary.withOpacity(0.1),
            fontColor: Theme.of(context).colorScheme.onBackground,
            margin: const EdgeInsets.symmetric(vertical: 4),
            child: Text(e),
          ),
        )
        .toList();
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
          onTap: () => showDialog(
            context: context,
            builder: (context) => OnPopupWindowWidget(
              title: const Text("Please select your Language"),
              footer: const OnProcessButtonWidget(expanded: false, child: Text("Okay")),
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
          child: const Text("Overlay Widget"),
        ),

        //! Widget Mode
        Flexible(
          child: OnPopupWindowWidget.widgetMode(
            title: const Text("Please select your Language"),
            footer: const OnProcessButtonWidget(expanded: false, child: Text("Okay")),
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
        )
      ],
    );
  }
}
