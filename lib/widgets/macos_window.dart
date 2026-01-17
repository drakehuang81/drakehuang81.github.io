import 'package:flutter/material.dart';
import '../core/terminal_theme.dart';

class MacOSWindow extends StatelessWidget {
  final Widget child;
  final String title;

  final VoidCallback? onMaximize;
  final VoidCallback? onClose;

  const MacOSWindow({
    super.key,
    required this.child,
    this.title = 'user@drakehuang: ~',
    this.onMaximize,
    this.onClose,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: const Color(
          0xFF1E1E1E,
        ).withValues(alpha: 0.95), // Dark window bg
        borderRadius: BorderRadius.circular(10),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.5),
            offset: const Offset(0, 10),
            blurRadius: 30,
            spreadRadius: 5,
          ),
        ],
        border: Border.all(
          color: Colors.white.withValues(alpha: 0.1),
          width: 0.5,
        ),
      ),
      child: Column(
        children: [
          // Title Bar
          Container(
            height: 28,
            decoration: const BoxDecoration(
              color: Color(0xFF2D2D2D), // Title bar color
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(10),
                topRight: Radius.circular(10),
              ),
            ),
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: GestureDetector(
              onDoubleTap: onMaximize,
              behavior: HitTestBehavior.translucent,
              child: Stack(
                children: [
                  // Window Controls
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        // Close button (red)
                        GestureDetector(
                          onTap: onClose,
                          behavior: HitTestBehavior.opaque,
                          child: _buildWindowControl(const Color(0xFFFF5F57)),
                        ),
                        const SizedBox(width: 8),
                        // maximize button (green)
                        GestureDetector(
                          onTap: onMaximize,
                          behavior: HitTestBehavior.opaque,
                          child: _buildWindowControl(const Color(0xFF28C940)),
                        ), // Green
                      ],
                    ),
                  ),
                  // Title
                  Align(
                    alignment: Alignment.center,
                    child: Text(
                      title,
                      style: TerminalTheme.bodyMedium.copyWith(
                        color: Colors.white.withValues(alpha: 0.8),
                        fontSize: 13,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          // Content Area
          Expanded(
            child: ClipRRect(
              borderRadius: const BorderRadius.only(
                bottomLeft: Radius.circular(10),
                bottomRight: Radius.circular(10),
              ),
              child: child,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildWindowControl(Color color) {
    return Container(
      width: 12,
      height: 12,
      decoration: BoxDecoration(color: color, shape: BoxShape.circle),
    );
  }
}
