import 'package:flutter/material.dart';
import '../core/locale_provider.dart';
import '../widgets/nav_bar.dart';
import '../widgets/about_me_section.dart';
import '../widgets/resume_section.dart';
import '../widgets/contact_section.dart';

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
      backgroundColor: const Color(0xFFF4F4F4),
      body: Column(
        children: [
          NavBar(
            localeProvider: widget.localeProvider,
            selectedIndex: _selectedIndex,
            onAboutMeTap: () => setState(() => _selectedIndex = 0),
            onResumeTap: () => setState(() => _selectedIndex = 1),
            onContactTap: () => setState(() => _selectedIndex = 2),
          ),
          Expanded(
            child: IndexedStack(
              index: _selectedIndex,
              children: [
                _buildAboutMeTab(),
                _buildResumeTab(),
                _buildContactTab(),
              ],
            ),
          ),
        ],
      ),
    );
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
      color: const Color(0xFFF4F4F4),
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
