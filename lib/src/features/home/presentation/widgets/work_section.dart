import 'package:pujit_portfolio/src/imports/imports.dart';
import 'glass_card.dart';

class WorkSection extends StatelessWidget {
  final bool isMobile;

  const WorkSection({
    super.key,
    required this.isMobile,
  });

  @override
  Widget build(BuildContext context) {
    final padding = isMobile ? 24.0 : 48.0;

    final projects = [
      {
        'title': 'portfolio.work.projects.p1_title'.tr(),
        'desc': 'portfolio.work.projects.p1_desc'.tr(),
        'tag': 'portfolio.work.tags.fintech'.tr(),
        'tech': ['Android', 'Payment Gateways', 'Kotlin', 'MVVM'],
        'img': BrandLinks.project1Image,
      },
      {
        'title': 'portfolio.work.projects.p2_title'.tr(),
        'desc': 'portfolio.work.projects.p2_desc'.tr(),
        'tag': 'portfolio.work.tags.ai_health'.tr(),
        'tech': ['Flutter', 'Dart'],
        'img': BrandLinks.project2Image,
      },
      {
        'title': 'portfolio.work.projects.p3_title'.tr(),
        'desc': 'portfolio.work.projects.p3_desc'.tr(),
        'tag': 'portfolio.work.tags.proptech'.tr(),
        'tech': ['Android', 'JAVA', 'MVC'],
        'img': BrandLinks.project3Image,
      },
      {
        'title': 'portfolio.work.projects.p4_title'.tr(),
        'desc': 'portfolio.work.projects.p4_desc'.tr(),
        'tag': 'portfolio.work.tags.payments'.tr(),
        'tech': ['Android', 'Java', 'MVC'],
        'img': BrandLinks.project4Image,
      },
      {
        'title': 'portfolio.work.projects.p5_title'.tr(),
        'desc': 'portfolio.work.projects.p5_desc'.tr(),
        'tag': 'portfolio.work.tags.enterprise'.tr(),
        'tech': ['Android', 'Kotlin', 'MVVM'],
        'img': BrandLinks.project5Image,
      },
      {
        'title': 'portfolio.work.projects.p6_title'.tr(),
        'desc': 'portfolio.work.projects.p6_desc'.tr(),
        'tag': 'portfolio.work.tags.retail'.tr(),
        'tech': ['Android', 'Payment Gateways', 'Kotlin', 'MVVM'],
        'img': BrandLinks.project6Image,
      },
    ];

    return Container(
      padding: EdgeInsets.symmetric(horizontal: padding, vertical: 72),
      constraints: const BoxConstraints(maxWidth: 1200),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'portfolio.work.subtitle'.tr().toUpperCase(),
            style: context.textTheme.labelMedium?.copyWith(
              color: context.colors.tertiary,
              fontWeight: FontWeight.bold,
              letterSpacing: 2,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            'portfolio.work.title'.tr(),
            style: context.textTheme.headlineMedium?.copyWith(
              fontWeight: FontWeight.bold,
              color: context.colors.onSurface,
            ),
          ),
          const SizedBox(height: 48),
          // Project grid
          GridView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: projects.length,
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: isMobile ? 1 : 3,
              crossAxisSpacing: 24,
              mainAxisSpacing: 24,
              childAspectRatio: isMobile ? 1.0 : 0.85,
            ),
            itemBuilder: (context, index) {
              final project = projects[index];
              final techStack = project['tech'] as List<String>;
              return GlassCard(
                padding: EdgeInsets.zero,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Image banner with Tag overlay
                    Expanded(
                      flex: 5,
                      child: Stack(
                        fit: StackFit.expand,
                        children: [
                          CachedNetworkImage(
                            imageUrl: project['img'] as String,
                            fit: BoxFit.cover,
                            placeholder: (context, url) => ColoredBox(
                              color: context.colors.surfaceContainerHighest,
                              child: const Center(
                                child: CircularProgressIndicator(strokeWidth: 2),
                              ),
                            ),
                            errorWidget: (context, url, error) => ColoredBox(
                              color: context.colors.surfaceContainerHighest,
                              child: const Center(
                                child: Icon(Icons.image_not_supported_outlined, size: 40),
                              ),
                            ),
                          ),
                          // Transparent dark overlay
                          Container(
                            color: Colors.black.withValues(alpha: 0.3),
                          ),
                          // Category Tag overlay
                          Positioned(
                            top: 16,
                            left: 16,
                            child: Container(
                              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                              decoration: BoxDecoration(
                                color: context.colors.primary.withValues(alpha: 0.2),
                                borderRadius: AppBorders.full,
                                border: Border.all(
                                  color: context.colors.primary.withValues(alpha: 0.3),
                                ),
                              ),
                              child: Text(
                                project['tag'] as String,
                                style: context.textTheme.labelSmall?.copyWith(
                                  color: context.colors.primary,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    // Project info details
                    Expanded(
                      flex: 5,
                      child: Padding(
                        padding: const EdgeInsets.all(20),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              project['title'] as String,
                              style: context.textTheme.titleMedium?.copyWith(
                                fontWeight: FontWeight.bold,
                                color: context.colors.onSurface,
                              ),
                            ),
                            const SizedBox(height: 8),
                            Expanded(
                              child: Text(
                                project['desc'] as String,
                                maxLines: 2,
                                overflow: TextOverflow.ellipsis,
                                style: context.textTheme.bodySmall?.copyWith(
                                  color: context.colors.onSurfaceVariant,
                                  height: 1.4,
                                ),
                              ),
                            ),
                            const SizedBox(height: 12),
                            // Tag badges
                            Wrap(
                              spacing: 6,
                              runSpacing: 6,
                              children: techStack.map((tech) {
                                return Container(
                                  padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                                  decoration: BoxDecoration(
                                    color: Colors.white.withValues(alpha: 0.05),
                                    borderRadius: AppBorders.xs,
                                  ),
                                  child: Text(
                                    tech,
                                    style: AppTextStyles.chipText.copyWith(
                                      fontSize: 10,
                                      color: const Color(0xFFC3C6D7),
                                    ),
                                  ),
                                );
                              }).toList(),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}
