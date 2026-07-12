import 'dart:ui';
import 'package:pujit_portfolio/src/imports/imports.dart';

Future<void> launchUrlHelper(String url) async {
  final uri = Uri.parse(url);
  if (await canLaunchUrl(uri)) {
    await launchUrl(uri, mode: LaunchMode.externalApplication);
  }
}

void showHireMeDialog(BuildContext context) {
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
                  launchUrlHelper(BrandLinks.mailtoContact);
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
                  launchUrlHelper(BrandLinks.linkedin);
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
