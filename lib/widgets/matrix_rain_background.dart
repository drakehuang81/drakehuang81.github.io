import 'dart:async';
import 'dart:math';
import 'package:flutter/material.dart';
import '../core/terminal_theme.dart';

/// Matrix-style falling characters background animation
class MatrixRainBackground extends StatefulWidget {
  final Widget child;
  final double opacity;

  const MatrixRainBackground({
    super.key,
    required this.child,
    this.opacity = 0.15,
  });

  @override
  State<MatrixRainBackground> createState() => _MatrixRainBackgroundState();
}

class _MatrixRainBackgroundState extends State<MatrixRainBackground>
    with SingleTickerProviderStateMixin {
  late Timer _timer;
  final List<_MatrixColumn> _columns = [];
  final Random _random = Random();
  Size _size = Size.zero;

  // Characters to use in the rain
  static const String _chars =
      'アイウエオカキクケコサシスセソタチツテトナニヌネノハヒフヘホマミムメモヤユヨラリルレロワヲン0123456789ABCDEFGHIJKLMNOPQRSTUVWXYZ';

  @override
  void initState() {
    super.initState();
    _timer = Timer.periodic(const Duration(milliseconds: 50), _update);
  }

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }

  void _initColumns(Size size) {
    if (_size == size) return;
    _size = size;
    _columns.clear();

    const columnWidth = 20.0;
    final columnCount = (size.width / columnWidth).ceil();

    for (int i = 0; i < columnCount; i++) {
      _columns.add(
        _MatrixColumn(
          x: i * columnWidth,
          speed: 2 + _random.nextDouble() * 4,
          length: 5 + _random.nextInt(15),
          y: -_random.nextDouble() * size.height,
        ),
      );
    }
  }

  void _update(Timer timer) {
    if (!mounted || _size.isEmpty) return;

    setState(() {
      for (var column in _columns) {
        column.y += column.speed;
        if (column.y > _size.height + column.length * 20) {
          column.y = -column.length * 20;
          column.speed = 2 + _random.nextDouble() * 4;
          column.length = 5 + _random.nextInt(15);
        }
      }
    });
  }

  String _randomChar() {
    return _chars[_random.nextInt(_chars.length)];
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final size = Size(constraints.maxWidth, constraints.maxHeight);
        _initColumns(size);

        return Stack(
          children: [
            // Background gradient
            Container(
              decoration: const BoxDecoration(
                gradient: RadialGradient(
                  center: Alignment.center,
                  radius: 1.5,
                  colors: [
                    TerminalTheme.background,
                    TerminalTheme.backgroundDark,
                  ],
                ),
              ),
            ),
            // Matrix rain
            Opacity(
              opacity: widget.opacity,
              child: CustomPaint(
                size: size,
                painter: _MatrixPainter(
                  columns: _columns,
                  randomChar: _randomChar,
                ),
              ),
            ),
            // Content
            widget.child,
          ],
        );
      },
    );
  }
}

class _MatrixColumn {
  double x;
  double y;
  double speed;
  int length;

  _MatrixColumn({
    required this.x,
    required this.y,
    required this.speed,
    required this.length,
  });
}

class _MatrixPainter extends CustomPainter {
  final List<_MatrixColumn> columns;
  final String Function() randomChar;

  _MatrixPainter({required this.columns, required this.randomChar});

  @override
  void paint(Canvas canvas, Size size) {
    for (var column in columns) {
      for (int i = 0; i < column.length; i++) {
        final y = column.y - i * 20;
        if (y < -20 || y > size.height + 20) continue;

        // Fade from bright to dark
        final opacity = 1.0 - (i / column.length);
        final color = TerminalTheme.terminalGreen.withValues(alpha: opacity);

        final textPainter = TextPainter(
          text: TextSpan(
            text: randomChar(),
            style: TextStyle(
              fontSize: 14,
              fontFamily: 'monospace',
              color: color,
            ),
          ),
          textDirection: TextDirection.ltr,
        );

        textPainter.layout();
        textPainter.paint(canvas, Offset(column.x, y));
      }
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;
}
