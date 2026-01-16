import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../core/terminal_theme.dart';
import '../providers/navigation_provider.dart';
import '../widgets/nav_bar.dart';
import '../widgets/about_me_section.dart';
import '../widgets/resume_section.dart';
import '../widgets/contact_section.dart';
import '../widgets/matrix_rain_background.dart';

class MainPage extends ConsumerWidget {
  const MainPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final selectedIndex = ref.watch(navigationProvider);

    return Scaffold(
      backgroundColor: TerminalTheme.background,
      body: MatrixRainBackground(
        opacity: 0.08,
        child: Column(
          children: [
            NavBar(
              selectedIndex: selectedIndex,
              onAboutMeTap: () =>
                  ref.read(navigationProvider.notifier).state = 0,
              onResumeTap: () =>
                  ref.read(navigationProvider.notifier).state = 1,
              onContactTap: () =>
                  ref.read(navigationProvider.notifier).state = 2,
            ),
            Expanded(
              child: AnimatedSwitcher(
                duration: const Duration(milliseconds: 400),
                transitionBuilder: (Widget child, Animation<double> animation) {
                  return FadeTransition(opacity: animation, child: child);
                },
                child: _buildCurrentTab(ref, selectedIndex),
              ),
            ),
          ],
        ),
      ),
    );
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
    return _buildCenteredScrollable(
      AboutMeSection(
        onViewResume: () => ref.read(navigationProvider.notifier).state = 1,
        onViewContact: () => ref.read(navigationProvider.notifier).state = 2,
      ),
    );
  }

  Widget _buildResumeTab() {
    return _buildCenteredScrollable(const ResumeSection());
  }

  Widget _buildContactTab() {
    return _buildCenteredScrollable(const ContactSection());
  }

  Widget _buildCenteredScrollable(Widget child) {
    return Container(
      color: Colors.transparent,
      width: double.infinity,
      height: double.infinity,
      child: LayoutBuilder(
        builder: (context, constraints) {
          return SingleChildScrollView(
            child: ConstrainedBox(
              constraints: BoxConstraints(minHeight: constraints.maxHeight),
              child: Center(child: child),
            ),
          );
        },
      ),
    );
  }
}
