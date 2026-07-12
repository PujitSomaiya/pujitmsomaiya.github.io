import 'package:pujit_portfolio/src/imports/imports.dart';

class ProfileImage extends StatelessWidget {
  const ProfileImage({super.key});

  @override
  Widget build(BuildContext context) {
    Widget errorWidget() {
      return ColoredBox(
        color: context.colors.surfaceContainerHighest,
        child: Center(
          child: Icon(
            Icons.person_outline_rounded,
            size: 80,
            color: context.colors.primary,
          ),
        ),
      );
    }

    if (kIsWeb) {
      return Image.network(
        BrandLinks.profileImage,
        width: double.infinity,
        height: double.infinity,
        fit: BoxFit.cover,
        webHtmlElementStrategy: WebHtmlElementStrategy.prefer,
        loadingBuilder: (context, child, loadingProgress) {
          if (loadingProgress == null) {
            return child;
          }

          return ColoredBox(
            color: context.colors.surfaceContainerHighest,
            child: const Center(
              child: CircularProgressIndicator(strokeWidth: 2),
            ),
          );
        },
        errorBuilder: (context, error, stackTrace) {
          debugPrint('Web image loading error: $error');
          return errorWidget();
        },
      );
    }

    return CachedNetworkImage(
      imageUrl: BrandLinks.profileImage,
      width: double.infinity,
      height: double.infinity,
      fit: BoxFit.cover,
      placeholder: (context, url) {
        return ColoredBox(
          color: context.colors.surfaceContainerHighest,
          child: const Center(
            child: CircularProgressIndicator(strokeWidth: 2),
          ),
        );
      },
      errorWidget: (context, url, error) {
        debugPrint('Mobile image loading error: $error');
        return errorWidget();
      },
    );
  }
}
