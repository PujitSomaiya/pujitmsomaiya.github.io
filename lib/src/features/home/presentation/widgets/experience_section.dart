import 'package:pujit_portfolio/src/imports/imports.dart';

class ExperienceSection extends StatelessWidget {
  final bool isMobile;

  const ExperienceSection({
    super.key,
    required this.isMobile,
  });

  @override
  Widget build(BuildContext context) {
    final padding = isMobile ? 24.0 : 48.0;

    final experiences = [
      {
        'title': 'portfolio.experience.role1_title'.tr(),
        'company': 'portfolio.experience.role1_company'.tr(),
        'period': 'portfolio.experience.role1_period'.tr(),
        'color': context.colors.primary,
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
        'color': context.colors.secondary,
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
        'color': context.colors.outline,
        'desc': 'portfolio.experience.role3_desc'.tr()
      },
    ];

    return Container(
      padding: EdgeInsets.symmetric(horizontal: padding, vertical: 72),
      width: double.infinity,
      color: const Color(0xFF151B2A), // Low surface container color
      child: Center(
        child: Container(
          constraints: const BoxConstraints(maxWidth: 900),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                'portfolio.experience.subtitle'.tr().toUpperCase(),
                style: context.textTheme.labelMedium?.copyWith(
                  color: context.colors.tertiary,
                  fontWeight: FontWeight.bold,
                  letterSpacing: 2,
                ),
              ),
              const SizedBox(height: 8),
              Text(
                'portfolio.experience.title'.tr(),
                style: context.textTheme.headlineMedium?.copyWith(
                  fontWeight: FontWeight.bold,
                  color: context.colors.onSurface,
                ),
              ),
              const SizedBox(height: 64),
              // Timeline tree
              ListView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: experiences.length,
                itemBuilder: (context, index) {
                  final exp = experiences[index];
                  final color = exp['color'] as Color;
                  return Stack(
                    children: [
                      // Timeline line
                      if (index < experiences.length - 1)
                        Positioned(
                          left: 6,
                          top: 14,
                          bottom: 0,
                          child: Container(
                            width: 2,
                            color: Colors.white.withValues(alpha: 0.1),
                          ),
                        ),
                      // Content
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          // Left bullet circle
                          Container(
                            width: 14,
                            height: 14,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: color,
                              boxShadow: [
                                BoxShadow(
                                  color: color.withValues(alpha: 0.4),
                                  blurRadius: 8,
                                  spreadRadius: 2,
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(width: 24),
                          // Right details card
                          Expanded(
                            child: Padding(
                              padding: const EdgeInsets.only(bottom: 40),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  // Title and Company
                                  Text(
                                    exp['title'] as String,
                                    style: context.textTheme.titleLarge?.copyWith(
                                      fontWeight: FontWeight.bold,
                                      color: color,
                                    ),
                                  ),
                                  const SizedBox(height: 4),
                                  Row(
                                    children: [
                                      Text(
                                        exp['company'] as String,
                                        style: context.textTheme.bodyMedium?.copyWith(
                                          fontWeight: FontWeight.bold,
                                          color: context.colors.onSurface,
                                        ),
                                      ),
                                      const SizedBox(width: 8),
                                      Text(
                                        '•  ${exp['period']}',
                                        style: context.textTheme.bodySmall?.copyWith(
                                          color: context.colors.tertiary,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ],
                                  ),
                                  const SizedBox(height: 16),
                                  // Body list description
                                  if (exp.containsKey('bullets'))
                                    Column(
                                      children: (exp['bullets'] as List<String>)
                                          .map((bullet) => Padding(
                                                padding: const EdgeInsets.only(bottom: 8),
                                                child: Row(
                                                  crossAxisAlignment: CrossAxisAlignment.start,
                                                  children: [
                                                    Padding(
                                                      padding: const EdgeInsets.only(top: 6),
                                                      child: Icon(
                                                        Icons.circle,
                                                        size: 6,
                                                        color: context.colors.onSurfaceVariant,
                                                      ),
                                                    ),
                                                    const SizedBox(width: 12),
                                                    Expanded(
                                                      child: Text(
                                                        bullet,
                                                        style: context.textTheme.bodyMedium?.copyWith(
                                                          color: context.colors.onSurfaceVariant,
                                                          height: 1.5,
                                                        ),
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ))
                                          .toList(),
                                    )
                                  else if (exp.containsKey('desc'))
                                    Text(
                                      exp['desc'] as String,
                                      style: context.textTheme.bodyMedium?.copyWith(
                                        color: context.colors.onSurfaceVariant,
                                        height: 1.5,
                                      ),
                                    ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
