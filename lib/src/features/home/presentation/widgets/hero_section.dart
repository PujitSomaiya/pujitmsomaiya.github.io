import 'package:pujit_portfolio/src/imports/imports.dart';
import 'profile_image.dart';

class HeroSection extends StatelessWidget {
  final bool isMobile;

  const HeroSection({
    super.key,
    required this.isMobile,
  });

  @override
  Widget build(BuildContext context) {
    if (isMobile) {
      return _buildMobileHero(context);
    }

    return Container(
      constraints: BoxConstraints(minHeight: context.height - 80),
      padding: const EdgeInsets.symmetric(horizontal: 48, vertical: 64),
      alignment: Alignment.center,
      child: Center(
        child: Container(
          constraints: const BoxConstraints(maxWidth: 1000),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              // Avatar with Neon Glow Behind
              Stack(
                alignment: Alignment.center,
                children: [
                  Positioned.fill(
                    child: Container(
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        boxShadow: [
                          BoxShadow(
                            color: AppColors.neonPurple.withValues(alpha: 0.15),
                            blurRadius: 100,
                            spreadRadius: 20,
                          ),
                        ],
                      ),
                    ),
                  ),
                  Container(
                    width: 140,
                    height: 140,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      border: Border.all(
                        color: AppColors.neonPurple,
                        width: 2.5,
                      ),
                      boxShadow: [
                        BoxShadow(
                          color: AppColors.neonPurple.withValues(alpha: 0.3),
                          blurRadius: 30,
                        )
                      ],
                    ),
                    child: const ClipOval(
                      child: ProfileImage(),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 24),

              // Operator status badge
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
                decoration: BoxDecoration(
                  color: AppColors.cyberGreen.withValues(alpha: 0.05),
                  borderRadius: AppBorders.full,
                  border: Border.all(
                    color: AppColors.cyberGreen.withValues(alpha: 0.3),
                  ),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
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
                      'portfolio.available_opportunities'.tr().toUpperCase(),
                      style: AppTextStyles.bodySmall.copyWith(
                        color: AppColors.cyberGreen,
                        fontWeight: FontWeight.bold,
                        letterSpacing: 1.5,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 32),

              // Name Heading
              Text(
                'shared.brand_name'.tr().toUpperCase(),
                textAlign: TextAlign.center,
                style: context.textTheme.displayLarge?.copyWith(
                  fontWeight: FontWeight.w900,
                  fontSize: 72,
                  height: 1,
                  letterSpacing: -2,
                  shadows: [
                    Shadow(
                      color: Colors.white.withValues(alpha: 0.1),
                      blurRadius: 15,
                    )
                  ],
                ),
              ),
              const SizedBox(height: 12),

              // Role Subtitle
              RichText(
                textAlign: TextAlign.center,
                text: TextSpan(
                  text: '${'portfolio.mobile_engineer'.tr().toUpperCase()}\n',
                  style: AppTextStyles.bodySmall.copyWith(
                    color: context.colors.onSurfaceVariant,
                    fontSize: 12,
                    letterSpacing: 2,
                    height: 2,
                  ),
                  children: [
                    TextSpan(
                      text: '"${'portfolio.headline'.tr()}"',
                      style: AppTextStyles.bodySmall.copyWith(
                        color: context.colors.primaryContainer,
                        fontSize: 12,
                        letterSpacing: 0,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 64),

              // Stats panel grid
              GridView.count(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                crossAxisCount: 4,
                crossAxisSpacing: 24,
                mainAxisSpacing: 24,
                childAspectRatio: 1.8,
                children: [
                  _buildStatCard(context, 'portfolio.experience.subtitle'.tr().toUpperCase(), '${'portfolio.stats.years_exp'.tr()} ${'portfolio.stats.years_exp_label'.tr().toUpperCase()}', AppColors.neonPurple),
                  _buildStatCard(context, 'portfolio.work.subtitle'.tr().toUpperCase(), '${'portfolio.stats.projects'.tr()} ${'portfolio.stats.projects_label'.tr().toUpperCase()}', AppColors.cyberGreen),
                  _buildStatCard(context, 'portfolio.skills.subtitle'.tr().toUpperCase(), '${'portfolio.stats.frameworks'.tr()} ${'portfolio.stats.frameworks_label'.tr().toUpperCase()}', AppColors.warningOrange),
                  _buildStatCard(context, 'portfolio.about.title'.tr().toUpperCase(), '${'portfolio.stats.industries'.tr()} ${'portfolio.stats.industries_label'.tr().toUpperCase()}', AppColors.lavender),
                ],
              ),
              const SizedBox(height: 64),

              // Bouncing HUD index loader indicator
              Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    'cyberpunk.nav_terminal'.tr(),
                    style: AppTextStyles.bodySmall.copyWith(
                      color: context.colors.onSurfaceVariant.withValues(alpha: 0.5),
                      letterSpacing: 2,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Icon(
                    Icons.expand_more_rounded,
                    color: context.colors.onSurfaceVariant.withValues(alpha: 0.5),
                  ),
                ],
              )
                  .animate(onPlay: (controller) => controller.repeat(reverse: true))
                  .slideY(
                    begin: 0,
                    end: 0.3,
                    duration: const Duration(milliseconds: 900),
                    curve: Curves.easeInOut,
                  ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildStatCard(BuildContext context, String label, String value, Color accentColor) {
    return DecoratedBox(
      decoration: BoxDecoration(
        color: context.colors.surfaceContainer.withValues(alpha: 0.4),
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
        child: Row(
          children: [
            Container(
              width: 4,
              color: accentColor,
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      label,
                      style: AppTextStyles.bodySmall.copyWith(
                        color: accentColor,
                        fontWeight: FontWeight.bold,
                        fontSize: 10,
                      ),
                    ),
                    const SizedBox(height: 6),
                    Text(
                      value,
                      style: context.textTheme.titleMedium?.copyWith(
                        fontWeight: FontWeight.bold,
                        color: context.colors.onSurface,
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

  Widget _buildMobileHero(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 48),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          // Operator V2.0 Avatar Stack with spin ring
          Center(
            child: Stack(
              alignment: Alignment.center,
              children: [
                // Outer slow rotating ring
                _RotatingRing(
                  width: 128,
                  height: 128,
                  borderColor: AppColors.neonPurple.withValues(alpha: 0.3), // Purple opacity
                  duration: const Duration(seconds: 12),
                ),
                // Inner static ring
                Container(
                  width: 112,
                  height: 112,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    border: Border.all(
                      color: AppColors.cyberGreen.withValues(alpha: 0.4), // Green opacity
                      width: 1,
                    ),
                  ),
                ),
                // Center avatar container with glow and border
                Container(
                  width: 96,
                  height: 96,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: AppColors.surfaceLowest,
                    border: Border.all(
                      color: AppColors.neonPurple,
                      width: 1,
                    ),
                    boxShadow: [
                      BoxShadow(
                        color: AppColors.neonPurple.withValues(alpha: 0.25),
                        blurRadius: 15,
                      )
                    ],
                  ),
                  child: const ClipOval(
                    child: ProfileImage(),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 32),

          // Name Title
          Text(
            'shared.brand_name'.tr().toUpperCase(),
            textAlign: TextAlign.center,
            style: context.textTheme.headlineLarge?.copyWith(
              fontWeight: FontWeight.w900,
              letterSpacing: 4,
              fontSize: 24,
            ),
          ),
          const SizedBox(height: 16),

          // Stars Row
          Row(
            mainAxisSize: MainAxisSize.min,
            children: List.generate(
              5,
              (_) => const Icon(
                Icons.star_rounded,
                color: AppColors.warningOrange, // Warning Orange
                size: 16,
              ),
            ),
          ),
          const SizedBox(height: 16),

          // Technical Role Subtitle
          Text(
            'portfolio.mobile_engineer'.tr().toUpperCase(),
            textAlign: TextAlign.center,
            style: AppTextStyles.bodySmall.copyWith(
              color: context.colors.onSurfaceVariant,
              fontSize: 10,
              fontWeight: FontWeight.bold,
              letterSpacing: 1.5,
            ),
          ),
          const SizedBox(height: 32),

          DecoratedBox(
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
                      width: 4,
                      color: AppColors.warningOrange,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(20, 16, 16, 16),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 3),
                          decoration: const BoxDecoration(
                            color: AppColors.warningOrange,
                            borderRadius: BorderRadius.zero,
                          ),
                          child: Text(
                            'cyberpunk.bio'.tr(),
                            style: AppTextStyles.bodySmall.copyWith(
                              color: AppColors.voidBlack,
                              fontWeight: FontWeight.bold,
                              fontSize: 9,
                            ),
                          ),
                        ),
                        const SizedBox(width: 16),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'cyberpunk.bio_headline'.tr(),
                                style: AppTextStyles.bodySmall.copyWith(
                                  color: AppColors.warningOrange,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 10,
                                ),
                              ),
                              const SizedBox(height: 8),
                              Text(
                                'cyberpunk.bio_desc'.tr(),
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
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _RotatingRing extends StatefulWidget {
  final double width;
  final double height;
  final Color borderColor;
  final Duration duration;

  const _RotatingRing({
    required this.width,
    required this.height,
    required this.borderColor,
    required this.duration,
  });

  @override
  State<_RotatingRing> createState() => _RotatingRingState();
}

class _RotatingRingState extends State<_RotatingRing> with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: widget.duration,
    )..repeat();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return RotationTransition(
      turns: _controller,
      child: Container(
        width: widget.width,
        height: widget.height,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          border: Border.all(
            color: widget.borderColor,
            width: 2,
          ),
        ),
      ),
    );
  }
}
