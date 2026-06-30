import 'dart:ui';
import 'package:pujit_portfolio/src/imports/imports.dart';

class HomePage extends HookWidget {
  const HomePage({super.key});

  // Helper to open links
  Future<void> _launchUrlHelper(String url) async {
    final uri = Uri.parse(url);
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri, mode: LaunchMode.externalApplication);
    }
  }

  // Show "Hire Me" contact popup dialog
  void _showHireMeDialog(BuildContext context) {
    context.showAppDialog<void>(
      builder: (context) {
        return BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 8, sigmaY: 8),
          child: AlertDialog(
            backgroundColor: context.colors.surfaceContainer,
            shape: RoundedRectangleBorder(
              borderRadius: AppBorders.dialog,
              side: BorderSide(
                color: Colors.white.withValues(alpha: 0.08),
                width: 1,
              ),
            ),
            title: Text(
              'shared.get_in_touch'.tr(),
              style: context.textTheme.headlineSmall?.copyWith(
                fontWeight: FontWeight.bold,
                color: context.colors.onSurface,
              ),
            ),
            content: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'portfolio.cta.desc'.tr(),
                  style: context.textTheme.bodyMedium?.copyWith(
                    color: context.colors.onSurfaceVariant,
                  ),
                ),
                const SizedBox(height: 20),
                ListTile(
                  leading: CircleAvatar(
                    backgroundColor: context.colors.primary.withValues(alpha: 0.1),
                    child: Icon(Icons.email_outlined, color: context.colors.primary),
                  ),
                  title: Text('shared.email'.tr()),
                  subtitle: Text('shared.email_value'.tr()),
                  onTap: () {
                    Navigator.of(context).pop();
                    _launchUrlHelper('mailto:pujit.somaiya@gmail.com?subject=Inquiry%20from%20Portfolio');
                  },
                ),
                ListTile(
                  leading: CircleAvatar(
                    backgroundColor: context.colors.secondary.withValues(alpha: 0.1),
                    child: Icon(Icons.link_rounded, color: context.colors.secondary),
                  ),
                  title: Text('shared.linkedin'.tr()),
                  subtitle: Text('shared.linkedin_value'.tr()),
                  onTap: () {
                    Navigator.of(context).pop();
                    _launchUrlHelper('https://www.linkedin.com/in/pujitsomaiya');
                  },
                ),
              ],
            ),
            actions: [
              TextButton(
                onPressed: () => Navigator.of(context).pop(),
                child: Text('shared.close'.tr()),
              ),
            ],
          ),
        );
      },
    );
  }

  // Show navigation overlay for mobile users
  void _showMobileMenu(BuildContext context, List<GlobalKey> keys) {
    showModalBottomSheet<void>(
      context: context,
      backgroundColor: context.colors.surfaceContainerHigh,
      shape: const RoundedRectangleBorder(
        borderRadius: AppBorders.bottomSheet,
      ),
      builder: (context) {
        return Padding(
          padding: const EdgeInsets.all(24),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                width: 40,
                height: 4,
                decoration: BoxDecoration(
                  color: Colors.white.withValues(alpha: 0.2),
                  borderRadius: AppBorders.full,
                ),
              ),
              const SizedBox(height: 24),
              ...List.generate(6, (index) {
                final label = switch (index) {
                  0 => 'nav.home'.tr(),
                  1 => 'nav.about'.tr(),
                  2 => 'nav.services'.tr(),
                  3 => 'nav.skills'.tr(),
                  4 => 'nav.work'.tr(),
                  _ => 'nav.experience'.tr(),
                };
                return ListTile(
                  title: Text(
                    label,
                    textAlign: TextAlign.center,
                    style: const TextStyle(fontWeight: FontWeight.w600),
                  ),
                  onTap: () {
                    Navigator.of(context).pop();
                    final key = keys[index];
                    final keyContext = key.currentContext;
                    if (keyContext != null) {
                      Scrollable.ensureVisible(
                        keyContext,
                        duration: const Duration(milliseconds: 600),
                        curve: Curves.easeInOutCubic,
                      );
                    }
                  },
                );
              }),
              const SizedBox(height: 16),
              AppButton(
                label: 'shared.hire_me'.tr(),
                onPressed: () {
                  Navigator.of(context).pop();
                  _showHireMeDialog(context);
                },
                variant: ButtonVariant.primary,
                isFullWidth: true,
              ),
              const SizedBox(height: 16),
            ],
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final scrollController = useScrollController();
    final activeSectionIndex = useState(0);

    // Section keys
    final homeKey = useMemoized(() => GlobalKey());
    final aboutKey = useMemoized(() => GlobalKey());
    final servicesKey = useMemoized(() => GlobalKey());
    final skillsKey = useMemoized(() => GlobalKey());
    final workKey = useMemoized(() => GlobalKey());
    final experienceKey = useMemoized(() => GlobalKey());

    final keys = useMemoized(() => [
      homeKey,
      aboutKey,
      servicesKey,
      skillsKey,
      workKey,
      experienceKey,
    ]);

    // Active tab highlighter scrollspy
    useEffect(() {
      void onScroll() {
        if (!scrollController.hasClients) return;
        int activeIndex = 0;
        double minDistance = double.maxFinite;
        for (int i = 0; i < keys.length; i++) {
          final keyContext = keys[i].currentContext;
          if (keyContext != null) {
            final box = keyContext.findRenderObject() as RenderBox?;
            if (box != null) {
              final position = box.localToGlobal(Offset.zero);
              final distance = position.dy.abs();
              if (distance < minDistance) {
                minDistance = distance;
                activeIndex = i;
              }
            }
          }
        }
        if (activeSectionIndex.value != activeIndex) {
          activeSectionIndex.value = activeIndex;
        }
      }
      scrollController.addListener(onScroll);
      return () => scrollController.removeListener(onScroll);
    }, [scrollController]);

    void scrollToSection(GlobalKey key) {
      final keyContext = key.currentContext;
      if (keyContext != null) {
        Scrollable.ensureVisible(
          keyContext,
          duration: const Duration(milliseconds: 650),
          curve: Curves.easeInOutCubic,
        );
      }
    }

    final screenWidth = context.width;
    final isMobile = screenWidth < 900;

    return Scaffold(
      backgroundColor: context.colors.surface,
      body: Stack(
        children: [
          // Background Glows
          Positioned(
            left: -200,
            top: -200,
            child: Container(
              width: isMobile ? 400 : 700,
              height: isMobile ? 400 : 700,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                gradient: RadialGradient(
                  colors: [
                    const Color(0xFF2563EB).withValues(alpha: 0.12),
                    const Color(0xFF2563EB).withValues(alpha: 0),
                  ],
                  stops: const [0.0, 0.7],
                ),
              ),
            ),
          ),
          Positioned(
            right: -200,
            bottom: 100,
            child: Container(
              width: isMobile ? 400 : 700,
              height: isMobile ? 400 : 700,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                gradient: RadialGradient(
                  colors: [
                    const Color(0xFF2563EB).withValues(alpha: 0.12),
                    const Color(0xFF2563EB).withValues(alpha: 0),
                  ],
                  stops: const [0.0, 0.7],
                ),
              ),
            ),
          ),

          // Scrollable Body
          Scrollbar(
            controller: scrollController,
            child: SingleChildScrollView(
              controller: scrollController,
              child: Column(
                children: [
                  // Spacer for sticky header
                  const SizedBox(height: 100),

                  // Hero section
                  _buildHeroSection(context, homeKey, isMobile),

                  // About section
                  _buildAboutSection(context, aboutKey, isMobile),

                  // Services section
                  _buildServicesSection(context, servicesKey, isMobile, screenWidth),

                  // Tech Stack section
                  _buildTechStackSection(context, skillsKey, isMobile),

                  // Work section
                  _buildWorkSection(context, workKey, isMobile),

                  // Experience section
                  _buildExperienceSection(context, experienceKey, isMobile),

                  // CTA Section
                  _buildCTASection(context, isMobile),

                  // Footer Section
                  _buildFooterSection(context, isMobile),
                ],
              ),
            ),
          ),

          // Sticky Top Navigation Bar
          Positioned(
            top: 0,
            left: 0,
            right: 0,
            child: Container(
              height: 80,
              decoration: BoxDecoration(
                color: context.colors.surface.withValues(alpha: 0.6),
                border: Border(
                  bottom: BorderSide(
                    color: Colors.white.withValues(alpha: 0.05),
                    width: 1,
                  ),
                ),
              ),
              child: ClipRect(
                child: BackdropFilter(
                  filter: ImageFilter.blur(sigmaX: 12, sigmaY: 12),
                  child: Padding(
                    padding: EdgeInsets.symmetric(
                      horizontal: isMobile ? 24 : 48,
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        // Name logo
                        Text(
                          'Pujit Somaiya',
                          style: context.textTheme.titleLarge?.copyWith(
                            fontWeight: FontWeight.w800,
                            color: context.colors.primary,
                            fontSize: isMobile ? 20 : 24,
                            letterSpacing: -0.5,
                          ),
                        ),
                        // Menu tabs (Desktop)
                        if (!isMobile)
                          Row(
                            children: List.generate(6, (index) {
                              final label = switch (index) {
                                0 => 'nav.home'.tr(),
                                1 => 'nav.about'.tr(),
                                2 => 'nav.services'.tr(),
                                3 => 'nav.skills'.tr(),
                                4 => 'nav.work'.tr(),
                                _ => 'nav.experience'.tr(),
                              };
                              final key = keys[index];
                              final isActive = activeSectionIndex.value == index;
                              return InkWell(
                                onTap: () => scrollToSection(key),
                                child: Container(
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: 16,
                                    vertical: 8,
                                  ),
                                  margin: const EdgeInsets.symmetric(horizontal: 4),
                                  decoration: BoxDecoration(
                                    border: Border(
                                      bottom: BorderSide(
                                        color: isActive
                                            ? context.colors.primary
                                            : Colors.transparent,
                                        width: 2,
                                      ),
                                    ),
                                  ),
                                  child: Text(
                                    label,
                                    style: context.textTheme.bodyMedium?.copyWith(
                                      color: isActive
                                          ? context.colors.primary
                                          : context.colors.onSurfaceVariant,
                                      fontWeight:
                                          isActive ? FontWeight.bold : FontWeight.normal,
                                    ),
                                  ),
                                ),
                              );
                            }),
                          ),
                        // Actions
                        Row(
                          children: [
                            if (!isMobile)
                              AppButton(
                                label: 'shared.hire_me'.tr(),
                                onPressed: () => _showHireMeDialog(context),
                                variant: ButtonVariant.primary,
                                height: ButtonSize.small,
                              ),
                            if (isMobile)
                              IconButton(
                                icon: Icon(
                                  Icons.menu_rounded,
                                  color: context.colors.primary,
                                  size: 28,
                                ),
                                onPressed: () => _showMobileMenu(context, keys),
                              ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  // 1. HERO SECTION
  Widget _buildHeroSection(BuildContext context, GlobalKey key, bool isMobile) {
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
              onPressed: () => _showHireMeDialog(context),
              variant: ButtonVariant.primary,
              height: ButtonSize.large,
            ),
            AppButton(
              label: 'shared.download_cv'.tr(),
              onPressed: () => _launchUrlHelper('https://www.linkedin.com/in/pujitsomaiya'),
              variant: ButtonVariant.outline,
              height: ButtonSize.large,
            ),
            TextButton.icon(
              onPressed: () => _launchUrlHelper('https://www.linkedin.com/in/pujitsomaiya'),
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
                  CachedNetworkImage(
                    imageUrl: 'https://lh3.googleusercontent.com/aida-public/AB6AXuBR68gUpRKeRNUfWzI2vKvgyjv9dZonk8sydxgrLmG28pSunfQc_AEiO9vcacFmXHWVnrRvzbG0qVR8UYzuQh65QRMsDMkUNGvZMcGmXEPCHFu5hAxR-zqTDNZPjof4YEOay0_BsG7zGAv80kWzaxU_zkPCH-CFA-MxQHjp_aFNOJch7E8WJxNz4HGe3Rmqaf9UcSiLz4639MQvL1XQiZI7Bkh7eLDEfdLJbY6WwhxYNo2Y_62_BWNpMVLPnY8a-rh1RRl0CZfTnABF',
                    fit: BoxFit.cover,
                    placeholder: (context, url) => ColoredBox(
                      color: context.colors.surfaceContainerHighest,
                      child: const Center(
                        child: CircularProgressIndicator(strokeWidth: 2),
                      ),
                    ),
                    errorWidget: (context, url, error) => ColoredBox(
                      color: context.colors.surfaceContainerHighest,
                      child: Icon(
                        Icons.person_outline_rounded,
                        size: 80,
                        color: context.colors.primary,
                      ),
                    ),
                  ),
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
                                      'Pujit Somaiya',
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
      key: key,
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

  // 2. ABOUT SECTION
  Widget _buildAboutSection(BuildContext context, GlobalKey key, bool isMobile) {
    final padding = isMobile ? 24.0 : 48.0;

    final checklistItems = [
      'portfolio.about.checklist.fintech'.tr(),
      'portfolio.about.checklist.ai'.tr(),
      'portfolio.about.checklist.payments'.tr(),
      'portfolio.about.checklist.performance'.tr(),
    ];

    final leftColumn = Column(
      crossAxisAlignment: isMobile ? CrossAxisAlignment.center : CrossAxisAlignment.start,
      children: [
        Text(
          'portfolio.about.subtitle'.tr().toUpperCase(),
          style: context.textTheme.labelMedium?.copyWith(
            color: context.colors.tertiary,
            fontWeight: FontWeight.bold,
            letterSpacing: 2,
          ),
        ),
        const SizedBox(height: 8),
        Text(
          'portfolio.about.title'.tr(),
          textAlign: isMobile ? TextAlign.center : TextAlign.start,
          style: context.textTheme.headlineMedium?.copyWith(
            fontWeight: FontWeight.bold,
            color: context.colors.onSurface,
          ),
        ),
        const SizedBox(height: 16),
        Text(
          'portfolio.about.p1'.tr(),
          textAlign: isMobile ? TextAlign.center : TextAlign.start,
          style: context.textTheme.bodyMedium?.copyWith(
            color: context.colors.onSurfaceVariant,
            height: 1.6,
          ),
        ),
        const SizedBox(height: 16),
        Text(
          'portfolio.about.p2'.tr(),
          textAlign: isMobile ? TextAlign.center : TextAlign.start,
          style: context.textTheme.bodyMedium?.copyWith(
            color: context.colors.onSurfaceVariant,
            height: 1.6,
          ),
        ),
        const SizedBox(height: 24),
        // Checklist Grid
        GridView.count(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          crossAxisCount: 2,
          childAspectRatio: 4.5,
          children: checklistItems.map((item) {
            return Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(
                  Icons.check_circle_rounded,
                  color: context.colors.primary,
                  size: 20,
                ),
                const SizedBox(width: 8),
                Expanded(
                  child: Text(
                    item,
                    style: context.textTheme.bodyMedium?.copyWith(
                      fontWeight: FontWeight.w600,
                      color: context.colors.onSurface,
                    ),
                  ),
                ),
              ],
            );
          }).toList(),
        ),
      ],
    );

    final rightColumn = Column(
      children: [
        GlassCard(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Icon(Icons.android, size: 40, color: context.colors.primary),
              const SizedBox(height: 16),
              Text(
                'portfolio.about.android_title'.tr(),
                style: context.textTheme.titleMedium?.copyWith(
                  fontWeight: FontWeight.bold,
                  color: context.colors.onSurface,
                ),
              ),
              const SizedBox(height: 8),
              Text(
                'portfolio.about.android_desc'.tr(),
                style: context.textTheme.bodySmall?.copyWith(
                  color: context.colors.onSurfaceVariant,
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 24),
        GlassCard(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Icon(Icons.flutter_dash_outlined, size: 40, color: context.colors.secondary),
              const SizedBox(height: 16),
              Text(
                'portfolio.about.flutter_title'.tr(),
                style: context.textTheme.titleMedium?.copyWith(
                  fontWeight: FontWeight.bold,
                  color: context.colors.onSurface,
                ),
              ),
              const SizedBox(height: 8),
              Text(
                'portfolio.about.flutter_desc'.tr(),
                style: context.textTheme.bodySmall?.copyWith(
                  color: context.colors.onSurfaceVariant,
                ),
              ),
            ],
          ),
        ),
      ],
    );

    return Container(
      key: key,
      padding: EdgeInsets.symmetric(horizontal: padding, vertical: 72),
      constraints: const BoxConstraints(maxWidth: 1200),
      child: isMobile
          ? Column(
              children: [
                leftColumn,
                const SizedBox(height: 48),
                rightColumn,
              ],
            )
          : Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(flex: 6, child: leftColumn),
                const SizedBox(width: 64),
                Expanded(flex: 5, child: rightColumn),
              ],
            ),
    );
  }

  // 3. SERVICES SECTION
  Widget _buildServicesSection(BuildContext context, GlobalKey key, bool isMobile, double screenWidth) {
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
      key: key,
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

  // 4. TECH STACK SECTION
  Widget _buildTechStackSection(BuildContext context, GlobalKey key, bool isMobile) {
    final padding = isMobile ? 24.0 : 48.0;

    final skillsData = [
      (
        'Mobile',
        context.colors.primary,
        ['Android (Native)', 'Flutter', 'Kotlin', 'Java', 'Dart', 'React Native']
      ),
      (
        'Architecture',
        context.colors.secondary,
        ['MVVM', 'Clean Architecture', 'Design Patterns', 'Provider / Bloc', 'Unit Testing']
      ),
      (
        'Backend & Data',
        context.colors.tertiary,
        ['Firebase', 'REST APIs', 'SQLite / Room', 'Supabase', 'GraphQL']
      ),
    ];

    final leftColumn = Column(
      crossAxisAlignment: isMobile ? CrossAxisAlignment.center : CrossAxisAlignment.start,
      children: [
        Text(
          'portfolio.skills.subtitle'.tr().toUpperCase(),
          style: context.textTheme.labelMedium?.copyWith(
            color: context.colors.tertiary,
            fontWeight: FontWeight.bold,
            letterSpacing: 2,
          ),
        ),
        const SizedBox(height: 8),
        Text(
          'portfolio.skills.title'.tr(),
          textAlign: isMobile ? TextAlign.center : TextAlign.start,
          style: context.textTheme.headlineMedium?.copyWith(
            fontWeight: FontWeight.bold,
            color: context.colors.onSurface,
          ),
        ),
        const SizedBox(height: 16),
        Text(
          'portfolio.skills.desc'.tr(),
          textAlign: isMobile ? TextAlign.center : TextAlign.start,
          style: context.textTheme.bodyMedium?.copyWith(
            color: context.colors.onSurfaceVariant,
            height: 1.6,
          ),
        ),
      ],
    );

    final rightColumn = Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: skillsData.map((category) {
        return Padding(
          padding: const EdgeInsets.only(bottom: 24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                category.$1.toUpperCase(),
                style: context.textTheme.labelSmall?.copyWith(
                  color: category.$2,
                  fontWeight: FontWeight.bold,
                  letterSpacing: 1.5,
                ),
              ),
              const SizedBox(height: 12),
              Wrap(
                spacing: 8,
                runSpacing: 8,
                children: category.$3.map((skill) {
                  return Container(
                    padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
                    decoration: BoxDecoration(
                      color: Colors.white.withValues(alpha: 0.03),
                      borderRadius: AppBorders.sm,
                      border: Border.all(
                        color: Colors.white.withValues(alpha: 0.08),
                        width: 1,
                      ),
                    ),
                    child: Text(
                      skill,
                      style: context.textTheme.labelMedium?.copyWith(
                        color: context.colors.onSurface,
                      ),
                    ),
                  );
                }).toList(),
              ),
            ],
          ),
        );
      }).toList(),
    );

    return Container(
      key: key,
      padding: EdgeInsets.symmetric(horizontal: padding, vertical: 72),
      constraints: const BoxConstraints(maxWidth: 1200),
      child: isMobile
          ? Column(
              children: [
                leftColumn,
                const SizedBox(height: 48),
                rightColumn,
              ],
            )
          : Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(flex: 5, child: leftColumn),
                const SizedBox(width: 64),
                Expanded(flex: 7, child: rightColumn),
              ],
            ),
    );
  }

  // 5. WORK / PORTFOLIO SECTION
  Widget _buildWorkSection(BuildContext context, GlobalKey key, bool isMobile) {
    final padding = isMobile ? 24.0 : 48.0;

    final projects = [
      {
        'title': 'portfolio.work.projects.p1_title'.tr(),
        'desc': 'portfolio.work.projects.p1_desc'.tr(),
        'tag': 'FinTech',
        'tech': ['Flutter', 'Stripe', 'Dart'],
        'img': 'https://lh3.googleusercontent.com/aida-public/AB6AXuAIdZwp6OH5etU0YGBzY7m1ionbkrYu1BEjSKjkezY4yDVbdWbKC2CGFa5FJhjTvVm94E-AKaW9zLX0pIV2DBC1gUg8zLeZZw7kG4vTtYkkMtGm2bqISrAjhjJpkXCgMsnpdY6w4lTGsAmlL8fPJjZ3toG0gxvIztMhnXa22wPxhrlXW5WDkg1Ajg8eLFTCLtjrvcMGV7BK03foTmEjLTjg48yCeRTeBV0LkVa1EaJqGesQ9BV-K1QWGh2FMx-zwnl1xGLM29Yl0cAJ'
      },
      {
        'title': 'portfolio.work.projects.p2_title'.tr(),
        'desc': 'portfolio.work.projects.p2_desc'.tr(),
        'tag': 'AI & Health',
        'tech': ['Android', 'MLKit', 'Kotlin'],
        'img': 'https://lh3.googleusercontent.com/aida-public/AB6AXuD10etFBP5EwzkOY8LzXAWsaDobMeRcgyhLEuqRRXk3tT2_rptn3fN023pDrWN-vv3crRuMmYlEJXOoT4GaH5oBaJP2YqVnwO4RivVnkGWHNDMA8e-UIkgjZHRe2pdfv6p62Wpr2gQf0Nu1Ptx6vmI9J7GTgT1U3Yz-xvCkv1ZFw8nwBa4pa4URMMuAGS96E5aNBWEssMmCMCULrbbqQ3pqM29nVm85iJHSbSMxyNzGzVmZLWeXK-vudYft3n4ISWBxAFYzqkNRQm1T'
      },
      {
        'title': 'portfolio.work.projects.p3_title'.tr(),
        'desc': 'portfolio.work.projects.p3_desc'.tr(),
        'tag': 'PropTech',
        'tech': ['Android', 'NFC', 'BLE'],
        'img': 'https://lh3.googleusercontent.com/aida-public/AB6AXuA1p2PLoiiPRB-az9_PI6rscQDZIMV2KOBAq54JLfC898SwfhaSUcs-1zFSMw97qryQEE3lwhuwMULgBUTxFAKusOCMrJvQ8aYwEnm-F_nxfWmdAC19STYuMet3aBtonoAu3WUZlvX-U-LFSo8NpqBbKCoXh3JdrI-LUNrQu5lZBw6jBGnrQTYCAa0FP_20u3MugjtTpFrunmfwq7Vk_jP_3nYc7CxDU89twfkWZoxLCAXlu-NQ_gL7eU_GrlzXgIMkhFazxK6D16Wq'
      },
      {
        'title': 'portfolio.work.projects.p4_title'.tr(),
        'desc': 'portfolio.work.projects.p4_desc'.tr(),
        'tag': 'Payments',
        'tech': ['Flutter', 'Firebase', 'Dart'],
        'img': 'https://lh3.googleusercontent.com/aida-public/AB6AXuAQo-N0ltweAmNz25tCdjtmPW0spYXPUF5faUyjkM81bZyiCztZ2nESIDV6dvyFYtWz-wN3pbSgGlb7sz3z6KNWTzf1pZEIqps7Qd8QFHtbBdPNkvaQk8LFqFydkOVeGRd_8B49kAsGnfLOg4ZXKJXSmJbvOeNZy_hlhM8ABYfSz10AFlRSZWg63C0QO8mExnm318o_bLLS6Vss9GQZ8fTYLWA05UvzQwibkbpp5GBSbSH6UQ7RwexdYp9VU_dc-HiyESW1CCfmDX4t'
      },
      {
        'title': 'portfolio.work.projects.p5_title'.tr(),
        'desc': 'portfolio.work.projects.p5_desc'.tr(),
        'tag': 'Enterprise',
        'tech': ['Android', 'Room DB', 'MVVM'],
        'img': 'https://lh3.googleusercontent.com/aida-public/AB6AXuDdyUUTiBZRKFkFBTC2PqPuKfxUhPABEuBc6ZDoRxqhD6flWl1NpjpzjPaoGZytfow3mCkW2aTysVZ5YvrghZL-D2htApFmcgUC0_zyChRwoACKKuyYAKOn4mqklZtWn7OPUacSiVV7HYoZlEM3a7CL6OymRka098xowwRXO3bd7hADVlrbBBaFo9ouUMkL8KKvnpCQTS0yjainUq5t4RRgz1JaRvQ1X4BCDT-SH9SiSKxIiIu6wV3Jo9B1aQcFZinTKU2O1P09Wu4e'
      },
      {
        'title': 'portfolio.work.projects.p6_title'.tr(),
        'desc': 'portfolio.work.projects.p6_desc'.tr(),
        'tag': 'Retail',
        'tech': ['Flutter', 'Redux', 'GraphQL'],
        'img': 'https://lh3.googleusercontent.com/aida-public/AB6AXuCg1YGR3U7SVlVW117ago34LbjB2Az6MHSHz1CCXmHvcXMu25Y_eFrSXTS1LJFVxtliD0OlJdWOFLsaoZd0JnMFWTZOmauJj03HnFOqP4dptxorbWxh69segtyqGDCOt2K1taBEWNvMDKgehMNbIENlKyFABV1RigeYzjKhDLqndN4MgFX0DLrp2mpYMOL1mCKzUbRkLATYvxLWvdali68vwQ8RVOOVUa4npvw17xRZXjqrqJE_OANRhBF8-glLjmcqlblVlQzEwvmW'
      },
    ];

    return Container(
      key: key,
      padding: EdgeInsets.symmetric(horizontal: padding, vertical: 72),
      constraints: const BoxConstraints(maxWidth: 1200),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'portfolio.work.subtitle'.tr().toUpperCase(),
            style: context.textTheme.labelMedium?.copyWith(
              color: context.colors.tertiary,
              fontWeight: FontWeight.bold,
              letterSpacing: 2,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            'portfolio.work.title'.tr(),
            style: context.textTheme.headlineMedium?.copyWith(
              fontWeight: FontWeight.bold,
              color: context.colors.onSurface,
            ),
          ),
          const SizedBox(height: 48),
          // Project grid
          GridView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: projects.length,
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: isMobile ? 1 : 3,
              crossAxisSpacing: 24,
              mainAxisSpacing: 24,
              childAspectRatio: isMobile ? 1.0 : 0.85,
            ),
            itemBuilder: (context, index) {
              final project = projects[index];
              final techStack = project['tech'] as List<String>;
              return GlassCard(
                padding: EdgeInsets.zero,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Image banner with Tag overlay
                    Expanded(
                      flex: 5,
                      child: Stack(
                        fit: StackFit.expand,
                        children: [
                          CachedNetworkImage(
                            imageUrl: project['img'] as String,
                            fit: BoxFit.cover,
                            placeholder: (context, url) => ColoredBox(
                              color: context.colors.surfaceContainerHighest,
                              child: const Center(
                                child: CircularProgressIndicator(strokeWidth: 2),
                              ),
                            ),
                            errorWidget: (context, url, error) => ColoredBox(
                              color: context.colors.surfaceContainerHighest,
                              child: const Center(
                                child: Icon(Icons.image_not_supported_outlined, size: 40),
                              ),
                            ),
                          ),
                          // Transparent dark overlay
                          Container(
                            color: Colors.black.withValues(alpha: 0.3),
                          ),
                          // Category Tag overlay
                          Positioned(
                            top: 16,
                            left: 16,
                            child: Container(
                              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                              decoration: BoxDecoration(
                                color: context.colors.primary.withValues(alpha: 0.2),
                                borderRadius: AppBorders.full,
                                border: Border.all(
                                  color: context.colors.primary.withValues(alpha: 0.3),
                                ),
                              ),
                              child: Text(
                                project['tag'] as String,
                                style: context.textTheme.labelSmall?.copyWith(
                                  color: context.colors.primary,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    // Project info details
                    Expanded(
                      flex: 5,
                      child: Padding(
                        padding: const EdgeInsets.all(20),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              project['title'] as String,
                              style: context.textTheme.titleMedium?.copyWith(
                                fontWeight: FontWeight.bold,
                                color: context.colors.onSurface,
                              ),
                            ),
                            const SizedBox(height: 8),
                            Expanded(
                              child: Text(
                                project['desc'] as String,
                                maxLines: 2,
                                overflow: TextOverflow.ellipsis,
                                style: context.textTheme.bodySmall?.copyWith(
                                  color: context.colors.onSurfaceVariant,
                                  height: 1.4,
                                ),
                              ),
                            ),
                            const SizedBox(height: 12),
                            // Tag badges
                            Wrap(
                              spacing: 6,
                              runSpacing: 6,
                              children: techStack.map((tech) {
                                return Container(
                                  padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                                  decoration: BoxDecoration(
                                    color: Colors.white.withValues(alpha: 0.05),
                                    borderRadius: AppBorders.xs,
                                  ),
                                  child: Text(
                                    tech,
                                    style: AppTextStyles.chipText.copyWith(
                                      fontSize: 10,
                                      color: const Color(0xFFC3C6D7),
                                    ),
                                  ),
                                );
                              }).toList(),
                            ),
                          ],
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
    );
  }

  // 6. EXPERIENCE SECTION
  Widget _buildExperienceSection(BuildContext context, GlobalKey key, bool isMobile) {
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
      key: key,
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

  // 7. CTA SECTION
  Widget _buildCTASection(BuildContext context, bool isMobile) {
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
                  onPressed: () => _showHireMeDialog(context),
                  variant: ButtonVariant.primary,
                  height: ButtonSize.large,
                ),
                AppButton(
                  label: 'shared.schedule_call'.tr(),
                  onPressed: () => _launchUrlHelper('mailto:pujit.somaiya@gmail.com?subject=Schedule%20a%20Call'),
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

  // 8. FOOTER SECTION
  Widget _buildFooterSection(BuildContext context, bool isMobile) {
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
                  'Pujit Somaiya',
                  style: context.textTheme.titleMedium?.copyWith(
                    fontWeight: FontWeight.bold,
                    color: context.colors.onSurface,
                  ),
                ),
                const SizedBox(height: 16),
                _buildSocialLinks(context),
                const SizedBox(height: 24),
                Text(
                  'portfolio.footer.copyright'.tr(),
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
                          'Pujit Somaiya',
                          style: context.textTheme.titleMedium?.copyWith(
                            fontWeight: FontWeight.bold,
                            color: context.colors.onSurface,
                          ),
                        ),
                        const SizedBox(height: 8),
                        Text(
                          'portfolio.footer.copyright'.tr(),
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
          onPressed: () => _launchUrlHelper('mailto:pujit.somaiya@gmail.com'),
        ),
        IconButton(
          icon: const Icon(Icons.terminal_rounded),
          color: context.colors.onSurfaceVariant,
          onPressed: () => _launchUrlHelper('https://www.linkedin.com/in/pujitsomaiya'),
        ),
        IconButton(
          icon: const Icon(Icons.code_rounded),
          color: context.colors.onSurfaceVariant,
          onPressed: () => _launchUrlHelper('https://github.com'),
        ),
      ],
    );
  }
}

// Custom Premium widgets support

class GradientText extends StatelessWidget {
  final String text;
  final TextStyle? style;
  final Gradient gradient;

  const GradientText(
    this.text, {
    super.key,
    required this.gradient,
    this.style,
  });

  @override
  Widget build(BuildContext context) {
    return ShaderMask(
      shaderCallback: (bounds) => gradient.createShader(
        Rect.fromLTWH(0, 0, bounds.width, bounds.height),
      ),
      child: Text(
        text,
        style: style?.copyWith(color: Colors.white),
      ),
    );
  }
}

class GlassCard extends StatefulWidget {
  final Widget child;
  final double? width;
  final double? height;
  final EdgeInsetsGeometry? padding;
  final VoidCallback? onTap;

  const GlassCard({
    super.key,
    required this.child,
    this.width,
    this.height,
    this.padding,
    this.onTap,
  });

  @override
  State<GlassCard> createState() => _GlassCardState();
}

class _GlassCardState extends State<GlassCard> {
  bool isHovered = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) => setState(() => isHovered = true),
      onExit: (_) => setState(() => isHovered = false),
      child: AnimatedScale(
        scale: isHovered ? 1.02 : 1.0,
        duration: const Duration(milliseconds: 200),
        curve: Curves.easeOut,
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 200),
          width: widget.width,
          height: widget.height,
          decoration: BoxDecoration(
            color: isHovered
                ? Colors.white.withValues(alpha: 0.05)
                : Colors.white.withValues(alpha: 0.03),
            borderRadius: AppBorders.card,
            border: Border.all(
              color: isHovered
                  ? context.colors.primary.withValues(alpha: 0.3)
                  : context.colors.outline.withValues(alpha: 0.15),
              width: 1.5,
            ),
            boxShadow: isHovered
                ? [
                    BoxShadow(
                      color: context.colors.primary.withValues(alpha: 0.2),
                      blurRadius: 30,
                      spreadRadius: 0,
                    )
                  ]
                : [],
          ),
          child: ClipRRect(
            borderRadius: AppBorders.card,
            child: BackdropFilter(
              filter: ImageFilter.blur(sigmaX: 12, sigmaY: 12),
              child: Padding(
                padding: widget.padding ?? const EdgeInsets.all(24),
                child: widget.child,
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class GreenPulseDot extends StatefulWidget {
  const GreenPulseDot({super.key});

  @override
  State<GreenPulseDot> createState() => _GreenPulseDotState();
}

class _GreenPulseDotState extends State<GreenPulseDot>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 1200),
      vsync: this,
    )..repeat(reverse: true);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _controller,
      builder: (context, child) {
        return Container(
          width: 8,
          height: 8,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: const Color(0xFF4FDBC8),
            boxShadow: [
              BoxShadow(
                color: const Color(0xFF4FDBC8).withValues(alpha: 0.2 + 0.6 * _controller.value),
                blurRadius: 4 + 6 * _controller.value,
                spreadRadius: 2 * _controller.value,
              ),
            ],
          ),
        );
      },
    );
  }
}
