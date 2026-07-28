import 'package:pujit_portfolio/src/imports/imports.dart';

class CTASection extends StatelessWidget {
  final bool isMobile;

  const CTASection({
    super.key,
    required this.isMobile,
  });

  @override
  Widget build(BuildContext context) {
    if (isMobile) {
      return _buildMobileLayout(context);
    }

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 48, vertical: 80),
      alignment: Alignment.center,
      child: Container(
        constraints: const BoxConstraints(maxWidth: 1100),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            // Left Column: Details
            Expanded(
              flex: 5,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'cyberpunk.establish_link'.tr(),
                    style: AppTextStyles.sectionTitle.copyWith(
                      color: const Color(0xFF8B5CF6), // Neon Purple
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 24),
                  Text(
                    'cyberpunk.establish_link_desc'.tr(),
                    style: AppTextStyles.bodySmall.copyWith(
                      color: context.colors.onSurfaceVariant.withValues(alpha: 0.7),
                      fontSize: 14,
                      height: 1.6,
                    ),
                  ),
                  const SizedBox(height: 48),

                  // Links List
                  _buildContactLink(
                    context,
                    Icons.mail_outline_rounded,
                    'cyberpunk.email_slug'.tr(),
                    const Color(0xFF8B5CF6),
                    () => launchUrl(Uri.parse(BrandLinks.mailtoGeneral), mode: LaunchMode.externalApplication),
                  ),
                  const SizedBox(height: 24),
                  _buildContactLink(
                    context,
                    Icons.location_on_outlined,
                    'cyberpunk.location_slug'.tr(),
                    const Color(0xFF10B981),
                    () {},
                  ),
                ],
              ),
            ),
            const SizedBox(width: 80),

            // Right Column: Form Wrapped in HudBorder
            Expanded(
              flex: 6,
              child: HudBorder(
                padding: const EdgeInsets.all(36),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    _buildInputField(context, 'cyberpunk.entity_id'.tr(), 'cyberpunk.name_placeholder'.tr()),
                    const SizedBox(height: 20),
                    _buildInputField(context, 'cyberpunk.comm_freq'.tr(), 'cyberpunk.email_placeholder'.tr()),
                    const SizedBox(height: 20),
                    _buildInputField(context, 'cyberpunk.transmission_data'.tr(), 'cyberpunk.mission_placeholder'.tr(), maxLines: 4),
                    const SizedBox(height: 32),

                    // EXECUTE_TRANSMISSION BUTTON
                    ElevatedButton.icon(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFF8B5CF6),
                        foregroundColor: const Color(0xFF050505),
                        padding: const EdgeInsets.symmetric(vertical: 20),
                        elevation: 8,
                        shadowColor: const Color(0xFF8B5CF6).withValues(alpha: 0.5),
                        shape: const RoundedRectangleBorder(
                          borderRadius: AppBorders.xs,
                        ),
                      ),
                      onPressed: () {},
                      icon: const Icon(Icons.send_rounded, size: 18),
                      label: Text(
                        'cyberpunk.execute_transmission'.tr(),
                        style: AppTextStyles.buttonText.copyWith(
                          color: const Color(0xFF050505),
                          fontWeight: FontWeight.w900,
                          letterSpacing: 1.5,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildContactLink(
    BuildContext context,
    IconData icon,
    String label,
    Color color,
    VoidCallback onTap,
  ) {
    return InkWell(
      onTap: onTap,
      borderRadius: AppBorders.xs,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 8),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(icon, color: color, size: 24),
            const SizedBox(width: 16),
            Text(
              label,
              style: AppTextStyles.bodySmall.copyWith(
                color: context.colors.onSurface,
                fontWeight: FontWeight.bold,
                letterSpacing: 1,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildInputField(
    BuildContext context,
    String label,
    String hint, {
    int maxLines = 1,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: AppTextStyles.bodySmall.copyWith(
            color: context.colors.onSurfaceVariant.withValues(alpha: 0.5),
            fontWeight: FontWeight.bold,
            fontSize: 10,
            letterSpacing: 1.5,
          ),
        ),
        const SizedBox(height: 8),
        TextField(
          maxLines: maxLines,
          cursorColor: const Color(0xFF8B5CF6),
          style: AppTextStyles.bodySmall.copyWith(
            color: context.colors.onSurface,
            fontWeight: FontWeight.w600,
          ),
          decoration: InputDecoration(
            hintText: hint,
            hintStyle: AppTextStyles.bodySmall.copyWith(
              color: context.colors.onSurfaceVariant.withValues(alpha: 0.25),
            ),
            fillColor: context.colors.surfaceContainer.withValues(alpha: 0.3),
            filled: true,
            contentPadding: const EdgeInsets.all(16),
            enabledBorder: OutlineInputBorder(
              borderSide: BorderSide(
                color: context.colors.outlineVariant.withValues(alpha: 0.2),
              ),
              borderRadius: AppBorders.xs,
            ),
            focusedBorder: const OutlineInputBorder(
              borderSide: BorderSide(
                color: Color(0xFF8B5CF6),
                width: 1.5,
              ),
              borderRadius: AppBorders.xs,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildMobileLayout(BuildContext context) {
    final padding = isMobile ? 24.0 : 48.0;

    return Container(
      padding: EdgeInsets.symmetric(horizontal: padding, vertical: 72),
      child: Center(
        child: Container(
          constraints: const BoxConstraints(maxWidth: 1200),
          child: Column(
            children: [
              Text(
                'portfolio.cta.title'.tr(),
                textAlign: TextAlign.center,
                style: context.textTheme.headlineMedium?.copyWith(
                  fontWeight: FontWeight.w900,
                  color: context.colors.onSurface,
                  fontSize: isMobile ? 24 : 32,
                ),
              ),
              const SizedBox(height: 16),
              Text(
                'portfolio.cta.desc'.tr(),
                textAlign: TextAlign.center,
                style: context.textTheme.bodyLarge?.copyWith(
                  color: context.colors.onSurfaceVariant,
                ),
              ),
              const SizedBox(height: 32),
              Wrap(
                spacing: 16,
                runSpacing: 16,
                alignment: WrapAlignment.center,
                children: [
                  AppButton(
                    label: 'shared.get_in_touch'.tr(),
                    onPressed: () {},
                    variant: ButtonVariant.primary,
                    height: ButtonSize.large,
                  ),
                  AppButton(
                    label: 'shared.schedule_call'.tr(),
                    onPressed: () => launchUrl(Uri.parse(BrandLinks.mailtoSchedule), mode: LaunchMode.externalApplication),
                    variant: ButtonVariant.outline,
                    height: ButtonSize.large,
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
