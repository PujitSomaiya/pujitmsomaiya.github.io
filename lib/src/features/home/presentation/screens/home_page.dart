import 'dart:async';
import 'dart:ui';
import 'package:pujit_portfolio/src/imports/imports.dart';
import '../widgets/widgets.dart';

class HomePage extends HookWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    final scrollController = useScrollController();
    final activeSectionIndex = useState(0);

    // Simulated Booting Loader states
    final isBooting = useState(true);
    final bootProgress = useState(0);

    // Section keys
    final homeKey = useMemoized(() => GlobalKey());
    final servicesKey = useMemoized(() => GlobalKey());
    final skillsKey = useMemoized(() => GlobalKey());
    final workKey = useMemoized(() => GlobalKey());
    final experienceKey = useMemoized(() => GlobalKey());
    final contactKey = useMemoized(() => GlobalKey());

    final screenWidth = context.width;
    final isMobile = screenWidth < 768; // standard DESIGN.md mobile breakpoint

    // Loading screen timer simulation (Desktop only)
    useEffect(() {
      if (isMobile) {
        isBooting.value = false;
        return null;
      }

      final timer = Timer.periodic(const Duration(milliseconds: 30), (t) {
        final current = bootProgress.value;
        if (current >= 100) {
          t.cancel();
          Future.delayed(const Duration(milliseconds: 400), () {
            isBooting.value = false;
          });
        } else {
          bootProgress.value = (current + 4).clamp(0, 100);
        }
      });

      return timer.cancel;
    }, []);

    // Web section map for Navigation (5 sections)
    final webKeys = useMemoized(() => [
      homeKey,
      skillsKey,
      experienceKey,
      workKey,
      contactKey,
    ]);

    // Mobile section map for Navigation (4 tabs: PROFILE, LOGS, MISSIONS, ARSENAL)
    final mobileKeys = useMemoized(() => [
      homeKey,
      experienceKey,
      workKey,
      skillsKey,
    ]);

    final keys = isMobile ? mobileKeys : webKeys;

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
    }, [scrollController, keys]);

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

    // Loader HUD overlay screen
    if (isBooting.value) {
      return Scaffold(
        backgroundColor: AppColors.voidBlack,
        body: Center(
          child: Container(
            constraints: const BoxConstraints(maxWidth: 550),
            padding: const EdgeInsets.symmetric(horizontal: 32),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'cyberpunk.initializing'.tr(),
                      style: AppTextStyles.bodySmall.copyWith(
                        color: context.colors.primaryContainer,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      '${bootProgress.value}%',
                      style: AppTextStyles.bodySmall.copyWith(
                        color: context.colors.primaryContainer,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 16),
                Container(
                  height: 4,
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color: context.colors.surfaceContainerHigh,
                    borderRadius: AppBorders.xs,
                  ),
                  alignment: Alignment.centerLeft,
                  child: FractionallySizedBox(
                    widthFactor: bootProgress.value / 100,
                    child: Container(
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          colors: [
                            context.colors.primaryContainer,
                            context.colors.secondary,
                          ],
                        ),
                        borderRadius: AppBorders.xs,
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 24),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                      decoration: BoxDecoration(
                        border: Border.all(color: context.colors.tertiary),
                        borderRadius: AppBorders.xs,
                      ),
                      child: Text(
                        'cyberpunk.tip'.tr(),
                        style: AppTextStyles.bodySmall.copyWith(
                          color: context.colors.tertiary,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: Text(
                        'cyberpunk.boot_tip'.tr(),
                        style: AppTextStyles.bodySmall.copyWith(
                          color: context.colors.onSurfaceVariant.withValues(alpha: 0.7),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      );
    }

    return Scaffold(
      backgroundColor: Colors.transparent,
      body: Stack(
        children: [
          // Scrollable Body
          Scrollbar(
            controller: scrollController,
            child: SingleChildScrollView(
              controller: scrollController,
              child: Column(
                children: [
                  const SizedBox(height: 80),

                  // Hero section (PROFILE)
                  HeroSection(
                    key: homeKey,
                    isMobile: isMobile,
                  ),

                  // Tech Stack section (ARSENAL)
                  TechStackSection(
                    key: skillsKey,
                    isMobile: isMobile,
                  ),

                  // Services section (MISSION_SOLUTIONS)
                  ServicesSection(
                    key: servicesKey,
                    isMobile: isMobile,
                    screenWidth: screenWidth,
                  ),

                  // Experience section (LOGS / CAREER_PATH)
                  ExperienceSection(
                    key: experienceKey,
                    isMobile: isMobile,
                  ),

                  // Work section (ARCHIVE / PROJECT_ARCHIVES)
                  WorkSection(
                    key: workKey,
                    isMobile: isMobile,
                  ),

                  // On Web: Render CTA section (LINK)
                  if (!isMobile)
                    CTASection(
                      key: contactKey,
                      isMobile: isMobile,
                    ),

                  // Footer Section
                  FooterSection(
                    isMobile: isMobile,
                  ),
                ],
              ),
            ),
          ),

          // Animated Scanline sweep overlay (Always present as per specs)
          const Positioned.fill(
            child: IgnorePointer(
              child: ScanlineOverlay(),
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
                color: context.colors.surface.withValues(alpha: 0.8),
                border: Border(
                  bottom: BorderSide(
                    color: context.colors.outlineVariant.withValues(alpha: 0.3),
                    width: 1,
                  ),
                ),
              ),
              child: ClipRect(
                child: BackdropFilter(
                  filter: ImageFilter.blur(sigmaX: 20, sigmaY: 20),
                  child: Padding(
                    padding: EdgeInsets.symmetric(
                      horizontal: isMobile ? 24 : 48,
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        // Name logo (Styled HUD title)
                        Text(
                          isMobile ? 'cyberpunk.operator_v2_0'.tr() : 'cyberpunk.somaiya_v3_0'.tr(),
                          style: context.textTheme.headlineSmall?.copyWith(
                            fontWeight: FontWeight.w800,
                            color: context.colors.primaryContainer,
                            letterSpacing: -1,
                            shadows: [
                              Shadow(
                                color: context.colors.primaryContainer.withValues(alpha: 0.6),
                                blurRadius: 8,
                              )
                            ],
                          ),
                        ),

                        // Menu tabs (Web/Desktop Navigation)
                        if (!isMobile)
                          Row(
                            children: List.generate(5, (index) {
                              final label = switch (index) {
                                0 => 'cyberpunk.nav_profile'.tr(),
                                1 => 'cyberpunk.nav_arsenal'.tr(),
                                2 => 'cyberpunk.nav_logs'.tr(),
                                3 => 'cyberpunk.nav_archive'.tr(),
                                _ => 'cyberpunk.nav_link'.tr(),
                              };
                              final key = keys[index];
                              final isActive = activeSectionIndex.value == index;
                              return InkWell(
                                onTap: () => scrollToSection(key),
                                child: Container(
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: 20,
                                    vertical: 8,
                                  ),
                                  margin: const EdgeInsets.symmetric(horizontal: 4),
                                  decoration: BoxDecoration(
                                    border: Border(
                                      bottom: BorderSide(
                                        color: isActive
                                            ? context.colors.primaryContainer
                                            : Colors.transparent,
                                        width: 2,
                                      ),
                                    ),
                                  ),
                                  child: Text(
                                    label,
                                    style: AppTextStyles.navText.copyWith(
                                      color: isActive
                                          ? context.colors.primaryContainer
                                          : context.colors.onSurfaceVariant,
                                    ),
                                  ),
                                ),
                              );
                            }),
                          ),

                        // Actions
                        Row(
                          children: [
                            if (!isMobile) ...[
                              IconButton(
                                icon: Icon(
                                  Icons.terminal,
                                  color: context.colors.onSurfaceVariant,
                                ),
                                onPressed: () {},
                              ),
                              const SizedBox(width: 8),
                              AppButton(
                                label: 'shared.view_cv'.tr().toUpperCase(),
                                onPressed: () => launchUrl(Uri.parse(BrandLinks.resume), mode: LaunchMode.externalApplication),
                                variant: ButtonVariant.primary,
                                height: ButtonSize.small,
                              ),
                            ],
                            if (isMobile) ...[
                              IconButton(
                                icon: Icon(
                                  Icons.terminal_rounded,
                                  color: context.colors.onSurfaceVariant,
                                  size: 20,
                                ),
                                onPressed: () => showHireMeDialog(context),
                              ),
                              IconButton(
                                icon: Icon(
                                  Icons.settings_input_component_rounded,
                                  color: context.colors.onSurfaceVariant,
                                  size: 20,
                                ),
                                onPressed: () {},
                              ),
                            ],
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),

          // Floating Pill Bottom Navigation Bar (Mobile only)
          if (isMobile)
            Positioned(
              bottom: 24,
              left: 0,
              right: 0,
              child: Center(
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                  decoration: BoxDecoration(
                    color: context.colors.surface.withValues(alpha: 0.7),
                    borderRadius: BorderRadius.circular(30),
                    border: Border.all(
                      color: context.colors.outlineVariant.withValues(alpha: 0.2),
                    ),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withValues(alpha: 0.4),
                        blurRadius: 20,
                      )
                    ],
                  ),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(24),
                    child: BackdropFilter(
                      filter: ImageFilter.blur(sigmaX: 12, sigmaY: 12),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          _buildMobileTabIcon(context, 0, Icons.grid_view_rounded, homeKey, activeSectionIndex.value, scrollToSection),
                          const SizedBox(width: 12),
                          _buildMobileTabIcon(context, 1, Icons.dns_rounded, experienceKey, activeSectionIndex.value, scrollToSection),
                          const SizedBox(width: 12),
                          _buildMobileTabIcon(context, 2, Icons.legend_toggle_rounded, workKey, activeSectionIndex.value, scrollToSection),
                          const SizedBox(width: 12),
                          _buildMobileTabIcon(context, 3, Icons.shield_rounded, skillsKey, activeSectionIndex.value, scrollToSection),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ),

          // Terminal Floating Action Button (Mobile only)
          if (isMobile)
            Positioned(
              bottom: 96,
              right: 24,
              child: FloatingActionButton(
                backgroundColor: context.colors.primaryContainer,
                foregroundColor: AppColors.voidBlack,
                shape: const CircleBorder(),
                elevation: 6,
                onPressed: () => showHireMeDialog(context),
                child: const Icon(Icons.terminal_rounded),
              ),
            ),
        ],
      ),
    );
  }

  Widget _buildMobileTabIcon(
    BuildContext context,
    int index,
    IconData icon,
    GlobalKey targetKey,
    int activeIndex,
    void Function(GlobalKey) onTap,
  ) {
    final isActive = activeIndex == index;
    return InkWell(
      onTap: () => onTap(targetKey),
      borderRadius: BorderRadius.circular(20),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        padding: const EdgeInsets.all(8),
        decoration: BoxDecoration(
          color: isActive
              ? context.colors.secondaryContainer.withValues(alpha: 0.2)
              : Colors.transparent,
          borderRadius: BorderRadius.circular(20),
          border: Border.all(
            color: isActive
                ? context.colors.secondary.withValues(alpha: 0.4)
                : Colors.transparent,
          ),
        ),
        child: Icon(
          icon,
          color: isActive ? context.colors.secondary : context.colors.onSurfaceVariant,
          size: 20,
        ),
      ),
    );
  }
}

class ScanlineOverlay extends StatefulWidget {
  const ScanlineOverlay({super.key});

  @override
  State<ScanlineOverlay> createState() => _ScanlineOverlayState();
}

class _ScanlineOverlayState extends State<ScanlineOverlay> with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 8),
    )..repeat();
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
        return Align(
          alignment: Alignment(0, -1.0 + (_controller.value * 2.0)),
          child: IgnorePointer(
            child: Container(
              width: double.infinity,
              height: 120,
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                    Colors.transparent,
                    AppColors.neonPurple.withValues(alpha: 0.04),
                    Colors.transparent,
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}