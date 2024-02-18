import 'package:flutter/material.dart';

class OnPopupWindowWidget extends StatelessWidget {
  const OnPopupWindowWidget({
    Key? key,
    this.title,
    this.child,
    this.footer,
    this.intend = 1,
    this.overlapChildren = const [],
    this.duration,
  }) : super(key: key);

  /// Popup window title
  final Widget? title;

  /// Popup window child
  final Widget? child;

  /// Popup window footer
  final Widget? footer;

  /// Main window intend. Use this if you have nested window. For first window intend = 1, next window intend = 2
  final int intend;

  /// Overlap children, Positional widget also can use here
  final List<Widget> overlapChildren;

  /// Container size changing animation duration
  final Duration? duration;

  @override
  Widget build(BuildContext context) {
    const duration = kThemeAnimationDuration;

    Widget mainWidget() {
      return AnimatedContainer(
        duration: duration,
      );
    }

    return MediaQuery.removeViewInsets(
      removeLeft: true,
      removeTop: true,
      removeRight: true,
      context: context,
      child: mainWidget(),
    );
  }
}
