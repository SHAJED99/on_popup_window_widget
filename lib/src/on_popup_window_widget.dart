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
    this.indentIndex = 0,
    this.mainWindowPadding,
    this.maxBoxSize,
    this.title,
    this.width,
  }) : super(key: key);

  final BorderRadiusGeometry? borderRadius;
  final Widget? child;
  final CrossAxisAlignment crossAxisAlignment;
  final EdgeInsetsGeometry? contentPadding;
  final TextStyle? defaultTextStyle;
  final TextAlign defaultTextAlign;
  final Duration duration;
  final Widget? footer;

  final int indentIndex;
  final EdgeInsetsGeometry? mainWindowPadding;
  final double? maxBoxSize;
  final Widget? title;
  final double? width;

  final ScrollController scrollController = ScrollController();

  @override
  Widget build(BuildContext context) {
    ThemeData theme = Theme.of(context);
    double p = theme.buttonTheme.height;
    Size size = MediaQuery.of(context).size;
    bool landscape = MediaQuery.orientationOf(context) == Orientation.landscape;
    double maxWidth = landscape ? p * 12 : maxBoxSize ?? p * 7;
    double maxHeight = !landscape ? p * 12 : maxBoxSize ?? p * 7;
    bool useMaterial3 = theme.useMaterial3;

    Widget animatedSize(Widget? innerChild) {
      return AnimatedSize(
        duration: duration,
        child: innerChild,
      );
    }

    Widget titleChild() {
      return animatedSize(
        title == null
            ? null
            : Column(
                crossAxisAlignment: crossAxisAlignment,
                children: [
                  DefaultTextStyle(
                    textAlign: TextAlign.start,
                    style: theme.textTheme.titleMedium?.copyWith(color: theme.colorScheme.onBackground, fontWeight: FontWeight.bold) ?? const TextStyle(),
                    child: Padding(padding: contentPadding ?? EdgeInsets.symmetric(horizontal: p / 2), child: title!),
                  ),
                  Padding(padding: EdgeInsets.symmetric(vertical: contentPadding?.vertical ?? p / 4), child: const Divider(height: 0)),
                ],
              ),
      );
    }

    Widget childChild() {
      return Container(
        constraints: landscape ? null : BoxConstraints(maxHeight: (size.height / 2) - (p * 2)),
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: p / 2),
            child: child,
          ),
        ),
      );
    }

    Widget footerChild() {
      return Column(
        crossAxisAlignment: crossAxisAlignment,
        children: [
          SizedBox(height: p / 4),
          Container(
            constraints: BoxConstraints(maxHeight: (size.height / 4) - (p / 2)),
            child: SingleChildScrollView(
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: p / 2),
                child: footer,
              ),
            ),
          ),
        ],
      );
    }

    Widget childOrientation() {
      if (landscape)
        return Column(
          children: [
            titleChild(),
            Row(
              children: [
                Flexible(child: childChild()),
                // Flexible(child: footerChild()),
              ],
            ),
          ],
        );

      return SingleChildScrollView(
        child: Column(
          children: [
            titleChild(),
            childChild(),
            footerChild(),
          ],
        ),
      );
    }

    return MediaQuery.removeViewInsets(
      removeLeft: true,
      removeTop: true,
      removeRight: true,
      removeBottom: true,
      context: context,
      child: Center(
        child: animatedSize(
          Container(
            constraints: BoxConstraints(maxWidth: maxWidth, maxHeight: maxHeight),
            margin: mainWindowPadding ?? EdgeInsets.all(p / 2),
            child: Material(
              elevation: p / 2,
              color: theme.colorScheme.background,
              clipBehavior: Clip.antiAlias,
              borderRadius: borderRadius ?? BorderRadius.circular(p / 2),
              child: Container(
                padding: contentPadding ?? EdgeInsets.symmetric(vertical: p / 2),
                // constraints: BoxConstraints(maxHeight: ),
                decoration: BoxDecoration(color: useMaterial3 ? theme.colorScheme.primary.withOpacity(0.1) : theme.canvasColor),
                // child: CustomScrollView(slivers: []),

                // child: Center(child: Text(landscape.toString())),

                child: childOrientation(),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

// class _DividedBar extends StatelessWidget {
//   final EdgeInsetsGeometry? margin;
//   final Axis direction;
//   final double? size;
//   final Color? color;
//   const _DividedBar({
//     this.margin,
//     this.direction = Axis.horizontal,
//     this.size,
//     this.color,
//   });

//   @override
//   Widget build(BuildContext context) {
//     double p = Theme.of(context).buttonTheme.height;

//     return Container(
//       margin: margin,
//       width: direction == Axis.vertical ? p / 16 : size,
//       height: direction == Axis.horizontal ? p / 16 : size,
//       decoration: BoxDecoration(
//         color: color ?? Theme.of(context).colorScheme.onPrimaryContainer.withOpacity(1),
//         borderRadius: BorderRadius.circular(p / 2),
//       ),
//     );
//   }
// }

// DefaultTextStyle(
//                   textAlign: defaultTextAlign,
//                   style: defaultTextStyle ?? theme.textTheme.titleSmall?.copyWith(color: theme.colorScheme.onBackground) ?? const TextStyle(),
//                   child: Column(
//                     mainAxisSize: MainAxisSize.min,
//                     crossAxisAlignment: crossAxisAlignment,
//                     children: [
//                       titleChild(),
//                       childChild(),
//                       footerChild(),
//                     ],
//                   ),
//                 ),
