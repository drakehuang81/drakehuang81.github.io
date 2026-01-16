import 'dart:math' as math;
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../providers/navigation_provider.dart';
import '../widgets/nav_bar.dart';
import '../widgets/about_me_section.dart';
import '../widgets/resume_section.dart';
import '../widgets/contact_section.dart';
import '../widgets/matrix_rain_background.dart';
import '../widgets/macos_window.dart';

class MainPage extends ConsumerStatefulWidget {
  const MainPage({super.key});

  @override
  ConsumerState<MainPage> createState() => _MainPageState();
}

class _MainPageState extends ConsumerState<MainPage> {
  bool _isMaximized = false;
  bool _isWindowOpen = true;

  @override
  Widget build(BuildContext context) {
    final selectedIndex = ref.watch(navigationProvider);

    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              Color(0xFFFF2E63), // Pinkish
              Color(0xFF08D9D6), // Cyanish
              Color(0xFF252A34), // Dark
            ],
            stops: [0.0, 0.5, 1.0],
          ),
        ),
        child: Stack(
          children: [
            // Desktop Icons
            AnimatedOpacity(
              duration: const Duration(milliseconds: 300),
              opacity: _isWindowOpen ? 0.0 : 1.0,
              child: IgnorePointer(
                ignoring: _isWindowOpen,
                child: Center(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      GestureDetector(
                        onTap: () {
                          setState(() {
                            _isWindowOpen = true;
                            _isMaximized = false;
                          });
                        },
                        child: Column(
                          children: [
                            Container(
                              width: 64,
                              height: 64,
                              decoration: BoxDecoration(
                                color: Colors.black.withValues(alpha: 0.3),
                                borderRadius: BorderRadius.circular(12),
                                border: Border.all(
                                  color: Colors.white.withValues(alpha: 0.2),
                                  width: 1,
                                ),
                              ),
                              child: const Icon(
                                Icons.terminal,
                                color: Colors.white,
                                size: 40,
                              ),
                            ),
                            const SizedBox(height: 8),
                            Text(
                              'Resume.app',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 14,
                                shadows: [
                                  Shadow(
                                    color: Colors.black.withValues(alpha: 0.8),
                                    blurRadius: 4,
                                    offset: const Offset(0, 2),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),

            // Window with Animation
            IgnorePointer(
              ignoring: !_isWindowOpen,
              child: AnimatedOpacity(
                duration: const Duration(milliseconds: 200),
                opacity: _isWindowOpen ? 1.0 : 0.0,
                child: AnimatedScale(
                  duration: const Duration(milliseconds: 200),
                  scale: _isWindowOpen ? 1.0 : 0.8,
                  curve: Curves.easeOut,
                  child: LayoutBuilder(
                    builder: (context, constraints) {
                      final screenWidth = constraints.maxWidth;
                      final screenHeight = constraints.maxHeight;

                      final targetWidth = _isMaximized
                          ? screenWidth
                          : math.min(screenWidth - 48, 1000.0);
                      final targetHeight = _isMaximized
                          ? screenHeight
                          : math.min(screenHeight - 48, 700.0);

                      return Center(
                        child: AnimatedContainer(
                          duration: const Duration(milliseconds: 300),
                          curve: Curves.easeInOut,
                          margin: _isMaximized
                              ? EdgeInsets.zero
                              : const EdgeInsets.all(24),
                          width: targetWidth,
                          height: targetHeight,
                          child: MacOSWindow(
                            title: _getWindowTitle(selectedIndex),
                            onMaximize: () {
                              setState(() {
                                _isMaximized = !_isMaximized;
                              });
                            },
                            onClose: () {
                              setState(() {
                                _isWindowOpen = false;
                              });
                            },
                            child: MatrixRainBackground(
                              opacity: 0.08,
                              child: Column(
                                children: [
                                  NavBar(
                                    selectedIndex: selectedIndex,
                                    onAboutMeTap: () =>
                                        ref
                                                .read(
                                                  navigationProvider.notifier,
                                                )
                                                .state =
                                            0,
                                    onResumeTap: () =>
                                        ref
                                                .read(
                                                  navigationProvider.notifier,
                                                )
                                                .state =
                                            1,
                                    onContactTap: () =>
                                        ref
                                                .read(
                                                  navigationProvider.notifier,
                                                )
                                                .state =
                                            2,
                                  ),
                                  Expanded(
                                    child: AnimatedSwitcher(
                                      duration: const Duration(
                                        milliseconds: 400,
                                      ),
                                      transitionBuilder:
                                          (
                                            Widget child,
                                            Animation<double> animation,
                                          ) {
                                            return FadeTransition(
                                              opacity: animation,
                                              child: child,
                                            );
                                          },
                                      child: _buildCurrentTab(
                                        ref,
                                        selectedIndex,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  String _getWindowTitle(int index) {
    switch (index) {
      case 0:
        return 'user@drakehuang: ~/about_me - zsh';
      case 1:
        return 'user@drakehuang: ~/resume - zsh';
      case 2:
        return 'user@drakehuang: ~/contact - zsh';
      default:
        return 'user@drakehuang: ~ - zsh';
    }
  }

  Widget _buildCurrentTab(WidgetRef ref, int selectedIndex) {
    switch (selectedIndex) {
      case 0:
        return KeyedSubtree(
          key: const ValueKey(0),
          child: _buildAboutMeTab(ref),
        );
      case 1:
        return KeyedSubtree(key: const ValueKey(1), child: _buildResumeTab());
      case 2:
        return KeyedSubtree(key: const ValueKey(2), child: _buildContactTab());
      default:
        return const SizedBox();
    }
  }

  Widget _buildAboutMeTab(WidgetRef ref) {
    return _buildScrollableContent(
      AboutMeSection(
        onViewResume: () => ref.read(navigationProvider.notifier).state = 1,
        onViewContact: () => ref.read(navigationProvider.notifier).state = 2,
      ),
    );
  }

  Widget _buildResumeTab() {
    return _buildScrollableContent(const ResumeSection());
  }

  Widget _buildContactTab() {
    return _buildScrollableContent(const ContactSection());
  }

  Widget _buildScrollableContent(Widget child) {
    return SizedBox(
      width: double.infinity,
      height: double.infinity,
      child: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Center(child: child),
      ),
    );
  }
}
