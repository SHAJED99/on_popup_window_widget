import 'package:flutter/material.dart';

class OnPopupWindowWidget extends StatelessWidget {
  const OnPopupWindowWidget({
    Key? key,
    this.title,
    this.child,
    this.footer,
    this.intend = 1,
    this.overlapChildren = const [],
    this.duration = kThemeAnimationDuration,
    this.animationCurve = Curves.easeInOut,
    this.biggerMaxSize,
    this.smallerMaxSize,
    this.supportedOrientation,
    this.mainPadding,
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
  /// Default: kThemeAnimationDuration
  final Duration duration;

  /// Window bigger max size
  /// Default: theme.buttonTheme.height * 18
  final double? biggerMaxSize;

  /// Window smaller max size
  /// Default: theme.buttonTheme.height * 10
  final double? smallerMaxSize;

  /// Supported device orientation
  /// Default: null for supporting both landscape and portrait
  final Orientation? supportedOrientation;

  /// Default: theme.buttonTheme.height/2
  final EdgeInsetsGeometry? mainPadding;

  final Curve animationCurve;

  @override
  Widget build(BuildContext context) {
    final landscape = supportedOrientation != null ? Orientation.landscape == supportedOrientation : MediaQuery.orientationOf(context) == Orientation.landscape;

    final theme = Theme.of(context);
    final m = MediaQuery.of(context);
    final vP = m.viewInsets;
    final bh = theme.buttonTheme.height;
    final width = m.size.width;
    final height = m.size.height;

    // final showPadding = ((landscape ? width : height) - m.viewInsets.bottom) < (biggerMaxSize ?? bh * 16);

    // final double padding = (mainPadding ?? bh / 2);
    // final hPadding = padding; //! TODO
    // final vPadding = padding; //! TODO
    final maxWidth = landscape ? biggerMaxSize ?? (bh * 18) : smallerMaxSize ?? (bh * 10);
    final maxHeight = !landscape ? biggerMaxSize ?? (bh * 18) : smallerMaxSize ?? (bh * 10);

    // Widget animatedChild1({Widget? child}) {
    //   if (child == null) return const SizedBox();

    //   return AnimatedContainer(
    //     duration: duration,
    //     decoration: const BoxDecoration(color: Colors.amber),
    //     constraints: BoxConstraints(
    //       maxWidth: maxWidth,
    //       maxHeight: maxHeight,
    //     ),
    //     child: child,
    //   );
    // }

    // Widget animatedChild2({Widget? child}) {
    //   if (child == null) return const SizedBox();

    //   return AnimatedContainer(
    //     duration: duration,
    //     child: child,
    //   );
    // }

    Widget fitMe({Widget? child}) {
      if (child == null) return const SizedBox();

      return FittedBox(
        fit: BoxFit.scaleDown,
        // child: animatedChild2(
        child: child,
        // ),
      );
    }

    // Widget mainPadding({Widget? child}) {
    //   return Container(
    //     constraints: BoxConstraints(maxWidth: width - hPadding, maxHeight: height - vPadding),
    //     child: child,
    //   );
    // }

    // Widget mainWidget() {
    //   return mainPadding(
    //     child: Material(
    //       elevation: 24, //! TODO
    //       clipBehavior: Clip.antiAlias,
    //       borderRadius: BorderRadius.circular(padding / 2), //! TODO
    //       child: animatedChild1(
    //         child: Column(
    //           // crossAxisAlignment: CrossAxisAlignment.stretch,
    //           mainAxisSize: MainAxisSize.min,
    //           children: [
    //             //! Title
    //             Padding(
    //               padding: const EdgeInsets.only(),
    //               child: fitMe(child: title),
    //             ),

    //             //! Child
    //             Flexible(
    //               child: SingleChildScrollView(
    //                 child: fitMe(child: child),
    //               ),
    //             ),

    //             //! Footer
    //             fitMe(child: footer),
    //           ],
    //         ),
    //       ),
    //     ),
    //   );
    // }

    // Widget mainScreenPadding(Widget? c) {
    //   return Container(
    //     // margin: mainPadding ?? EdgeInsets.all(bh / 2),
    //     padding: mainPadding ?? EdgeInsets.all(bh / 2),
    //     child: c,
    //   );
    // }

    // Widget mainWidget() {
    //   return Container(
    //     decoration: BoxDecoration(color: theme.colorScheme.background),
    //     constraints: BoxConstraints(maxWidth: maxWidth),
    //     child: mainScreenPadding(child),
    //   );
    // }

    Widget animatedContainer(Widget c) => AnimatedContainer(duration: duration, curve: animationCurve, child: c);

    return MediaQuery.removeViewInsets(
      removeLeft: true,
      removeTop: true,
      removeRight: true,
      removeBottom: true,
      context: context,
      child: Container(
        margin: EdgeInsets.only(top: vP.top, bottom: vP.bottom, left: vP.left, right: vP.right),
        child: Align(child: LayoutBuilder(
          builder: (_, constrains) {
            print(constrains.flipped);
            return Material(
              // color: Colors.transparent,

              child: Container(
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      if (title != null) title!,
                      if (child != null) child!,
                      if (footer != null) footer!
                    ],
                  ),
                ),
              ),
            );
          },
        )),
      ),
    );
  }
}
