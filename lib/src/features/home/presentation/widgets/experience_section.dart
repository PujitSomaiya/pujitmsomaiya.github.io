import 'package:pujit_portfolio/src/imports/imports.dart';

class ExperienceSection extends StatelessWidget {
  final bool isMobile;

  const ExperienceSection({
    super.key,
    required this.isMobile,
  });

  @override
  Widget build(BuildContext context) {
    final experiences = [
      {
        'title': 'portfolio.experience.role1_title'.tr(),
        'company': 'portfolio.experience.role1_company'.tr(),
        'period': 'portfolio.experience.role1_period'.tr(),
        'period_slug': '2021.01 — PRESENT',
        'color': AppColors.neonPurple, // Neon Purple
        'role_tag': 'Lead Mobile Architect',
        'bullets': [
          'portfolio.experience.role1_b1'.tr(),
          'portfolio.experience.role1_b2'.tr(),
          'portfolio.experience.role1_b3'.tr(),
        ]
      },
      {
        'title': 'portfolio.experience.role2_title'.tr(),
        'company': 'portfolio.experience.role2_company'.tr(),
        'period': 'portfolio.experience.role2_period'.tr(),
        'period_slug': '2018.06 — 2020.12',
        'color': AppColors.cyberGreen, // Cyber Green
        'role_tag': 'Mobile Specialist',
        'bullets': [
          'portfolio.experience.role2_b1'.tr(),
          'portfolio.experience.role2_b2'.tr(),
          'portfolio.experience.role2_b3'.tr(),
        ]
      },
      {
        'title': 'portfolio.experience.role3_title'.tr(),
        'company': 'portfolio.experience.role3_company'.tr(),
        'period': 'portfolio.experience.role3_period'.tr(),
        'period_slug': '2018.01 — 2018.05',
        'color': AppColors.warningOrange, // Warning Orange
        'role_tag': 'Mobile Intern',
        'desc': 'portfolio.experience.role3_desc'.tr()
      },
    ];

    if (isMobile) {
      return _buildMobileLayout(context, experiences);
    }

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 48, vertical: 72),
      width: double.infinity,
      color: Colors.transparent,
      alignment: Alignment.center,
      child: Container(
        constraints: const BoxConstraints(maxWidth: 1000),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // Section Header
            Row(
              children: [
                Text(
                  '${'cyberpunk.career_path'.tr()} // ${'portfolio.experience.subtitle'.tr().toUpperCase()}',
                  style: AppTextStyles.sectionTitle.copyWith(
                    color: AppColors.neonPurple,
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
            const SizedBox(height: 64),

            // Timeline container stack
            Stack(
              children: [
                // Center timeline line (gradient purple to green to transparent)
                Positioned(
                  left: 0,
                  right: 0,
                  top: 0,
                  bottom: 0,
                  child: Center(
                    child: Container(
                      width: 2,
                      decoration: const BoxDecoration(
                        gradient: LinearGradient(
                          begin: Alignment.topCenter,
                          end: Alignment.bottomCenter,
                          colors: [
                            AppColors.neonPurple,
                            AppColors.cyberGreen,
                            Colors.transparent,
                          ],
                        ),
                      ),
                    ),
                  ),
                ),

                // Alternating items list
                Column(
                  children: List.generate(experiences.length, (index) {
                    final exp = experiences[index];
                    final color = exp['color'] as Color;
                    final isEven = index.isEven;

                    final infoBlock = Column(
                      crossAxisAlignment: isEven ? CrossAxisAlignment.end : CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
                          decoration: BoxDecoration(
                            color: color.withValues(alpha: 0.1),
                            borderRadius: AppBorders.xs,
                          ),
                          child: Text(
                            exp['period'] as String,
                            style: AppTextStyles.bodySmall.copyWith(
                              color: color,
                              fontWeight: FontWeight.bold,
                              fontSize: 10,
                            ),
                          ),
                        ),
                        const SizedBox(height: 8),
                        Text(
                          exp['title'] as String,
                          style: context.textTheme.titleMedium?.copyWith(
                            fontWeight: FontWeight.bold,
                            color: context.colors.onSurface,
                          ),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          '@${(exp['company'] as String).replaceAll('@', '')}',
                          style: AppTextStyles.bodySmall.copyWith(
                            color: isEven ? AppColors.cyberGreen : AppColors.neonPurple,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    );

                    final cardBlock = HudBorder(
                      padding: const EdgeInsets.all(24),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          if (exp.containsKey('bullets'))
                            ...((exp['bullets'] as List<String>).map((bullet) => Padding(
                                  padding: const EdgeInsets.only(bottom: 8),
                                  child: Row(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      const Padding(
                                        padding: EdgeInsets.only(top: 4),
                                        child: Icon(
                                          Icons.terminal_rounded,
                                          size: 12,
                                          color: Colors.white24,
                                        ),
                                      ),
                                      const SizedBox(width: 12),
                                      Expanded(
                                        child: Text(
                                          bullet,
                                          style: AppTextStyles.bodySmall.copyWith(
                                            color: context.colors.onSurfaceVariant,
                                            height: 1.4,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                )))
                          else if (exp.containsKey('desc'))
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const Padding(
                                  padding: EdgeInsets.only(top: 4),
                                  child: Icon(
                                    Icons.terminal_rounded,
                                    size: 12,
                                    color: Colors.white24,
                                  ),
                                ),
                                const SizedBox(width: 12),
                                Expanded(
                                  child: Text(
                                    exp['desc'] as String,
                                    style: AppTextStyles.bodySmall.copyWith(
                                      color: context.colors.onSurfaceVariant,
                                      height: 1.4,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                        ],
                      ),
                    );

                    return Padding(
                      padding: const EdgeInsets.symmetric(vertical: 24),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          // Left side
                          Expanded(
                            child: isEven ? infoBlock : cardBlock,
                          ),
                          // Center node
                          Container(
                            width: 32,
                            alignment: Alignment.center,
                            child: Container(
                              width: 16,
                              height: 16,
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                color: AppColors.voidBlack,
                                border: Border.all(
                                  color: color,
                                  width: 4,
                                ),
                                boxShadow: [
                                  BoxShadow(
                                    color: color.withValues(alpha: 0.4),
                                    blurRadius: 8,
                                  )
                                ],
                              ),
                            ),
                          ),
                          // Right side
                          Expanded(
                            child: isEven ? cardBlock : infoBlock,
                          ),
                        ],
                      ),
                    );
                  }),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildMobileLayout(BuildContext context, List<Map<String, dynamic>> experiences) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 48),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // 1. CAREER_PATH Title Header
          Row(
            children: [
              Container(
                width: 8,
                height: 8,
                decoration: const BoxDecoration(
                  shape: BoxShape.circle,
                  color: AppColors.lavender, // Primary/Lavender
                ),
              ).animate(onPlay: (controller) => controller.repeat(reverse: true))
               .fade(duration: const Duration(milliseconds: 600)),
               const SizedBox(width: 8),
              Text(
                'cyberpunk.career_path'.tr().toUpperCase(),
                style: AppTextStyles.bodySmall.copyWith(
                  color: AppColors.lavender,
                  fontWeight: FontWeight.bold,
                  letterSpacing: 2,
                ),
              ),
            ],
          ),
          const SizedBox(height: 24),

          // Detailed logs timeline showing all experiences
          Padding(
            padding: const EdgeInsets.only(left: 8),
            child: Stack(
              children: [
                Positioned(
                  left: 5,
                  top: 8,
                  bottom: 12,
                  child: Container(
                    width: 1,
                    color: context.colors.outlineVariant.withValues(alpha: 0.3),
                  ),
                ),
                Column(
                  children: List.generate(experiences.length, (index) {
                    final exp = experiences[index];
                    final color = exp['color'] as Color;
                    final description = exp.containsKey('bullets')
                        ? (exp['bullets'] as List<String>).join(' ')
                        : exp['desc'] as String;

                    return Padding(
                      padding: const EdgeInsets.only(bottom: 24),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            margin: const EdgeInsets.only(top: 4),
                            width: 11,
                            height: 11,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: color,
                              boxShadow: [
                                BoxShadow(
                                  color: color.withValues(alpha: 0.4),
                                  blurRadius: 6,
                                )
                              ],
                            ),
                          ),
                          const SizedBox(width: 22),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  exp['period_slug'] as String,
                                  style: AppTextStyles.bodySmall.copyWith(
                                    color: context.colors.onSurfaceVariant.withValues(alpha: 0.6),
                                    fontSize: 9,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                const SizedBox(height: 4),
                                Text(
                                  '${(exp['title'] as String).toUpperCase()} @ ${(exp['company'] as String).toUpperCase()}',
                                  style: context.textTheme.titleMedium?.copyWith(
                                    color: context.colors.onSurface,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 13,
                                  ),
                                ),
                                const SizedBox(height: 8),
                                Text(
                                  description,
                                  style: AppTextStyles.bodySmall.copyWith(
                                    color: context.colors.onSurfaceVariant,
                                    fontSize: 11,
                                    height: 1.4,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    );
                  }),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
