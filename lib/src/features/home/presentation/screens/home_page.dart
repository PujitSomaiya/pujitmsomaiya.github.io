import 'dart:ui';
import 'package:pujit_portfolio/src/imports/imports.dart';
import '../widgets/widgets.dart';

class HomePage extends HookWidget {
  const HomePage({super.key});

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
                  // Spacer for sticky header
                  const SizedBox(height: 100),

                  // Hero section
                  HeroSection(
                    key: homeKey,
                    isMobile: isMobile,
                  ),

                  // About section
                  AboutSection(
                    key: aboutKey,
                    isMobile: isMobile,
                  ),

                  // Services section
                  ServicesSection(
                    key: servicesKey,
                    isMobile: isMobile,
                    screenWidth: screenWidth,
                  ),

                  // Tech Stack section
                  TechStackSection(
                    key: skillsKey,
                    isMobile: isMobile,
                  ),

                  // Work section
                  WorkSection(
                    key: workKey,
                    isMobile: isMobile,
                  ),

                  // Experience section
                  ExperienceSection(
                    key: experienceKey,
                    isMobile: isMobile,
                  ),

                  // CTA Section
                  CTASection(
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
                          'shared.brand_name'.tr(),
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
                                onPressed: () => showHireMeDialog(context),
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
                                onPressed: () => showMobileMenu(context, keys),
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
}