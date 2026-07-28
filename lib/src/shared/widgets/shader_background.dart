import 'dart:ui';
import 'package:flutter/scheduler.dart';
import 'package:pujit_portfolio/src/imports/imports.dart';

class ShaderBackground extends StatefulWidget {
  final Widget child;

  const ShaderBackground({
    super.key,
    required this.child,
  });

  @override
  State<ShaderBackground> createState() => _ShaderBackgroundState();
}

class _ShaderBackgroundState extends State<ShaderBackground> with SingleTickerProviderStateMixin {
  FragmentShader? _shader;
  late Ticker _ticker;
  double _time = 0;
  Offset _mousePosition = Offset.zero;


  @override
  void initState() {
    super.initState();
    _loadShader();
    _ticker = createTicker((elapsed) {
      if (_shader != null) {
        setState(() {
          _time = elapsed.inMilliseconds / 1000.0;
        });
      }
    });
    _ticker.start();
  }

  Future<void> _loadShader() async {
    try {
      final program = await FragmentProgram.fromAsset('shaders/background.frag');
      setState(() {
        _shader = program.fragmentShader();
      });
    } catch (e) {
      debugPrint('Error loading shader: $e');
    }
  }

  @override
  void dispose() {
    _ticker.dispose();
    _shader?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final shader = _shader;
    return MouseRegion(
      onHover: (event) {
        setState(() {
          _mousePosition = event.localPosition;
        });
      },
      child: Stack(
        fit: StackFit.expand,
        children: [
          if (shader != null)
            CustomPaint(
              painter: ShaderPainter(
                shader: shader,
                time: _time,
                mousePosition: _mousePosition,
              ),
            )
          else
            // Fallback background color matching the shader base color
            Container(color: AppColors.shaderBg),
          widget.child,
        ],
      ),
    );
  }
}

class ShaderPainter extends CustomPainter {
  final FragmentShader shader;
  final double time;
  final Offset mousePosition;

  ShaderPainter({
    required this.shader,
    required this.time,
    required this.mousePosition,
  });

  @override
  void paint(Canvas canvas, Size size) {
    shader.setFloat(0, time);
    shader.setFloat(1, size.width);
    shader.setFloat(2, size.height);
    shader.setFloat(3, mousePosition.dx);
    shader.setFloat(4, mousePosition.dy);

    final paint = Paint()..shader = shader;
    canvas.drawRect(Offset.zero & size, paint);
  }

  @override
  bool shouldRepaint(covariant ShaderPainter oldDelegate) {
    return oldDelegate.time != time || oldDelegate.mousePosition != mousePosition;
  }
}
