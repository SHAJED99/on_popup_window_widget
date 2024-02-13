import 'package:flutter/material.dart';

class OnPopupWindowWidget extends StatefulWidget {
  const OnPopupWindowWidget({
    Key? key,
    this.mainWindowAlignment = Alignment.center,
    this.borderRadius,
    this.child,
    this.contentPadding,
    this.centerTitle,
    this.defaultTextStyle,
    this.defaultTextAlign = TextAlign.start,
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
    this.intend = 0,
    this.childCrossAxisAlignment = CrossAxisAlignment.start,
    this.curve = Curves.easeInOut,
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
    this.defaultTextAlign = TextAlign.start,
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
    this.intend = 1,
    this.childCrossAxisAlignment = CrossAxisAlignment.start,
    this.curve = Curves.easeInOut,
  })  : _fullScreenMode = false,
        super(key: key);

  /// Window bigger max size
  /// Default: theme.buttonTheme.height * 16
  final double? biggerMaxSize;

  /// Default: BorderRadius.circular(theme.buttonTheme.height/2)
  final BorderRadiusGeometry? borderRadius;

  /// Default: theme.appBarTheme.centerTitle ?? false
  final bool? centerTitle;

  /// Popup window child
  final Widget? child;

  /// Child ScrollController
  final ScrollController? childScrollController;

  /// Default: theme.buttonTheme.height/2
  final double? contentPadding;

  /// Child and footer text align
  final TextAlign defaultTextAlign;

  /// Child and footer text style
  /// Default: theme.dialogTheme.contentTextStyle ?? theme.textTheme.titleSmall?.copyWith(color: theme.colorScheme.onBackground) ?? const TextStyle(),
  final TextStyle? defaultTextStyle;

  /// Default: Divider(height: 0)
  final Widget? divider;

  /// Container size changing animation duration
  final Duration duration;

  /// Default font color
  final Color? fontColor;

  /// Popup window footer
  final Widget? footer;

  /// Main window intend. Use this if you have nested window. For first window intend = 1, next window intend = 2
  final int intend;

  /// Popup window alignment on the screen
  final AlignmentGeometry mainWindowAlignment;

  /// Max popup window padding from screen
  /// Default: (contentPadding ?? theme.buttonTheme.height / 2) * 4
  final double? mainWindowMaxPadding;

  /// Popup window padding from screen
  final EdgeInsetsGeometry? mainWindowPadding;

  /// Overlap children, Positional widget also can use here
  final List<Widget> overlapChildren;

  /// Window smaller max size
  /// Default: theme.buttonTheme.height * 10
  final double? smallerMaxSize;

  /// Supported device orientation
  /// Default: null for supporting both landscape and portrait
  final Orientation? supportedOrientation;

  /// Popup window title
  final Widget? title;

  /// Default: theme.dialogTheme.titleTextStyle ?? theme.textTheme.titleMedium?.copyWith(color: theme.colorScheme.onBackground, fontWeight: FontWeight.bold) ?? const TextStyle()
  final TextStyle? titleTextStyle;

  /// User Material 3 theme
  final bool? useMaterial3;

  /// Window elevation
  /// Default: theme.dialogTheme.elevation ?? theme.buttonTheme.height / 2
  final double? windowElevation;

  /// Child CrossAxisAlignment
  final CrossAxisAlignment childCrossAxisAlignment;

  /// Animation curve
  final Curve curve;

  final bool _fullScreenMode;

  @override
  State<OnPopupWindowWidget> createState() => _OnPopupWindowWidgetState();
}

class _OnPopupWindowWidgetState extends State<OnPopupWindowWidget> {
  Color inverseCanvasColor(Color color) => Color.fromRGBO(255 - color.red, 255 - color.green, 255 - color.blue, color.opacity);

