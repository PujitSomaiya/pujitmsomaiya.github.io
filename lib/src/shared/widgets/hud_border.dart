import 'package:pujit_portfolio/src/imports/imports.dart';


class HudBorder extends StatelessWidget {
  final Widget child;
  final EdgeInsetsGeometry? padding;

  const HudBorder({
    super.key,
    required this.child,
    this.padding,
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          padding: padding,
          decoration: BoxDecoration(
            color: context.colors.surfaceContainer.withValues(alpha: 0.4),
            border: Border.all(
              color: context.colors.outlineVariant.withValues(alpha: 0.3),
              width: 1,
            ),
            borderRadius: AppBorders.xs,
          ),
          child: child,
        ),
        // Top-left corner bracket (Neon Purple)
        Positioned(
          top: 0,
          left: 0,
          child: Container(
            width: 10,
            height: 10,
            decoration: BoxDecoration(
              border: Border(
                top: BorderSide(color: context.colors.primaryContainer, width: 2),
                left: BorderSide(color: context.colors.primaryContainer, width: 2),
              ),
            ),
          ),
        ),
        // Bottom-right corner bracket (Cyber Green)
        Positioned(
          bottom: 0,
          right: 0,
          child: Container(
            width: 10,
            height: 10,
            decoration: BoxDecoration(
              border: Border(
                bottom: BorderSide(color: context.colors.secondary, width: 2),
                right: BorderSide(color: context.colors.secondary, width: 2),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
