import 'package:flutter/material.dart';
import '../core/locale_provider.dart';
import '../core/terminal_theme.dart';
import '../widgets/nav_bar.dart';
import '../widgets/about_me_section.dart';
import '../widgets/resume_section.dart';
import '../widgets/contact_section.dart';
import '../widgets/matrix_rain_background.dart';

class MainPage extends StatefulWidget {
  final LocaleProvider localeProvider;

  const MainPage({super.key, required this.localeProvider});

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  int _selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: TerminalTheme.background,
      body: MatrixRainBackground(
        opacity: 0.08,
        child: Column(
          children: [
            NavBar(
              localeProvider: widget.localeProvider,
              selectedIndex: _selectedIndex,
              onAboutMeTap: () => setState(() => _selectedIndex = 0),
              onResumeTap: () => setState(() => _selectedIndex = 1),
              onContactTap: () => setState(() => _selectedIndex = 2),
            ),
            Expanded(
              child: AnimatedSwitcher(
                duration: const Duration(milliseconds: 400),
                transitionBuilder: (Widget child, Animation<double> animation) {
                  return FadeTransition(opacity: animation, child: child);
                },
                child: _buildCurrentTab(),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildCurrentTab() {
    switch (_selectedIndex) {
      case 0:
        return KeyedSubtree(key: const ValueKey(0), child: _buildAboutMeTab());
      case 1:
        return KeyedSubtree(key: const ValueKey(1), child: _buildResumeTab());
      case 2:
        return KeyedSubtree(key: const ValueKey(2), child: _buildContactTab());
      default:
        return const SizedBox();
    }
  }

  Widget _buildAboutMeTab() {
    return _buildCenteredScrollable(
      AboutMeSection(
        onViewResume: () => setState(() => _selectedIndex = 1),
        onViewContact: () => setState(() => _selectedIndex = 2),
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
