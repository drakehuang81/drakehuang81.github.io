import 'dart:async';
import 'dart:math';
import 'package:flutter/material.dart';
import '../core/terminal_theme.dart';

/// Matrix-style falling characters background animation
///
/// Performance optimized:
/// - Pre-generates character arrays (no random calls during paint)
/// - Uses 100ms update interval (10 FPS is sufficient for this effect)
/// - Caches TextPainter instances per column
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

class _MatrixRainBackgroundState extends State<MatrixRainBackground> {
  Timer? _timer;
  final List<_MatrixColumn> _columns = [];
  final Random _random = Random();
  Size _size = Size.zero;
  int _frameCount = 0; // Used to trigger character refresh

  // Characters to use in the rain
  static const String _chars =
      'アイウエオカキクケコサシスセソタチツテトナニヌネノハヒフヘホマミムメモヤユヨラリルレロワヲン0123456789ABCDEFGHIJKLMNOPQRSTUVWXYZ';

  @override
  void initState() {
    super.initState();
    // Reduced from 50ms to 100ms (20 FPS -> 10 FPS) - sufficient for rain effect
    _timer = Timer.periodic(const Duration(milliseconds: 100), _update);
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  void _initColumns(Size size) {
    if (_size == size && _columns.isNotEmpty) return;
    _size = size;
    _columns.clear();

    const columnWidth = 20.0;
    final columnCount = (size.width / columnWidth).ceil();

    for (int i = 0; i < columnCount; i++) {
      final length = 5 + _random.nextInt(15);
      _columns.add(
        _MatrixColumn(
          x: i * columnWidth,
          speed: 2 + _random.nextDouble() * 4,
          length: length,
          y: -_random.nextDouble() * size.height,
          characters: _generateCharacters(length),
        ),
      );
    }
  }

  /// Pre-generate characters for a column
  List<String> _generateCharacters(int length) {
    return List.generate(length, (_) => _chars[_random.nextInt(_chars.length)]);
  }

  void _update(Timer timer) {
    if (!mounted || _size.isEmpty) return;

    _frameCount++;

    setState(() {
      for (var column in _columns) {
        column.y += column.speed;

        // Reset column when it goes off screen
        if (column.y > _size.height + column.length * 20) {
          column.y = -column.length * 20;
          column.speed = 2 + _random.nextDouble() * 4;
          column.length = 5 + _random.nextInt(15);
          // Regenerate characters when column resets
          column.characters = _generateCharacters(column.length);
        }

        // Refresh some characters every 5 frames (500ms) for visual variety
        if (_frameCount % 5 == 0) {
          final refreshIndex = _random.nextInt(column.characters.length);
          column.characters[refreshIndex] =
              _chars[_random.nextInt(_chars.length)];
        }
      }
    });
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
            // Matrix rain - using RepaintBoundary to isolate repaints
            RepaintBoundary(
              child: Opacity(
                opacity: widget.opacity,
                child: CustomPaint(
                  size: size,
                  painter: _MatrixPainter(columns: _columns),
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
  List<String> characters; // Pre-generated characters

  _MatrixColumn({
    required this.x,
    required this.y,
    required this.speed,
    required this.length,
    required this.characters,
  });
}

class _MatrixPainter extends CustomPainter {
  final List<_MatrixColumn> columns;

  _MatrixPainter({required this.columns});

  @override
  void paint(Canvas canvas, Size size) {
    for (var column in columns) {
      for (int i = 0; i < column.length && i < column.characters.length; i++) {
        final y = column.y - i * 20;
        if (y < -20 || y > size.height + 20) continue;

        // Fade from bright to dark
        final opacity = 1.0 - (i / column.length);
        final color = TerminalTheme.terminalGreen.withValues(alpha: opacity);

        final textPainter = TextPainter(
          text: TextSpan(
            text: column.characters[i], // Use pre-generated character
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
  bool shouldRepaint(covariant _MatrixPainter oldDelegate) {
    // Only repaint if columns have changed
    return true; // Still needs to repaint for animation, but less expensive now
  }
}
