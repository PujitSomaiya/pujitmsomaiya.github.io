import 'package:pujit_portfolio/src/imports/imports.dart';

class FooterSection extends StatelessWidget {
  final bool isMobile;

  const FooterSection({
    super.key,
    required this.isMobile,
  });

  @override
  Widget build(BuildContext context) {
    if (isMobile) {
      return _buildMobileFooter(context);
    }

    final padding = isMobile ? 24.0 : 48.0;

    return Container(
      padding: EdgeInsets.symmetric(horizontal: padding, vertical: 64),
      width: double.infinity,
      decoration: BoxDecoration(
        color: const Color(0xFF050505),
        border: Border(
          top: BorderSide(
            color: context.colors.outlineVariant.withValues(alpha: 0.3),
            width: 1,
          ),
        ),
      ),
      child: Center(
        child: Container(
          constraints: const BoxConstraints(maxWidth: 1200),
          child: Column(
            children: [
              // Logo
              Text(
                'cyberpunk.somaiya_v3_0'.tr(),
                style: context.textTheme.titleLarge?.copyWith(
                  fontWeight: FontWeight.w900,
                  color: context.colors.primary,
                  letterSpacing: 2,
                ),
              ),
              const SizedBox(height: 24),

              // Social Links row (JetBrains Mono caps)
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  _buildSocialTextButton(context, 'cyberpunk.github'.tr(), BrandLinks.github),
                  const SizedBox(width: 32),
                  _buildSocialTextButton(context, 'cyberpunk.linkedin_upper'.tr(), BrandLinks.linkedin),
                  const SizedBox(width: 32),
                  _buildSocialTextButton(context, 'cyberpunk.resume_upper'.tr(), BrandLinks.resume),
                ],
              ),
              const SizedBox(height: 24),

              // Copyright
              Text(
                'cyberpunk.copyright_core'.tr(args: ['cyberpunk.all_rights_reserved'.tr()]),
                style: AppTextStyles.bodySmall.copyWith(
                  color: context.colors.onSurfaceVariant.withValues(alpha: 0.4),
                  fontSize: 11,
                  fontWeight: FontWeight.bold,
                  letterSpacing: 1,
                ),
              ),
              const SizedBox(height: 16),

              // Encryption diagnostics line
              Text(
                'cyberpunk.diagnostics'.tr(),
                style: AppTextStyles.bodySmall.copyWith(
                  color: context.colors.onSurfaceVariant.withValues(alpha: 0.2),
                  fontSize: 8.5,
                  letterSpacing: 1.5,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildSocialTextButton(BuildContext context, String label, String url) {
    return InkWell(
      onTap: () => launchUrl(Uri.parse(url), mode: LaunchMode.externalApplication),
      child: Text(
        label,
        style: AppTextStyles.bodySmall.copyWith(
          color: context.colors.onSurfaceVariant.withValues(alpha: 0.7),
          fontWeight: FontWeight.bold,
          letterSpacing: 1,
        ),
      ),
    );
  }

  Widget _buildMobileFooter(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 48),
      width: double.infinity,
      decoration: BoxDecoration(
        color: const Color(0xFF050505),
        border: Border(
          top: BorderSide(
            color: context.colors.outlineVariant.withValues(alpha: 0.3),
            width: 1,
          ),
        ),
      ),
      child: Column(
        children: [
          // Monospace status row: SYSTEM_ONLINE | UPLINK_STABLE
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                width: 6,
                height: 6,
                decoration: const BoxDecoration(
                  shape: BoxShape.circle,
                  color: Color(0xFF10B981), // Cyber Green
                ),
              ),
              const SizedBox(width: 8),
              Text(
                'cyberpunk.system_online'.tr().toUpperCase(),
                style: AppTextStyles.bodySmall.copyWith(
                  color: const Color(0xFF10B981), // Cyber Green
                  fontWeight: FontWeight.bold,
                  fontSize: 10,
                  letterSpacing: 1,
                ),
              ),
              const SizedBox(width: 12),
              Text(
                '|',
                style: AppTextStyles.bodySmall.copyWith(
                  color: context.colors.onSurfaceVariant.withValues(alpha: 0.3),
                  fontSize: 10,
                ),
              ),
              const SizedBox(width: 12),
              Text(
                'cyberpunk.uplink_stable'.tr().toUpperCase(),
                style: AppTextStyles.bodySmall.copyWith(
                  color: context.colors.onSurface,
                  fontWeight: FontWeight.bold,
                  fontSize: 10,
                  letterSpacing: 1,
                ),
              ),
            ],
          ),
          const SizedBox(height: 24),

          // Social links: GITHUB, LINKEDIN, RESUME
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              _buildSocialTextButton(context, 'cyberpunk.github'.tr(), BrandLinks.github),
              const SizedBox(width: 24),
              _buildSocialTextButton(context, 'cyberpunk.linkedin_upper'.tr(), BrandLinks.linkedin),
              const SizedBox(width: 24),
              _buildSocialTextButton(context, 'cyberpunk.resume_upper'.tr(), BrandLinks.resume),
            ],
          ),
          const SizedBox(height: 32),

          // Monospace Copyright and Reserved lines
          Text(
            'cyberpunk.copyright_core'.tr(args: ['cyberpunk.all_rights_reserved'.tr()]),
            textAlign: TextAlign.center,
            style: AppTextStyles.bodySmall.copyWith(
              color: context.colors.onSurfaceVariant.withValues(alpha: 0.3),
              fontSize: 8.5,
              fontWeight: FontWeight.bold,
              letterSpacing: 0.5,
            ),
          ),
        ],
      ),
    );
  }
}
