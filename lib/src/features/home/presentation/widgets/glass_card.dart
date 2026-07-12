import 'dart:ui';
import 'package:pujit_portfolio/src/imports/imports.dart';

class GlassCard extends StatefulWidget {
  final Widget child;
  final double? width;
  final double? height;
  final EdgeInsetsGeometry? padding;
  final VoidCallback? onTap;

  const GlassCard({
    super.key,
    required this.child,
    this.width,
    this.height,
    this.padding,
    this.onTap,
  });

  @override
  State<GlassCard> createState() => _GlassCardState();
}

class _GlassCardState extends State<GlassCard> {
  bool isHovered = false;

  @override
  Widget build(BuildContext context) {
    final cardContent = ClipRRect(
      borderRadius: AppBorders.card,
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 12, sigmaY: 12),
        child: Padding(
          padding: widget.padding ?? const EdgeInsets.all(24),
          child: widget.child,
        ),
      ),
    );

    return MouseRegion(
      onEnter: (_) => setState(() => isHovered = true),
      onExit: (_) => setState(() => isHovered = false),
      child: AnimatedScale(
        scale: isHovered ? 1.02 : 1.0,
        duration: const Duration(milliseconds: 200),
        curve: Curves.easeOut,
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 200),
          width: widget.width,
          height: widget.height,
          decoration: BoxDecoration(
            color: isHovered
                ? Colors.white.withValues(alpha: 0.05)
                : Colors.white.withValues(alpha: 0.03),
            borderRadius: AppBorders.card,
            border: Border.all(
              color: isHovered
                  ? context.colors.primary.withValues(alpha: 0.3)
                  : context.colors.outline.withValues(alpha: 0.15),
              width: 1.5,
            ),
            boxShadow: isHovered
                ? [
                    BoxShadow(
                      color: context.colors.primary.withValues(alpha: 0.2),
                      blurRadius: 30,
                      spreadRadius: 0,
                    )
                  ]
                : [],
          ),
          child: widget.onTap != null
              ? InkWell(
                  onTap: widget.onTap,
                  borderRadius: AppBorders.card,
                  child: cardContent,
                )
              : cardContent,
        ),
      ),
    );
  }
}
