import '../../imports/imports.dart';

/// A fully themed button supporting all [ButtonVariant]s and [ButtonSize]s.
///
/// Usage:
/// ```dart
/// AppButton(
///   label: 'Save',
///   onPressed: _save,
///   variant: ButtonVariant.primary,
///   size: ButtonSize.large,
///   isLoading: state.isLoading,
/// )
/// ```
class AppButton extends StatelessWidget {
  const AppButton({
    super.key,
    required this.label,
    this.onPressed,
    this.variant = ButtonVariant.primary,
    this.color,
    this.textColor,
    this.height = ButtonSize.medium,
    this.width,
    this.isLoading = false,
    this.isFullWidth = false,
    this.prefixIcon,
    this.suffixIcon,
  });

  final String label;
  final VoidCallback? onPressed;
  final ButtonVariant variant;
  final Color? color;
  final Color? textColor;
  final ButtonSize height;
  final ButtonSize? width;
  final bool isLoading;
  final bool isFullWidth;
  final Widget? prefixIcon;
  final Widget? suffixIcon;

  @override
  Widget build(BuildContext context) {
    final cs = context.theme.colorScheme;
    final appColors = context.theme.extension<AppColorsExtension>()!;
    final isDisabled = onPressed == null || isLoading;
    final isMobile = context.width < 900;

    final double buttonHeight = switch (height) {
      ButtonSize.small  => isMobile ? 36.h : 36.0,
      ButtonSize.medium => isMobile ? 48.h : 48.0,
      ButtonSize.large  => isMobile ? 56.h : 56.0,
    };

    final double? buttonWidth = switch (width) {
      ButtonSize.small  => isMobile ? 100.w : 100.0,
      ButtonSize.medium => isMobile ? 150.w : 150.0,
      ButtonSize.large  => isMobile ? 200.w : 200.0,
      null              => null,
    };

    final double horizontalPadding = switch (height) {
      ButtonSize.small  => isMobile ? 12.w : 12.0,
      ButtonSize.medium => isMobile ? 20.w : 20.0,
      ButtonSize.large  => isMobile ? 28.w : 28.0,
    };

    final double fontSize = switch (height) {
      ButtonSize.small  => isMobile ? 12.sp : 12.0,
      ButtonSize.medium => isMobile ? 14.sp : 14.0,
      ButtonSize.large  => isMobile ? 16.sp : 16.0,
    };

    final (bg, fg, border) = switch (variant) {
      ButtonVariant.primary   => (color ?? cs.primary, color ?? cs.onPrimary, null),
      ButtonVariant.secondary => (cs.secondaryContainer, cs.onSecondaryContainer, null),
      ButtonVariant.outline   => (Colors.transparent, cs.primary, BorderSide(color: cs.outline, width: 1.5)),
      ButtonVariant.ghost     => (Colors.transparent, cs.primary, null),
      ButtonVariant.danger    => (cs.error, cs.onError, null),
      ButtonVariant.success   => (appColors.success, appColors.onSuccess, null),
    };

    final child = AnimatedSwitcher(
      duration: AppDurations.fast,
      switchInCurve: AppCurves.decelerate,
      child: isLoading
          ? SizedBox(
              key: const ValueKey('loader'),
              width: isMobile ? 20.w : 20.0,
              height: isMobile ? 20.h : 20.0,
              child: CircularProgressIndicator(
                strokeWidth: 2,
                color: fg,
              ),
            )
          : Row(
              key: const ValueKey('content'),
              mainAxisSize: MainAxisSize.min,
              children: [
                if (prefixIcon != null) ...[
                  prefixIcon!,
                  SizedBox(width: isMobile ? 8.w : 8.0),
                ],
                Text(
                  label,
                  style: AppTextStyles.buttonText.copyWith(
                    fontSize: fontSize,
                    color: isDisabled ?  fg.withValues(alpha: 0.5) : textColor ?? fg,
                  ),
                ),
                if (suffixIcon != null) ...[
                  SizedBox(width: isMobile ? 8.w : 8.0),
                  suffixIcon!,
                ],
              ],
            ),
    );

    return AnimatedOpacity(
      duration: AppDurations.fast,
      opacity: isDisabled ? 0.6 : 1.0,
      child: SizedBox(
        width: isFullWidth ? double.infinity : buttonWidth,
        height: buttonHeight,
        child: TextButton(
          onPressed: isDisabled ? null : onPressed,
          style: TextButton.styleFrom(
            backgroundColor: bg,
            foregroundColor: fg,
            padding: EdgeInsets.symmetric(horizontal: horizontalPadding),
            shape: border != null
                ? RoundedRectangleBorder(
                    borderRadius: AppBorders.button,
                    side: border,
                  )
                : const RoundedRectangleBorder(borderRadius: AppBorders.button),
          ),
          child: child,
        ),
      ),
    );
  }
}
