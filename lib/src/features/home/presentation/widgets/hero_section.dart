import 'dart:ui';
import 'package:pujit_portfolio/src/imports/imports.dart';
import 'green_pulse_dot.dart';
import 'profile_image.dart';
import 'hire_me_dialog.dart';
import 'gradient_text.dart';

class HeroSection extends StatelessWidget {
  final bool isMobile;

  const HeroSection({
    super.key,
    required this.isMobile,
  });

  @override
  Widget build(BuildContext context) {
    final padding = isMobile ? 24.0 : 48.0;

    final textContent = Column(
      crossAxisAlignment: isMobile ? CrossAxisAlignment.center : CrossAxisAlignment.start,
      children: [
        // Pulse Availability badge
        Container(
          padding: EdgeInsets.symmetric(horizontal: AppSpacing.md, vertical: AppSpacing.sm),
          decoration: BoxDecoration(
            color: Colors.white.withValues(alpha: 0.05),
            borderRadius: AppBorders.full,
            border: Border.all(
              color: Colors.white.withValues(alpha: 0.1),
            ),
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              const GreenPulseDot(),
              const SizedBox(width: 8),
              Text(
                'portfolio.available_opportunities'.tr().toUpperCase(),
                style: AppTextStyles.bodySmall.copyWith(
                  fontSize: 11,
                  fontWeight: FontWeight.w600,
                  letterSpacing: 1.5,
                  color: const Color(0xFFC3C6D7),
                ),
              ),
            ],
          ),
        ).animate().fadeIn(duration: const Duration(milliseconds: 500)).slideY(begin: 0.2, end: 0),
        const SizedBox(height: 24),

        // Subtitle/Role
        Text(
          'portfolio.role'.tr(),
          style: context.textTheme.titleMedium?.copyWith(
            color: context.colors.secondary,
            fontWeight: FontWeight.bold,
            fontSize: isMobile ? 18 : 22,
          ),
        ).animate().fadeIn(delay: const Duration(milliseconds: 100), duration: const Duration(milliseconds: 500)),
        const SizedBox(height: 12),

        // Main Title Gradient
        GradientText(
          'portfolio.headline'.tr(),
          gradient: const LinearGradient(
            colors: [Color(0xFFB4C5FF), Color(0xFF7BD0FF)],
          ),
          style: context.textTheme.displayMedium?.copyWith(
            fontWeight: FontWeight.w900,
            fontSize: isMobile ? 32 : 48,
            height: 1.2,
          ),
        ).animate().fadeIn(delay: const Duration(milliseconds: 200), duration: const Duration(milliseconds: 500)),
        const SizedBox(height: 16),

        // Paragraph
        Text(
          'portfolio.sub_headline'.tr(),
          textAlign: isMobile ? TextAlign.center : TextAlign.start,
          style: context.textTheme.bodyLarge?.copyWith(
            color: context.colors.onSurfaceVariant,
            fontSize: isMobile ? 15 : 18,
            height: 1.6,
          ),
        ).animate().fadeIn(delay: const Duration(milliseconds: 300), duration: const Duration(milliseconds: 500)),
        const SizedBox(height: 32),

        // Action Buttons
        Wrap(
          spacing: 12,
          runSpacing: 12,
          alignment: isMobile ? WrapAlignment.center : WrapAlignment.start,
          children: [
            AppButton(
              label: 'shared.hire_me'.tr(),
              onPressed: () => showHireMeDialog(context),
              variant: ButtonVariant.primary,
              height: ButtonSize.large,
            ),
            AppButton(
              label: 'shared.download_cv'.tr(),
              onPressed: () => launchUrlHelper(BrandLinks.linkedin),
              variant: ButtonVariant.outline,
              height: ButtonSize.large,
            ),
            TextButton.icon(
              onPressed: () => launchUrlHelper(BrandLinks.linkedin),
              icon: Text(
                'shared.connect_linkedin'.tr(),
                style: TextStyle(
                  color: context.colors.secondary,
                  fontWeight: FontWeight.bold,
                ),
              ),
              label: Icon(
                Icons.open_in_new_rounded,
                size: 14,
                color: context.colors.secondary,
              ),
            ),
          ],
        ).animate().fadeIn(delay: const Duration(milliseconds: 400), duration: const Duration(milliseconds: 500)),
        const SizedBox(height: 48),

        // Stats grid
        GridView.count(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          crossAxisCount: isMobile ? 2 : 4,
          childAspectRatio: 1.5,
          crossAxisSpacing: 16,
          mainAxisSpacing: 16,
          children: [
            _buildStatItem(context, 'portfolio.stats.years_exp'.tr(), 'portfolio.stats.years_exp_label'.tr()),
            _buildStatItem(context, 'portfolio.stats.projects'.tr(), 'portfolio.stats.projects_label'.tr()),
            _buildStatItem(context, 'portfolio.stats.frameworks'.tr(), 'portfolio.stats.frameworks_label'.tr()),
            _buildStatItem(context, 'portfolio.stats.industries'.tr(), 'portfolio.stats.industries_label'.tr()),
          ],
        ).animate().fadeIn(delay: const Duration(milliseconds: 500), duration: const Duration(milliseconds: 500)),
      ],
    );

