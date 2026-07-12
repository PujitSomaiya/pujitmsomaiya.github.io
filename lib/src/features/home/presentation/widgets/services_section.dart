import 'package:pujit_portfolio/src/imports/imports.dart';
import 'glass_card.dart';

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
    final padding = isMobile ? 24.0 : 48.0;

    final servicesList = [
      (Icons.smartphone_rounded, 'portfolio.services.s1_title'.tr(), 'portfolio.services.s1_desc'.tr(), context.colors.primary),
      (Icons.devices_rounded, 'portfolio.services.s2_title'.tr(), 'portfolio.services.s2_desc'.tr(), context.colors.secondary),
      (Icons.bug_report_outlined, 'portfolio.services.s3_title'.tr(), 'portfolio.services.s3_desc'.tr(), context.colors.primary),
      (Icons.palette_outlined, 'portfolio.services.s4_title'.tr(), 'portfolio.services.s4_desc'.tr(), context.colors.secondary),
      (Icons.api_rounded, 'portfolio.services.s5_title'.tr(), 'portfolio.services.s5_desc'.tr(), context.colors.primary),
      (Icons.payments_outlined, 'portfolio.services.s6_title'.tr(), 'portfolio.services.s6_desc'.tr(), context.colors.secondary),
      (Icons.speed_rounded, 'portfolio.services.s7_title'.tr(), 'portfolio.services.s7_desc'.tr(), context.colors.primary),
      (Icons.cloud_upload_outlined, 'portfolio.services.s8_title'.tr(), 'portfolio.services.s8_desc'.tr(), context.colors.secondary),
    ];

    return Container(
      padding: EdgeInsets.symmetric(horizontal: padding, vertical: 72),
      width: double.infinity,
      color: const Color(0xFF151B2A), // Low surface container color
      child: Center(
        child: Container(
          constraints: const BoxConstraints(maxWidth: 1200),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                'portfolio.services.subtitle'.tr().toUpperCase(),
                style: context.textTheme.labelMedium?.copyWith(
                  color: context.colors.tertiary,
                  fontWeight: FontWeight.bold,
                  letterSpacing: 2,
                ),
              ),
              const SizedBox(height: 8),
              Text(
                'portfolio.services.title'.tr(),
                style: context.textTheme.headlineMedium?.copyWith(
                  fontWeight: FontWeight.bold,
                  color: context.colors.onSurface,
                ),
              ),
              const SizedBox(height: 48),
              // Services Grid
              GridView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: servicesList.length,
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: isMobile ? 1 : (screenWidth < 1100 ? 2 : 4),
                  crossAxisSpacing: 20,
                  mainAxisSpacing: 20,
                  childAspectRatio: isMobile ? 1.8 : 1.1,
                ),
                itemBuilder: (context, index) {
                  final service = servicesList[index];
                  return GlassCard(
                    padding: const EdgeInsets.all(20),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(service.$1, size: 28, color: service.$4),
                        const SizedBox(height: 16),
                        Text(
                          service.$2,
                          style: context.textTheme.titleMedium?.copyWith(
                            fontWeight: FontWeight.bold,
                            color: context.colors.onSurface,
                          ),
                        ),
                        const SizedBox(height: 8),
                        Expanded(
                          child: Text(
                            service.$3,
                            style: context.textTheme.bodySmall?.copyWith(
                              color: context.colors.onSurfaceVariant,
                              height: 1.4,
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
        ),
      ),
    );
  }
}
