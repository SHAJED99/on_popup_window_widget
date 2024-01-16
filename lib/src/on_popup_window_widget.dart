import 'package:flutter/material.dart';

class OnPopupWindowWidget extends StatelessWidget {
  const OnPopupWindowWidget({
    Key? key,
    this.mainWindowAlignment = Alignment.center,
    this.borderRadius,
    this.child,
    this.contentPadding,
    this.centerTitle,
    this.defaultTextStyle,
    this.defaultTextAlign = TextAlign.center,
    this.duration = const Duration(milliseconds: 500),
    this.footer,
    this.mainWindowPadding,
    this.mainWindowMaxPadding,
    this.smallerMaxSize,
    this.biggerMaxSize,
    this.title,
    this.divider,
    this.supportedOrientation,
    this.titleTextStyle,
    this.windowElevation,
    this.overlapChildren = const [],
    this.useMaterial3,
    this.fontColor,
    this.childScrollController,
  })  : _fullScreenMode = true,
        super(key: key);

  const OnPopupWindowWidget.widgetMode({
    Key? key,
    this.mainWindowAlignment = Alignment.center,
    this.borderRadius,
    this.child,
    this.contentPadding,
    this.centerTitle,
    this.defaultTextStyle,
    this.defaultTextAlign = TextAlign.center,
    this.duration = const Duration(milliseconds: 500),
    this.footer,
    this.mainWindowPadding,
    this.mainWindowMaxPadding,
    this.smallerMaxSize,
    this.biggerMaxSize,
    this.title,
    this.divider,
    this.supportedOrientation,
    this.titleTextStyle,
    this.windowElevation,
    this.overlapChildren = const [],
    this.useMaterial3,
    this.fontColor,
    this.childScrollController,
  })  : _fullScreenMode = false,
        super(key: key);

  /// Popup window alignment on the screen
  final AlignmentGeometry mainWindowAlignment;

  /// Popup window padding from screen
  final EdgeInsetsGeometry? mainWindowPadding;

  /// Max popup window padding from screen
  /// Default: (contentPadding ?? theme.buttonTheme.height / 2) * 4
  final double? mainWindowMaxPadding;

  /// Default: theme.buttonTheme.height/2
  final double? contentPadding;

  /// Default: BorderRadius.circular(theme.buttonTheme.height/2)
  final BorderRadiusGeometry? borderRadius;

  /// Popup window title
  final Widget? title;

  /// Default: Divider(height: 0)
  final Widget? divider;

  /// Popup window child
  final Widget? child;

  /// Popup window footer
  final Widget? footer;

  /// Default: theme.appBarTheme.centerTitle ?? false
  final bool? centerTitle;

  /// Default: theme.dialogTheme.titleTextStyle ?? theme.textTheme.titleMedium?.copyWith(color: theme.colorScheme.onBackground, fontWeight: FontWeight.bold) ?? const TextStyle()
  final TextStyle? titleTextStyle;

  /// Child and footer text align
  final TextAlign defaultTextAlign;

  /// Child and footer text style
  /// Default: theme.dialogTheme.contentTextStyle ?? theme.textTheme.titleSmall?.copyWith(color: theme.colorScheme.onBackground) ?? const TextStyle(),
  final TextStyle? defaultTextStyle;

  /// Container size changing animation duration
  final Duration duration;

  /// Window smaller max size
  /// Default: theme.buttonTheme.height * 10
  final double? smallerMaxSize;

  /// Window bigger max size
  /// Default: theme.buttonTheme.height * 16
  final double? biggerMaxSize;

  /// Supported device orientation
  /// Default: null for supporting both landscape and portrait
  final Orientation? supportedOrientation;

  /// Window elevation
  /// Default: theme.dialogTheme.elevation ?? theme.buttonTheme.height / 2
  final double? windowElevation;

  /// Overlap children, Positional widget also can use here
  final List<Widget> overlapChildren;

  /// User Material 3 theme
  final bool? useMaterial3;

  /// Default font color
  final Color? fontColor;

  /// Child ScrollController
  final ScrollController? childScrollController;

  final bool _fullScreenMode;

  Color inverseCanvasColor(Color color) {
    return Color.fromRGBO(
        255 - color.red, 255 - color.green, 255 - color.blue, color.opacity);
  }

