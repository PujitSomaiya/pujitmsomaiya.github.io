import 'package:pujit_portfolio/src/imports/imports.dart';
import 'glass_card.dart';

class AboutSection extends StatelessWidget {
  final bool isMobile;

  const AboutSection({
    super.key,
    required this.isMobile,
  });

  @override
  Widget build(BuildContext context) {
    final padding = isMobile ? 24.0 : 48.0;

    final checklistItems = [
      'portfolio.about.checklist.fintech'.tr(),
      'portfolio.about.checklist.ai'.tr(),
      'portfolio.about.checklist.payments'.tr(),
      'portfolio.about.checklist.performance'.tr(),
    ];

    final leftColumn = Column(
      crossAxisAlignment: isMobile ? CrossAxisAlignment.center : CrossAxisAlignment.start,
      children: [
        Text(
          '01 // ${'portfolio.about.subtitle'.tr().toUpperCase()}',
          style: context.textTheme.labelMedium?.copyWith(
            color: context.colors.tertiary,
            fontWeight: FontWeight.bold,
            letterSpacing: 2,
          ),
        ),

        const SizedBox(height: 8),
        Text(
          'portfolio.about.title'.tr(),
          textAlign: isMobile ? TextAlign.center : TextAlign.start,
          style: context.textTheme.headlineMedium?.copyWith(
            fontWeight: FontWeight.bold,
            color: context.colors.onSurface,
          ),
        ),
        const SizedBox(height: 16),
        Text(
          'portfolio.about.p1'.tr(),
          textAlign: isMobile ? TextAlign.center : TextAlign.start,
          style: context.textTheme.bodyMedium?.copyWith(
            color: context.colors.onSurfaceVariant,
            height: 1.6,
          ),
        ),
        const SizedBox(height: 16),
        Text(
          'portfolio.about.p2'.tr(),
          textAlign: isMobile ? TextAlign.center : TextAlign.start,
          style: context.textTheme.bodyMedium?.copyWith(
            color: context.colors.onSurfaceVariant,
            height: 1.6,
          ),
        ),
        const SizedBox(height: 24),
        // Checklist Grid
        GridView.count(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          crossAxisCount: 2,
          childAspectRatio: 4.5,
          children: checklistItems.map((item) {
            return Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(
                  Icons.check_circle_rounded,
                  color: context.colors.primary,
                  size: 20,
                ),
                const SizedBox(width: 8),
                Expanded(
                  child: Text(
                    item,
                    style: context.textTheme.bodyMedium?.copyWith(
                      fontWeight: FontWeight.w600,
                      color: context.colors.onSurface,
                    ),
                  ),
                ),
              ],
            );
          }).toList(),
        ),
      ],
    );

    final rightColumn = Column(
      children: [
        GlassCard(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Icon(Icons.android, size: 40, color: context.colors.primary),
              const SizedBox(height: 16),
              Text(
                'portfolio.about.android_title'.tr(),
                style: context.textTheme.titleMedium?.copyWith(
                  fontWeight: FontWeight.bold,
                  color: context.colors.onSurface,
                ),
              ),
              const SizedBox(height: 8),
              Text(
                'portfolio.about.android_desc'.tr(),
                style: context.textTheme.bodySmall?.copyWith(
                  color: context.colors.onSurfaceVariant,
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 24),
        GlassCard(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Icon(Icons.flutter_dash_outlined, size: 40, color: context.colors.secondary),
              const SizedBox(height: 16),
              Text(
                'portfolio.about.flutter_title'.tr(),
                style: context.textTheme.titleMedium?.copyWith(
                  fontWeight: FontWeight.bold,
                  color: context.colors.onSurface,
                ),
              ),
              const SizedBox(height: 8),
              Text(
                'portfolio.about.flutter_desc'.tr(),
                style: context.textTheme.bodySmall?.copyWith(
                  color: context.colors.onSurfaceVariant,
                ),
              ),
            ],
          ),
        ),
      ],
    );

    return Container(
      padding: EdgeInsets.symmetric(horizontal: padding, vertical: 72),
      constraints: const BoxConstraints(maxWidth: 1200),
      child: isMobile
          ? Column(
              children: [
                leftColumn,
                const SizedBox(height: 48),
                rightColumn,
              ],
            )
          : Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(flex: 6, child: leftColumn),
                const SizedBox(width: 64),
                Expanded(flex: 5, child: rightColumn),
              ],
            ),
    );
  }
}
