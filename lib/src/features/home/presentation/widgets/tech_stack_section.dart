import 'package:pujit_portfolio/src/imports/imports.dart';

class TechStackSection extends StatelessWidget {
  final bool isMobile;

  const TechStackSection({
    super.key,
    required this.isMobile,
  });

  @override
  Widget build(BuildContext context) {
    final padding = isMobile ? 24.0 : 48.0;

    final skillsData = [
      (
        'portfolio.skills.category_mobile'.tr(),
        context.colors.primary,
        ['Android (Native)', 'Jetpack Compose', 'Flutter', 'Kotlin', 'Java', 'Dart']
      ),
      (
        'portfolio.skills.category_architecture'.tr(),
        context.colors.secondary,
        ['MVVM', 'MVI', 'Clean Architecture', 'Provider / Bloc']
      ),
      (
        'portfolio.skills.category_backend_data'.tr(),
        context.colors.tertiary,
        ['Firebase', 'REST APIs', 'SQLite / Room', 'Supabase']
      ),
    ];

    final leftColumn = Column(
      crossAxisAlignment: isMobile ? CrossAxisAlignment.center : CrossAxisAlignment.start,
      children: [
        Text(
          'portfolio.skills.subtitle'.tr().toUpperCase(),
          style: context.textTheme.labelMedium?.copyWith(
            color: context.colors.tertiary,
            fontWeight: FontWeight.bold,
            letterSpacing: 2,
          ),
        ),
        const SizedBox(height: 8),
        Text(
          'portfolio.skills.title'.tr(),
          textAlign: isMobile ? TextAlign.center : TextAlign.start,
          style: context.textTheme.headlineMedium?.copyWith(
            fontWeight: FontWeight.bold,
            color: context.colors.onSurface,
          ),
        ),
        const SizedBox(height: 16),
        Text(
          'portfolio.skills.desc'.tr(),
          textAlign: isMobile ? TextAlign.center : TextAlign.start,
          style: context.textTheme.bodyMedium?.copyWith(
            color: context.colors.onSurfaceVariant,
            height: 1.6,
          ),
        ),
      ],
    );

    final rightColumn = Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: skillsData.map((category) {
        return Padding(
          padding: const EdgeInsets.only(bottom: 24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                category.$1.toUpperCase(),
                style: context.textTheme.labelSmall?.copyWith(
                  color: category.$2,
                  fontWeight: FontWeight.bold,
                  letterSpacing: 1.5,
                ),
              ),
              const SizedBox(height: 12),
              Wrap(
                spacing: 8,
                runSpacing: 8,
                children: category.$3.map((skill) {
                  return Container(
                    padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
                    decoration: BoxDecoration(
                      color: Colors.white.withValues(alpha: 0.03),
                      borderRadius: AppBorders.sm,
                      border: Border.all(
                        color: Colors.white.withValues(alpha: 0.08),
                        width: 1,
                      ),
                    ),
                    child: Text(
                      skill,
                      style: context.textTheme.labelMedium?.copyWith(
                        color: context.colors.onSurface,
                      ),
                    ),
                  );
                }).toList(),
              ),
            ],
          ),
        );
      }).toList(),
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
                Expanded(flex: 5, child: leftColumn),
                const SizedBox(width: 64),
                Expanded(flex: 7, child: rightColumn),
              ],
            ),
    );
  }
}