  @override
  Widget build(BuildContext context) {
    MediaQueryData m = MediaQuery.of(context);
    ThemeData theme = Theme.of(context);
    double bh = theme.buttonTheme.height;
    bool landscape = supportedOrientation != null
        ? Orientation.landscape == supportedOrientation
        : MediaQuery.orientationOf(context) == Orientation.landscape;
    bool showPadding =
        ((landscape ? m.size.width : m.size.height) - m.viewInsets.bottom) <
            (biggerMaxSize ?? bh * 16);
    double maxWidth =
        landscape ? biggerMaxSize ?? (bh * 16) : smallerMaxSize ?? (bh * 10);
    double maxHeight =
        !landscape ? biggerMaxSize ?? (bh * 16) : smallerMaxSize ?? (bh * 10);
    double p = (contentPadding ?? theme.buttonTheme.height / 2);

    bool material3 = useMaterial3 ?? theme.useMaterial3;
    Color fc = fontColor ??
        (material3
            ? theme.colorScheme.onBackground
            : inverseCanvasColor(theme.canvasColor));

    Widget size([i]) => SizedBox(height: p / (i ?? 2), width: p / (i ?? 2));

    Widget animatedSize2(Widget? innerChild) {
      if (title == null && child == null && footer == null) {
        return const SizedBox();
      }
      return AnimatedContainer(
        // width: maxWidth,
        curve: Curves.easeInOut,
        duration: duration,
        constraints: BoxConstraints(maxWidth: maxWidth),
        child: innerChild ?? const SizedBox(),
      );
    }

    Widget titleChild() {
      if (title == null) return const SizedBox();

      bool c = (centerTitle ?? (theme.appBarTheme.centerTitle ?? false));

      return Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment:
            c ? CrossAxisAlignment.center : CrossAxisAlignment.start,
        children: [
          DefaultTextStyle(
            textAlign: c ? TextAlign.center : TextAlign.start,
            style: titleTextStyle ??
                theme.dialogTheme.titleTextStyle ??
                theme.textTheme.titleMedium
                    ?.copyWith(color: fc, fontWeight: FontWeight.bold) ??
                TextStyle(color: fontColor ?? theme.colorScheme.onBackground),
            child: Padding(
                padding: EdgeInsets.symmetric(horizontal: p), child: title!),
          ),
          size(),
          divider ?? const Divider(height: 0),
          size(4),
        ],
      );
    }

    Widget childChild() {
      if (child == null) return const SizedBox();

      return Flexible(
        child: SingleChildScrollView(
          controller: childScrollController,
          child: AnimatedSize(
            alignment: Alignment.topCenter,
            curve: Curves.easeInOut,
            duration: duration,
            child: Container(
              constraints: BoxConstraints(maxWidth: maxWidth),
              margin: EdgeInsets.only(top: p / 4, bottom: p / 4),
              padding: EdgeInsets.symmetric(horizontal: p),
              child: child,
            ),
          ),
        ),
      );
    }

    Widget footerChild() {
      if (footer == null) return const SizedBox();
      return Container(
        padding: EdgeInsets.only(left: p, right: p, top: p / 4),
        alignment: Alignment.centerRight,
        child: footer,
      );
    }

    Widget mainWidget() {
      return FittedBox(
        fit: BoxFit.contain,
        child: AnimatedContainer(
          curve: Curves.easeInOut,
          duration: duration,
          constraints: BoxConstraints(maxHeight: maxHeight),
          margin: mainWindowPadding ??
              EdgeInsets.only(
                left: (landscape
                        ? (showPadding ? p : (mainWindowMaxPadding ?? p * 4))
                        : p) +
                    m.viewInsets.left,
                right: (landscape
                        ? (showPadding ? p : (mainWindowMaxPadding ?? p * 4))
                        : p) +
                    m.viewInsets.right,
                top: (!landscape
                        ? (showPadding ? p : (mainWindowMaxPadding ?? p * 4))
                        : p) +
                    m.viewInsets.top,
                bottom: (!landscape
                        ? (showPadding ? p : (mainWindowMaxPadding ?? p * 4))
                        : p) +
                    m.viewInsets.bottom,
              ),
          child: Stack(
            clipBehavior: Clip.none,
            children: [
              Material(
                elevation: windowElevation ??
                    theme.dialogTheme.elevation ??
                    theme.buttonTheme.height / 2,
                clipBehavior: Clip.antiAlias,
                surfaceTintColor: Colors.transparent,
                color: theme.colorScheme.background,
                borderRadius: borderRadius ??
                    BorderRadius.circular(theme.buttonTheme.height / 2),
                child: Container(
                  padding: EdgeInsets.symmetric(vertical: p),
                  decoration: BoxDecoration(
                      color: material3
                          ? theme.dialogTheme.backgroundColor ??
                              theme.colorScheme.primary.withOpacity(0.1)
                          : theme.canvasColor),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      animatedSize2(titleChild()),
                      Flexible(
                        child: DefaultTextStyle(
                          textAlign: defaultTextAlign,
                          style: defaultTextStyle ??
                              theme.dialogTheme.contentTextStyle ??
                              theme.textTheme.titleSmall?.copyWith(color: fc) ??
                              TextStyle(
                                  color: fontColor ??
                                      theme.colorScheme.onBackground),
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              childChild(),
                              animatedSize2(footerChild()),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              for (Widget w in overlapChildren) w
            ],
          ),
        ),
      );
    }

    if (!_fullScreenMode) return mainWidget();

    return MediaQuery.removeViewInsets(
      removeLeft: true,
      removeTop: true,
      removeRight: true,
      removeBottom: true,
      context: context,
      child: Align(
        alignment: mainWindowAlignment,
        child: mainWidget(),
      ),
    );
  }
}
