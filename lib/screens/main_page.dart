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
      backgroundColor: Colors.white,
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
    return Container(
      color: const Color(0xFFE8DDD4),
      width: double.infinity,
      child: Center(
        child: SingleChildScrollView(
          child: AboutMeSection(
            onViewResume: () => setState(() => _selectedIndex = 1),
          ),
        ),
      ),
    );
  }

  Widget _buildResumeTab() {
    return const SingleChildScrollView(child: ResumeSection());
  }

  Widget _buildContactTab() {
    return const SingleChildScrollView(child: ContactSection());
  }
}