    // Profile photo card
    final avatarCard = Center(
      child: Stack(
        alignment: Alignment.center,
        children: [
          // Background Glow aura
          Positioned.fill(
            child: Container(
              margin: EdgeInsets.all(AppSpacing.sm),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(32.r),
                gradient: LinearGradient(
                  colors: [
                    context.colors.primary.withValues(alpha: 0.2),
                    context.colors.secondary.withValues(alpha: 0.2),
                  ],
                ),
              ),
            ).animate().blurXY(begin: 10, end: 40, duration: const Duration(milliseconds: 1500)),
          ),
          // Actual Profile Image Container
          Container(
            width: isMobile ? 250 : 360,
            height: isMobile ? 250 : 360,
            decoration: BoxDecoration(
              color: context.colors.surfaceContainer,
              borderRadius: BorderRadius.circular(32.r),
              border: Border.all(
                color: Colors.white.withValues(alpha: 0.1),
                width: 1.5,
              ),
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(30.r),
              child: Stack(
                fit: StackFit.expand,
                children: [
                  const ProfileImage(),
                  // Glass details overlay at bottom
                  Positioned(
                    bottom: 16,
                    left: 16,
                    right: 16,
                    child: ClipRRect(
                      borderRadius: AppBorders.lg,
                      child: BackdropFilter(
                        filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
                        child: Container(
                          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                          decoration: BoxDecoration(
                            color: Colors.white.withValues(alpha: 0.05),
                            borderRadius: AppBorders.lg,
                            border: Border.all(
                              color: Colors.white.withValues(alpha: 0.1),
                              width: 1,
                            ),
                          ),
                          child: Row(
                            children: [
                              Container(
                                padding: const EdgeInsets.all(8),
                                decoration: BoxDecoration(
                                  color: context.colors.primary.withValues(alpha: 0.15),
                                  borderRadius: AppBorders.sm,
                                ),
                                child: Icon(
                                  Icons.developer_mode_rounded,
                                  color: context.colors.primary,
                                  size: 20,
                                ),
                              ),
                              const SizedBox(width: 12),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    Text(
                                      'shared.brand_name'.tr(),
                                      style: context.textTheme.bodyMedium?.copyWith(
                                        fontWeight: FontWeight.bold,
                                        color: context.colors.onSurface,
                                      ),
                                    ),
                                    Text(
                                      'portfolio.mobile_engineer'.tr(),
                                      style: context.textTheme.labelSmall?.copyWith(
                                        color: context.colors.onSurfaceVariant,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );

    return Container(
      padding: EdgeInsets.symmetric(horizontal: padding, vertical: 48),
      constraints: const BoxConstraints(maxWidth: 1200),
      child: isMobile
          ? Column(
              children: [
                avatarCard,
                const SizedBox(height: 48),
                textContent,
              ],
            )
          : Row(
              children: [
                Expanded(flex: 7, child: textContent),
                const SizedBox(width: 48),
                Expanded(flex: 5, child: avatarCard),
              ],
            ),
    );
  }

  Widget _buildStatItem(BuildContext context, String value, String label) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          value,
          style: context.textTheme.headlineMedium?.copyWith(
            fontWeight: FontWeight.w800,
            color: context.colors.primary,
          ),
        ),
        const SizedBox(height: 2),
        Text(
          label,
          style: AppTextStyles.bodySmall.copyWith(
            color: const Color(0xFFC3C6D7),
            letterSpacing: 0.5,
          ),
        ),
      ],
    );
  }
}
