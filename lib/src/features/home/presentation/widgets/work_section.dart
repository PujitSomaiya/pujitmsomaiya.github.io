import 'package:pujit_portfolio/src/imports/imports.dart';

class WorkSection extends StatelessWidget {
  final bool isMobile;

  const WorkSection({
    super.key,
    required this.isMobile,
  });

  @override
  Widget build(BuildContext context) {
    final projects = [
      {
        'title': 'portfolio.work.projects.p1_title'.tr().toUpperCase(),
        'desc': 'portfolio.work.projects.p1_desc'.tr(),
        'tag': 'portfolio.work.tags.fintech'.tr(),
        'icon': Icons.payments_rounded,
        'progress': 0.95,
        'accent': AppColors.cyberGreen, // Cyber Green
        'img': BrandLinks.project1Image,
      },
      {
        'title': 'portfolio.work.projects.p2_title'.tr().toUpperCase(),
        'desc': 'portfolio.work.projects.p2_desc'.tr(),
        'tag': 'portfolio.work.tags.ai_health'.tr(),
        'icon': Icons.smart_toy_rounded,
        'progress': 0.88,
        'accent': AppColors.neonPurple, // Neon Purple
        'img': BrandLinks.project2Image,
      },
      {
        'title': 'portfolio.work.projects.p3_title'.tr().toUpperCase(),
        'desc': 'portfolio.work.projects.p3_desc'.tr(),
        'tag': 'portfolio.work.tags.proptech'.tr(),
        'icon': Icons.vpn_key_rounded,
        'progress': 0.92,
        'accent': AppColors.warningOrange, // Warning Orange
        'img': BrandLinks.project3Image,
      },
      {
        'title': 'portfolio.work.projects.p4_title'.tr().toUpperCase(),
        'desc': 'portfolio.work.projects.p4_desc'.tr(),
        'tag': 'portfolio.work.tags.payments'.tr(),
        'icon': Icons.account_balance_wallet_rounded,
        'progress': 0.90,
        'accent': AppColors.lavender, // Lavender/Primary
        'img': BrandLinks.project1Image,
      },
      {
        'title': 'portfolio.work.projects.p5_title'.tr().toUpperCase(),
        'desc': 'portfolio.work.projects.p5_desc'.tr(),
        'tag': 'portfolio.work.tags.enterprise'.tr(),
        'icon': Icons.business_center_rounded,
        'progress': 0.85,
        'accent': AppColors.cyberGreen, // Cyber Green
        'img': BrandLinks.project2Image,
      },
      {
        'title': 'portfolio.work.projects.p6_title'.tr().toUpperCase(),
        'desc': 'portfolio.work.projects.p6_desc'.tr(),
        'tag': 'portfolio.work.tags.retail'.tr(),
        'icon': Icons.shopping_cart_rounded,
        'progress': 0.89,
        'accent': AppColors.neonPurple, // Neon Purple
        'img': BrandLinks.project3Image,
      },
    ];

    if (isMobile) {
      return _buildMobileLayout(context, projects);
    }

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 48, vertical: 72),
      alignment: Alignment.center,
      child: Container(
        constraints: const BoxConstraints(maxWidth: 1200),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // Header right aligned with a leading horizontal line
            Row(
              children: [
                Expanded(
                  child: Divider(
                    color: context.colors.outlineVariant.withValues(alpha: 0.3),
                    thickness: 1,
                  ),
                ),
                const SizedBox(width: 24),
                Text(
                  'cyberpunk.project_archives'.tr().toUpperCase(),
                  style: AppTextStyles.sectionTitle.copyWith(
                    color: context.colors.secondary, // Cyber Green
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 48),

            // Web Projects Grid
            GridView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: projects.length,
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 3,
                crossAxisSpacing: 24,
                mainAxisSpacing: 24,
                childAspectRatio: 0.78,
              ),
              itemBuilder: (context, index) {
                final project = projects[index];
                return _ProjectCard(
                  title: project['title'] as String,
                  desc: project['desc'] as String,
                  tag: project['tag'] as String,
                  imgUrl: project['img'] as String,
                  progress: project['progress'] as double,
                  accentColor: project['accent'] as Color,
                );
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildMobileLayout(BuildContext context, List<Map<String, dynamic>> projects) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 48),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Section header with pulsing Cyber Green dot on left, "6 ENTRIES FOUND" on right
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
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
                    'cyberpunk.project_archives'.tr().toUpperCase(),
                    style: AppTextStyles.bodySmall.copyWith(
                      color: AppColors.cyberGreen,
                      fontWeight: FontWeight.bold,
                      letterSpacing: 2,
                    ),
                  ),
                ],
              ),
              Text(
                'cyberpunk.entries_found'.tr(args: ['${projects.length}']),
                style: AppTextStyles.bodySmall.copyWith(
                  color: context.colors.onSurfaceVariant.withValues(alpha: 0.5),
                  fontSize: 9,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
          const SizedBox(height: 24),

          // Vertical stacked lists of 6 project tiles with colored left-borders
          ListView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: projects.length,
            itemBuilder: (context, index) {
              final project = projects[index];
              final accentColor = project['accent'] as Color;
              final icon = project['icon'] as IconData;

              return Padding(
                padding: const EdgeInsets.only(bottom: 12),
                child: DecoratedBox(
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
                          padding: const EdgeInsets.fromLTRB(18, 16, 16, 16),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      project['title'] as String,
                                      style: context.textTheme.titleMedium?.copyWith(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 12,
                                        color: context.colors.onSurface,
                                      ),
                                    ),
                                    const SizedBox(height: 4),
                                    Text(
                                      '${project['tag']} // ${project['desc']}',
                                      maxLines: 1,
                                      overflow: TextOverflow.ellipsis,
                                      style: AppTextStyles.bodySmall.copyWith(
                                        color: context.colors.onSurfaceVariant.withValues(alpha: 0.6),
                                        fontSize: 10,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              const SizedBox(width: 12),
                              Icon(
                                icon,
                                color: accentColor,
                                size: 20,
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}

class _ProjectCard extends StatefulWidget {
  final String title;
  final String desc;
  final String tag;
  final String imgUrl;
  final double progress;
  final Color accentColor;

  const _ProjectCard({
    required this.title,
    required this.desc,
    required this.tag,
    required this.imgUrl,
    required this.progress,
    required this.accentColor,
  });

  @override
  State<_ProjectCard> createState() => _ProjectCardState();
}

class _ProjectCardState extends State<_ProjectCard> {
  bool _isHovered = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) => setState(() => _isHovered = true),
      onExit: (_) => setState(() => _isHovered = false),
      child: AnimatedScale(
        scale: _isHovered ? 1.02 : 1.0,
        duration: const Duration(milliseconds: 200),
        curve: Curves.easeOut,
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 200),
          decoration: BoxDecoration(
            color: context.colors.surfaceContainer.withValues(alpha: 0.4),
            border: Border.all(
              color: _isHovered
                  ? widget.accentColor
                  : context.colors.outlineVariant.withValues(alpha: 0.15),
              width: 1.5,
            ),
            borderRadius: AppBorders.xs,
          ),
          child: ClipRRect(
            borderRadius: AppBorders.xs,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                // Banner Image
                Expanded(
                  flex: 5,
                  child: Stack(
                    fit: StackFit.expand,
                    children: [
                      CachedNetworkImage(
                        imageUrl: widget.imgUrl,
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
                      // Dark Overlay
                      Container(color: Colors.black.withValues(alpha: 0.35)),
                      // Tag
                      Positioned(
                        top: 16,
                        left: 16,
                        child: Container(
                          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                          decoration: BoxDecoration(
                            color: widget.accentColor.withValues(alpha: 0.15),
                            borderRadius: AppBorders.xs,
                            border: Border.all(
                              color: widget.accentColor.withValues(alpha: 0.3),
                            ),
                          ),
                          child: Text(
                            widget.tag.toUpperCase(),
                            style: AppTextStyles.bodySmall.copyWith(
                              color: widget.accentColor,
                              fontWeight: FontWeight.bold,
                              fontSize: 9,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),

                // Info details
                Expanded(
                  flex: 4,
                  child: Padding(
                    padding: const EdgeInsets.all(20),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          widget.title,
                          style: AppTextStyles.cardTitle.copyWith(
                            fontWeight: FontWeight.bold,
                            color: context.colors.onSurface,
                            fontSize: 15,
                          ),
                        ),
                        const SizedBox(height: 8),
                        Expanded(
                          child: Text(
                            widget.desc,
                            maxLines: 3,
                            overflow: TextOverflow.ellipsis,
                            style: AppTextStyles.bodySmall.copyWith(
                              color: context.colors.onSurfaceVariant.withValues(alpha: 0.6),
                              height: 1.4,
                            ),
                          ),
                        ),
                        const SizedBox(height: 16),

                        // Performance progress meter
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              'cyberpunk.sys_perf_index'.tr(),
                              style: AppTextStyles.bodySmall.copyWith(
                                color: context.colors.onSurfaceVariant.withValues(alpha: 0.4),
                                fontSize: 9,
                              ),
                            ),
                            Text(
                              '${(widget.progress * 100).toInt()}%',
                              style: AppTextStyles.bodySmall.copyWith(
                                color: context.colors.secondary, // Cyber Green
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 6),
                        ClipRRect(
                          borderRadius: AppBorders.xs,
                          child: LinearProgressIndicator(
                            value: widget.progress,
                            minHeight: 4,
                            backgroundColor: Colors.white.withValues(alpha: 0.05),
                            valueColor: AlwaysStoppedAnimation<Color>(context.colors.secondary),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
