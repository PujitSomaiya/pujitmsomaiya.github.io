import 'package:pujit_portfolio/src/imports/imports.dart';
import 'hire_me_dialog.dart';

class FooterSection extends StatelessWidget {
  final bool isMobile;

  const FooterSection({
    super.key,
    required this.isMobile,
  });

  @override
  Widget build(BuildContext context) {
    final padding = isMobile ? 24.0 : 48.0;

    return Container(
      padding: EdgeInsets.symmetric(horizontal: padding, vertical: 40),
      width: double.infinity,
      decoration: BoxDecoration(
        color: context.colors.surfaceContainerLowest,
        border: Border(
          top: BorderSide(
            color: Colors.white.withValues(alpha: 0.05),
            width: 1,
          ),
        ),
      ),
      child: Center(
        child: Container(
          constraints: const BoxConstraints(maxWidth: 1200),
          child: Column(
            children: [
              if (isMobile) ...[
                Text(
                  'shared.brand_name'.tr(),
                  style: context.textTheme.titleMedium?.copyWith(
                    fontWeight: FontWeight.bold,
                    color: context.colors.onSurface,
                  ),
                ),
                const SizedBox(height: 16),
                _buildSocialLinks(context),
                const SizedBox(height: 24),
                Text(
                  'portfolio.footer.copyright'.tr(args: [DateTime.now().year.toString()]),
                  textAlign: TextAlign.center,
                  style: AppTextStyles.footerText.copyWith(
                    color: context.colors.onSurfaceVariant,
                  ),
                ),
              ] else
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'shared.brand_name'.tr(),
                          style: context.textTheme.titleMedium?.copyWith(
                            fontWeight: FontWeight.bold,
                            color: context.colors.onSurface,
                          ),
                        ),
                        const SizedBox(height: 8),
                        Text(
                          'portfolio.footer.copyright'.tr(args: [DateTime.now().year.toString()]),
                          style: AppTextStyles.footerText.copyWith(
                            color: context.colors.onSurfaceVariant,
                          ),
                        ),
                      ],
                    ),
                    _buildSocialLinks(context),
                  ],
                ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildSocialLinks(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        IconButton(
          icon: const Icon(Icons.email_outlined),
          color: context.colors.onSurfaceVariant,
          onPressed: () => launchUrlHelper(BrandLinks.mailtoGeneral),
        ),
        IconButton(
          icon: const Icon(Icons.terminal_rounded),
          color: context.colors.onSurfaceVariant,
          onPressed: () => launchUrlHelper(BrandLinks.linkedin),
        ),
        IconButton(
          icon: const Icon(Icons.code_rounded),
          color: context.colors.onSurfaceVariant,
          onPressed: () => launchUrlHelper(BrandLinks.github),
        ),
      ],
    );
  }
}
