import 'package:pujit_portfolio/src/imports/imports.dart';

class TechStackSection extends StatelessWidget {
  final bool isMobile;

  const TechStackSection({
    super.key,
    required this.isMobile,
  });

  @override
  Widget build(BuildContext context) {
    if (isMobile) {
      return _buildMobileLayout(context);
    }

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 48, vertical: 72),
      alignment: Alignment.center,
      child: Container(
        constraints: const BoxConstraints(maxWidth: 1200),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // Section title with trailing horizontal line
            Row(
              children: [
                Text(
                  'cyberpunk.nav_arsenal'.tr(),
                  style: AppTextStyles.sectionTitle.copyWith(
                    color: context.colors.primaryContainer, // Neon Purple
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(width: 24),
                Expanded(
                  child: Divider(
                    color: context.colors.outlineVariant.withValues(alpha: 0.3),
                    thickness: 1,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 48),

            // 3 HUD Columns Row
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Mobile Core
                Expanded(
                  child: _buildArsenalCard(
                    context,
                    'portfolio.skills.category_mobile'.tr().toUpperCase(),
                    Icons.smartphone_rounded,
                    context.colors.primaryContainer,
                    ['ANDROID (NATIVE)', 'FLUTTER', 'KOTLIN', 'JAVA', 'DART', 'REACT NATIVE'],
                  ),
                ),
                const SizedBox(width: 24),

                // Strategic Arch
                Expanded(
                  child: _buildArsenalCard(
                    context,
                    'portfolio.skills.category_architecture'.tr().toUpperCase(),
                    Icons.architecture_rounded,
                    context.colors.secondary,
                    ['MVVM', 'CLEAN ARCHITECTURE', 'DESIGN PATTERNS', 'PROVIDER / BLOC', 'UNIT TESTING'],
                  ),
                ),
                const SizedBox(width: 24),

                // Data Protocols
                Expanded(
                  child: _buildArsenalCard(
                    context,
                    'portfolio.skills.category_backend_data'.tr().toUpperCase(),
                    Icons.storage_rounded,
                    context.colors.tertiary,
                    ['FIREBASE', 'REST APIS', 'SQLITE / ROOM', 'SUPABASE', 'GRAPHQL'],
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildArsenalCard(
    BuildContext context,
    String title,
    IconData icon,
    Color color,
    List<String> skills,
  ) {
    return HudBorder(
      padding: const EdgeInsets.all(28),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(icon, color: color, size: 28),
              const SizedBox(width: 12),
              Text(
                title,
                style: AppTextStyles.cardTitle.copyWith(
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                  color: context.colors.onSurface,
                ),
              ),
            ],
          ),
          const SizedBox(height: 24),
          Wrap(
            spacing: 8,
            runSpacing: 8,
            children: skills.map((skill) {
              return Container(
                padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
                decoration: BoxDecoration(
                  color: color.withValues(alpha: 0.05),
                  border: Border.all(
                    color: color.withValues(alpha: 0.2),
                  ),
                  borderRadius: AppBorders.xs,
                ),
                child: Text(
                  skill,
                  style: AppTextStyles.bodySmall.copyWith(
                    color: color,
                    fontWeight: FontWeight.bold,
                    fontSize: 10,
                  ),
                ),
              );
            }).toList(),
          ),
        ],
      ),
    );
  }

  Widget _buildMobileLayout(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 48),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Section header with pulsing Cyber Green dot
          Row(
            children: [
              Container(
                width: 8,
                height: 8,
                decoration: const BoxDecoration(
                  shape: BoxShape.circle,
                  color: AppColors.cyberGreen,
                ),
              ).animate(onPlay: (controller) => controller.repeat(reverse: true))
               .fade(duration: const Duration(milliseconds: 600)),
              const SizedBox(width: 8),
              Text(
                'cyberpunk.core_arsenal_stats'.tr().toUpperCase(),
                style: AppTextStyles.bodySmall.copyWith(
                  color: AppColors.cyberGreen,
                  fontWeight: FontWeight.bold,
                  letterSpacing: 2,
                ),
              ),
            ],
          ),
          const SizedBox(height: 24),

          // 2x2 Grid of Glass Panels
          GridView.count(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            crossAxisCount: 2,
            crossAxisSpacing: 12,
            mainAxisSpacing: 12,
            childAspectRatio: 1.4,
            children: [
              _buildMobileStatPanel(
                context,
                'portfolio.skills.category_mobile'.tr().toUpperCase(),
                'Android, Flutter, Kotlin, Java, Dart, React Native',
                AppColors.neonPurple,
              ),
              _buildMobileStatPanel(
                context,
                'portfolio.skills.category_architecture'.tr().toUpperCase(),
                'MVVM, Clean Arch, Design Patterns, BLoC, Unit Testing',
                AppColors.cyberGreen,
              ),
              _buildMobileStatPanel(
                context,
                'portfolio.skills.category_backend_data'.tr().toUpperCase(),
                'Firebase, REST, SQLite, Supabase, GraphQL',
                AppColors.warningOrange,
              ),
              _buildMobileStatPanel(
                context,
                'cyberpunk.nav_profile'.tr().toUpperCase(), // STATS label
                '${'portfolio.stats.years_exp'.tr()} Yrs Exp // ${'portfolio.stats.projects'.tr()} Projects // ${'portfolio.stats.industries'.tr()} Sectors',
                context.colors.primary, // Primary Accent
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildMobileStatPanel(BuildContext context, String title, String subtitle, Color accentColor) {
    return DecoratedBox(
      decoration: BoxDecoration(
        color: AppColors.surfaceGray.withValues(alpha: 0.7),
        border: Border.all(
          color: context.colors.outlineVariant.withValues(alpha: 0.15),
          width: 1,
        ),
        borderRadius: AppBorders.xs,
      ),
      child: ClipRRect(
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(3),
          bottomLeft: Radius.circular(3),
        ),
        child: Stack(
          children: [
            Positioned(
              left: 0,
              top: 0,
              bottom: 0,
              child: Container(
                width: 2,
                color: accentColor,
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(14, 12, 12, 12),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    title,
                    style: AppTextStyles.bodySmall.copyWith(
                      color: accentColor,
                      fontWeight: FontWeight.bold,
                      fontSize: 8,
                      letterSpacing: 0.5,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    subtitle,
                    style: AppTextStyles.bodySmall.copyWith(
                      color: context.colors.onSurfaceVariant,
                      fontSize: 9,
                      height: 1.3,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
