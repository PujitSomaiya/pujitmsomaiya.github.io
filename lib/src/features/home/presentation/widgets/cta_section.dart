import 'package:pujit_portfolio/src/imports/imports.dart';
import 'glass_card.dart';
import 'hire_me_dialog.dart';

class CTASection extends StatelessWidget {
  final bool isMobile;

  const CTASection({
    super.key,
    required this.isMobile,
  });

  @override
  Widget build(BuildContext context) {
    final padding = isMobile ? 24.0 : 48.0;

    return Container(
      padding: EdgeInsets.symmetric(horizontal: padding, vertical: 72),
      constraints: const BoxConstraints(maxWidth: 1200),
      child: GlassCard(
        padding: EdgeInsets.symmetric(
          horizontal: isMobile ? 24 : 48,
          vertical: 48,
        ),
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
                  onPressed: () => showHireMeDialog(context),
                  variant: ButtonVariant.primary,
                  height: ButtonSize.large,
                ),
                AppButton(
                  label: 'shared.schedule_call'.tr(),
                  onPressed: () => launchUrlHelper(BrandLinks.mailtoSchedule),
                  variant: ButtonVariant.outline,
                  height: ButtonSize.large,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
