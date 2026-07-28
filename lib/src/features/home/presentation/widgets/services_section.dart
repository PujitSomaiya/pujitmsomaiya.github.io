import 'package:pujit_portfolio/src/imports/imports.dart';

class ServicesSection extends StatelessWidget {
  final bool isMobile;
  final double screenWidth;

  const ServicesSection({
    super.key,
    required this.isMobile,
    required this.screenWidth,
  });

  @override
  Widget build(BuildContext context) {
    final servicesList = [
      (Icons.android_rounded, 'portfolio.services.s1_title'.tr().toUpperCase(), 'portfolio.services.s1_desc'.tr(), AppColors.neonPurple), // Neon Purple
      (Icons.devices_rounded, 'portfolio.services.s2_title'.tr().toUpperCase(), 'portfolio.services.s2_desc'.tr(), AppColors.cyberGreen), // Cyber Green
      (Icons.bug_report_outlined, 'portfolio.services.s3_title'.tr().toUpperCase(), 'portfolio.services.s3_desc'.tr(), AppColors.warningOrange), // Warning Orange
      (Icons.palette_outlined, 'portfolio.services.s4_title'.tr().toUpperCase(), 'portfolio.services.s4_desc'.tr(), AppColors.primary), // Primary/Lavender
      (Icons.api_rounded, 'portfolio.services.s5_title'.tr().toUpperCase(), 'portfolio.services.s5_desc'.tr(), AppColors.neonPurple),
      (Icons.payments_outlined, 'portfolio.services.s6_title'.tr().toUpperCase(), 'portfolio.services.s6_desc'.tr(), AppColors.cyberGreen),
      (Icons.speed_rounded, 'portfolio.services.s7_title'.tr().toUpperCase(), 'portfolio.services.s7_desc'.tr(), AppColors.warningOrange),
      (Icons.cloud_upload_outlined, 'portfolio.services.s8_title'.tr().toUpperCase(), 'portfolio.services.s8_desc'.tr(), AppColors.primary),
    ];

    if (isMobile) {
      return _buildMobileLayout(context, servicesList);
    }

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 48, vertical: 72),
      width: double.infinity,
      color: Colors.transparent,
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
                  'cyberpunk.mission_solutions'.tr().toUpperCase(),
                  style: AppTextStyles.sectionTitle.copyWith(
                    color: context.colors.secondary, // Cyber Green
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 48),

            // 4-column Services Grid
            GridView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: servicesList.length,
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: screenWidth > 1100 ? 4 : 2,
                crossAxisSpacing: 24,
                mainAxisSpacing: 24,
                childAspectRatio: 1.5,
              ),
              itemBuilder: (context, index) {
                final service = servicesList[index];
                return _ServiceCard(
                  icon: service.$1,
                  title: service.$2,
                  desc: service.$3,
                  topBorderColor: service.$4,
                );
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildMobileLayout(BuildContext context, List<(IconData, String, String, Color)> services) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 48),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Section title with pulsing Neon Purple dot
          Row(
            children: [
              Container(
                width: 8,
                height: 8,
                decoration: const BoxDecoration(
                  shape: BoxShape.circle,
                  color: AppColors.neonPurple,
                ),
              ).animate(onPlay: (controller) => controller.repeat(reverse: true))
               .fade(duration: const Duration(milliseconds: 600)),
              const SizedBox(width: 8),
              Text(
                'cyberpunk.mission_solutions'.tr().toUpperCase(),
                style: AppTextStyles.bodySmall.copyWith(
                  color: AppColors.neonPurple,
                  fontWeight: FontWeight.bold,
                  letterSpacing: 2,
                ),
              ),
            ],
          ),
          const SizedBox(height: 24),

          // 2-column Services Grid
          GridView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: services.length,
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              crossAxisSpacing: 12,
              mainAxisSpacing: 12,
              childAspectRatio: 2.2,
            ),
            itemBuilder: (context, index) {
              final service = services[index];
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
                    topRight: Radius.circular(3),
                  ),
                  child: Stack(
                    children: [
                      Positioned(
                        top: 0,
                        left: 0,
                        right: 0,
                        child: Container(
                          height: 1.5,
                          color: service.$4.withValues(alpha: 0.4),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.fromLTRB(12, 13.5, 12, 12),
                        child: Center(
                          child: Text(
                            service.$2,
                            textAlign: TextAlign.center,
                            style: AppTextStyles.bodySmall.copyWith(
                              color: context.colors.onSurface,
                              fontWeight: FontWeight.w500,
                              fontSize: 9,
                              letterSpacing: 0.5,
                            ),
                          ),
                        ),
                      ),
                    ],
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

class _ServiceCard extends StatefulWidget {
  final IconData icon;
  final String title;
  final String desc;
  final Color topBorderColor;

  const _ServiceCard({
    required this.icon,
    required this.title,
    required this.desc,
    required this.topBorderColor,
  });

  @override
  State<_ServiceCard> createState() => _ServiceCardState();
}

class _ServiceCardState extends State<_ServiceCard> {
  bool _isHovered = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) => setState(() => _isHovered = true),
      onExit: (_) => setState(() => _isHovered = false),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        decoration: BoxDecoration(
          color: _isHovered
              ? context.colors.surfaceContainerHigh.withValues(alpha: 0.5)
              : context.colors.surfaceContainer.withValues(alpha: 0.4),
          border: Border.all(
            color: context.colors.outlineVariant.withValues(alpha: 0.15),
            width: 1,
          ),
          borderRadius: AppBorders.xs,
        ),
        child: ClipRRect(
          borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(3),
            topRight: Radius.circular(3),
          ),
          child: Stack(
            children: [
              Positioned(
                top: 0,
                left: 0,
                right: 0,
                child: Container(
                  height: 2,
                  color: widget.topBorderColor,
                ),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(24, 26, 24, 24),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(widget.icon, color: widget.topBorderColor, size: 28),
                    const SizedBox(height: 16),
                    Text(
                      widget.title,
                      style: AppTextStyles.cardTitle.copyWith(
                        fontWeight: FontWeight.bold,
                        fontSize: 14,
                        color: context.colors.onSurface,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      widget.desc,
                      style: AppTextStyles.bodySmall.copyWith(
                        color: context.colors.onSurfaceVariant.withValues(alpha: 0.6),
                        height: 1.4,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