  Widget mainWidget() {
    MediaQueryData m = MediaQuery.of(context);
    final width = m.size.width;
    final height = m.size.height;
    ThemeData theme = Theme.of(context);
    double bh = theme.buttonTheme.height;
    bool landscape = widget.supportedOrientation != null ? Orientation.landscape == widget.supportedOrientation : MediaQuery.orientationOf(context) == Orientation.landscape;
    bool showPadding = ((landscape ? width : height) - m.viewInsets.bottom) < (widget.biggerMaxSize ?? bh * 16);
    double maxWidth = landscape ? widget.biggerMaxSize ?? (bh * 16) : widget.smallerMaxSize ?? (bh * 10);
    double maxHeight = !landscape ? widget.biggerMaxSize ?? (bh * 16) : widget.smallerMaxSize ?? (bh * 10);
    // double p = (contentPadding ?? theme.buttonTheme.height / 2);
    double p = (widget.contentPadding ?? theme.buttonTheme.height / 2);

    bool material3 = widget.useMaterial3 ?? theme.useMaterial3;
    Color fc = widget.fontColor ?? (material3 ? theme.colorScheme.onBackground : inverseCanvasColor(theme.canvasColor));

    Widget size([i]) => SizedBox(height: p / (i ?? 2), width: p / (i ?? 2));

    Widget animatedSize2(Widget? innerChild) {
      if (widget.title == null && widget.child == null && widget.footer == null) {
        return const SizedBox();
      }
      return AnimatedContainer(
        width: maxWidth,
        curve: widget.curve,
        duration: widget.duration,
        constraints: BoxConstraints(maxWidth: maxWidth),
        child: innerChild ?? const SizedBox(),
      );
    }

    Widget titleChild() {
      if (widget.title == null) return const SizedBox();

      bool c = (widget.centerTitle ?? (theme.appBarTheme.centerTitle ?? false));

      return Column(
        // key: _keyTitleChild,
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: c ? CrossAxisAlignment.center : CrossAxisAlignment.start,
        children: [
          DefaultTextStyle(
            textAlign: c ? TextAlign.center : TextAlign.start,
            style: widget.titleTextStyle ?? theme.dialogTheme.titleTextStyle ?? theme.textTheme.titleSmall?.copyWith(color: fc, fontWeight: FontWeight.bold) ?? TextStyle(color: widget.fontColor ?? theme.colorScheme.onBackground),
            child: Padding(padding: EdgeInsets.symmetric(horizontal: p), child: widget.title!),
          ),
          size(),
          widget.divider ?? const Divider(height: 0),
          size(4),
        ],
      );
    }

    Widget childChild() {
      if (widget.child == null) return const SizedBox();

      return Flexible(
        // key: _keyChildChild,
        child: SingleChildScrollView(
          controller: widget.childScrollController,
          child: AnimatedSize(
            alignment: Alignment.topCenter,
            curve: widget.curve,
            duration: widget.duration,
            child: AnimatedContainer(
              constraints: BoxConstraints(maxWidth: maxWidth),
              margin: EdgeInsets.only(top: p / 4, bottom: p / 4),
              padding: EdgeInsets.symmetric(horizontal: p),
              duration: widget.duration,
              child: widget.child,
            ),
          ),
        ),
      );
    }

    Widget footerChild() {
      if (widget.footer == null) return const SizedBox();
      return Container(
        // key: _keyFooterChild,
        padding: EdgeInsets.only(left: p, right: p, top: p / 4),
        alignment: Alignment.centerRight,
        child: widget.footer,
      );
    }

    Widget subMainWindow1 = KeepAlive(
      keepAlive: true,
      child: Stack(
        clipBehavior: Clip.none,
        children: [
          Material(
            elevation: widget.windowElevation ?? theme.dialogTheme.elevation ?? theme.buttonTheme.height / 2,
            clipBehavior: Clip.antiAlias,
            surfaceTintColor: Colors.transparent,
            color: theme.colorScheme.background,
            borderRadius: widget.borderRadius ?? BorderRadius.circular(theme.buttonTheme.height / 2),
            child: Container(
              padding: EdgeInsets.symmetric(vertical: p),
              decoration: BoxDecoration(color: material3 ? theme.dialogTheme.backgroundColor ?? theme.colorScheme.primary.withOpacity(0.1) : theme.canvasColor),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  animatedSize2(titleChild()),
                  Flexible(
                    child: DefaultTextStyle(
                      textAlign: widget.defaultTextAlign,
                      style: widget.defaultTextStyle ?? theme.dialogTheme.contentTextStyle ?? theme.textTheme.titleSmall?.copyWith(color: fc) ?? TextStyle(color: widget.fontColor ?? theme.colorScheme.onBackground),
                      child: Column(
                        crossAxisAlignment: widget.childCrossAxisAlignment,
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
          for (Widget w in widget.overlapChildren) w
        ],
      ),
    );

    double? left() {
      return (landscape ? (showPadding ? p : (widget.mainWindowMaxPadding ?? p * 4)) : p) + m.viewInsets.left;
    }

    double? right() {
      return (landscape ? (showPadding ? p : (widget.mainWindowMaxPadding ?? p * 4)) : p) + m.viewInsets.right;
    }

    double? top() {
      return (!landscape ? (showPadding ? p : (widget.mainWindowMaxPadding ?? p * 4)) : p) + m.viewInsets.top;
    }

    double? bottom() {
      return (!landscape ? (showPadding ? p : (widget.mainWindowMaxPadding ?? p * 4)) : p) + m.viewInsets.bottom;
    }

    return !widget._fullScreenMode
        ? subMainWindow1
        : Align(
            child: AnimatedContainer(
              curve: widget.curve,
              duration: widget.duration,
              // width: m.size.width - (left() ?? 0) - (right() ?? 0),
              // height: m.size.height - (top() ?? 0) - (bottom() ?? 0),
              alignment: Alignment.center,
              constraints: BoxConstraints(maxHeight: maxHeight, maxWidth: maxWidth),
              margin: widget.mainWindowPadding ??
                  EdgeInsets.only(
                    left: left() ?? 0,
                    right: right() ?? 0,
                    top: top() ?? 0,
                    bottom: bottom() ?? 0,
                  ),
              child: Container(
                margin: EdgeInsets.all(p * widget.intend),
                child: subMainWindow1,
              ),
            ),
          );
  }

  @override
  Widget build(BuildContext context) {
    if (!widget._fullScreenMode) return mainWidget();

    return MediaQuery.removeViewInsets(
      removeLeft: true,
      removeTop: true,
      removeRight: true,
      context: context,
      child: mainWidget(),
    );
  }
}
