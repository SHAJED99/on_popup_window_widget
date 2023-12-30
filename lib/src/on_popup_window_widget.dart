import 'package:flutter/material.dart';

class OnPopupWindowWidget extends StatelessWidget {
  OnPopupWindowWidget({
    Key? key,
    this.borderRadius,
    this.child,
    this.contentPadding,
    this.crossAxisAlignment = CrossAxisAlignment.start,
    this.defaultTextStyle,
    this.defaultTextAlign = TextAlign.center,
    this.duration = const Duration(milliseconds: 200),
    this.footer,
    this.mainWindowPadding,
    this.maxBoxSize,
    this.title,
    this.width,
    this.supportedOrientation,
  }) : super(key: key);

  final BorderRadiusGeometry? borderRadius;
  final Widget? child;
  final CrossAxisAlignment crossAxisAlignment;
  final double? contentPadding;
  final TextStyle? defaultTextStyle;
  final TextAlign defaultTextAlign;
  final Duration duration;
  final Widget? footer;

  final EdgeInsetsGeometry? mainWindowPadding;
  final double? maxBoxSize;
  final Orientation? supportedOrientation;
  final Widget? title;
  final double? width;

  final ScrollController scrollController = ScrollController();

  @override
  Widget build(BuildContext context) {
    ThemeData theme = Theme.of(context);
    double p = contentPadding ?? theme.buttonTheme.height / 2;
    double bh = theme.buttonTheme.height;
    bool landscape = supportedOrientation != null ? MediaQuery.orientationOf(context) == supportedOrientation : MediaQuery.orientationOf(context) == Orientation.landscape;
    double maxWidth = landscape ? bh * 12 : maxBoxSize ?? bh * 7.5;
    double maxHeight = !landscape ? bh * 12 : maxBoxSize ?? bh * 7.5;
    bool useMaterial3 = theme.useMaterial3;

    Widget ____size() => SizedBox(height: p / 2, width: p / 2);

    Widget? animatedSize(Widget? innerChild) {
      if (title == null && child == null && footer == null) return null;
      return AnimatedSize(
        duration: duration,
        child: innerChild,
      );
    }

    Widget titleChild() {
      if (title == null) return const SizedBox();

      return Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: crossAxisAlignment,
        children: [
          ____size(),
          DefaultTextStyle(
            textAlign: TextAlign.start,
            style: theme.textTheme.titleMedium?.copyWith(color: theme.colorScheme.onBackground, fontWeight: FontWeight.bold) ?? const TextStyle(),
            child: Padding(padding: EdgeInsets.symmetric(horizontal: p), child: title!),
          ),
          ____size(),
          const Divider(height: 0),
        ],
      );
    }

    Widget childChild() {
      if (child == null) return const SizedBox();

      return Flexible(
        child: Padding(
          padding: EdgeInsets.only(top: p / 2),
          child: SingleChildScrollView(
            child: child,
          ),
        ),
      );
    }

    Widget footerChild() {
      if (footer == null) return const SizedBox();
      return Container(
        padding: EdgeInsets.only(top: p / 2),
        alignment: Alignment.centerRight,
        child: footer,
      );
    }

    return MediaQuery.removeViewInsets(
      removeLeft: true,
      removeTop: true,
      removeRight: true,
      removeBottom: true,
      context: context,
      child: Align(
        child: Container(
          constraints: BoxConstraints(maxWidth: maxWidth, maxHeight: maxHeight),
          margin: mainWindowPadding ?? EdgeInsets.all(p),
          child: Material(
            elevation: p,
            clipBehavior: Clip.antiAlias,
            surfaceTintColor: Colors.transparent,
            color: theme.colorScheme.background,
            borderRadius: borderRadius ?? BorderRadius.circular(p),
            child: Container(
              padding: EdgeInsets.symmetric(vertical: p / 2),
              decoration: BoxDecoration(color: useMaterial3 ? theme.colorScheme.primary.withOpacity(0.1) : theme.canvasColor),
              child: animatedSize(
                DefaultTextStyle(
                  style: Theme.of(context).textTheme.titleSmall?.copyWith(color: Theme.of(context).colorScheme.onBackground) ?? const TextStyle(),
                  child: Column(
                    crossAxisAlignment: crossAxisAlignment,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      titleChild(),
                      Flexible(
                        child: Padding(
                          padding: EdgeInsets.symmetric(horizontal: p),
                          child: Column(
                            crossAxisAlignment: crossAxisAlignment,
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              childChild(),
                              footerChild(),
                            ],
                          ),
                        ),
                      ),
                      ____size(),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
