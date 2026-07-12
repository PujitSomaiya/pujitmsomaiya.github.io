import 'package:pujit_portfolio/src/imports/imports.dart';
import 'hire_me_dialog.dart';

void showMobileMenu(BuildContext context, List<GlobalKey> keys) {
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
                showHireMeDialog(context);
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
