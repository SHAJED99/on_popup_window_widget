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
    this.biggerMaxSize,
    this.smallerMaxSize,
    this.supportedOrientation,
    this.contentPadding,
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
  final Duration? duration;

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
  final double? contentPadding;

  @override
  Widget build(BuildContext context) {
    final landscape = supportedOrientation != null ? Orientation.landscape == supportedOrientation : MediaQuery.orientationOf(context) == Orientation.landscape;

    const duration = kThemeAnimationDuration; //! TODO
    final theme = Theme.of(context);
    final m = MediaQuery.of(context);
    final bh = theme.buttonTheme.height;
    final width = m.size.width;
    final height = m.size.height;
    final showPadding = ((landscape ? width : height) - m.viewInsets.bottom) < (biggerMaxSize ?? bh * 16);

    final double padding = (contentPadding ?? bh / 2);
    final hPadding = padding; //! TODO
    final vPadding = padding; //! TODO
    final maxWidth = landscape ? biggerMaxSize ?? (bh * 18) : smallerMaxSize ?? (bh * 10);
    final maxHeight = !landscape ? biggerMaxSize ?? (bh * 18) : smallerMaxSize ?? (bh * 10);

    Widget animatedChild1({Widget? child}) {
      if (child == null) return const SizedBox();

      return AnimatedContainer(
        duration: duration,
        decoration: const BoxDecoration(color: Colors.amber),
        constraints: BoxConstraints(
          maxWidth: maxWidth,
          maxHeight: maxHeight,
        ),
        child: child,
      );
    }

    Widget animatedChild2({Widget? child}) {
      if (child == null) return const SizedBox();

      return AnimatedContainer(
        padding: EdgeInsets.symmetric(horizontal: hPadding, vertical: vPadding / 2),
        duration: duration,
        child: child,
      );
    }

    Widget fitMe({Widget? child}) {
      if (child == null) return const SizedBox();

      return FittedBox(
        fit: BoxFit.scaleDown,
        child: animatedChild2(
          child: child,
        ),
      );
    }

    Widget mainPadding({Widget? child}) {
      return Container(
        constraints: BoxConstraints(maxWidth: width - hPadding, maxHeight: height - vPadding),
        child: child,
      );
    }

    Widget mainWidget() {
      return mainPadding(
        child: Material(
          elevation: 24, //! TODO
          clipBehavior: Clip.antiAlias,
          borderRadius: BorderRadius.circular(padding / 2), //! TODO
          child: animatedChild1(
            child: Column(
              // crossAxisAlignment: CrossAxisAlignment.stretch,
              mainAxisSize: MainAxisSize.min,
              children: [
                //! Title
                fitMe(child: title),

                //! Child
                Flexible(
                  child: SingleChildScrollView(
                    child: fitMe(child: child),
                  ),
                ),

                //! Footer
                fitMe(child: footer),
              ],
            ),
          ),
        ),
      );
    }

    return MediaQuery.removeViewInsets(
      removeLeft: true,
      removeTop: true,
      removeRight: true,
      context: context,
      child: Align(
        child: SingleChildScrollView(
          child: mainWidget(),
        ),
      ),
    );
  }
}
