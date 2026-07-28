import 'package:pujit_portfolio/src/imports/imports.dart';

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
            color: AppColors.pulseDot,
            boxShadow: [
              BoxShadow(
                color: AppColors.pulseDot.withValues(alpha: 0.2 + 0.6 * _controller.value),
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
