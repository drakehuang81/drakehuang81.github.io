import 'package:flutter/material.dart';
// ignore_for_file: deprecated_member_use

import 'package:url_launcher/url_launcher.dart';
import '../l10n/app_localizations.dart';
import '../core/terminal_theme.dart';

class ContactSection extends StatefulWidget {
  const ContactSection({super.key});

  @override
  State<ContactSection> createState() => _ContactSectionState();
}

class _ContactSectionState extends State<ContactSection> {
  // Track hover state for each card
  int? _hoveredIndex;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final isDesktop = MediaQuery.of(context).size.width >= 800;

    return Container(
      padding: const EdgeInsets.symmetric(vertical: 64, horizontal: 24),
      child: Center(
        child: Container(
          constraints: const BoxConstraints(maxWidth: 900),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            children: [
              _buildHeader(l10n),
              const SizedBox(height: 64),
              _buildConnectionGrid(isDesktop),
              const SizedBox(height: 80),
              _buildFooter(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildHeader(AppLocalizations l10n) {
    return Column(
      children: [
        Text(
          l10n.contactTitle,
          style: TerminalTheme.titleLarge.copyWith(
            shadows: [
              Shadow(
                color: TerminalTheme.gitHubBlue.withOpacity(0.5),
                blurRadius: 20,
              ),
            ],
          ),
          textAlign: TextAlign.center,
        ),
        const SizedBox(height: 16),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          decoration: BoxDecoration(
            color: TerminalTheme.gitHubBlue.withOpacity(0.1),
            borderRadius: BorderRadius.circular(4),
            border: Border.all(
              color: TerminalTheme.gitHubBlue.withOpacity(0.3),
            ),
          ),
          child: Text(
            l10n.contactSubtitle.toUpperCase(),
            style: TerminalTheme.bodySmall.copyWith(
              color: TerminalTheme.gitHubBlue,
              letterSpacing: 1.5,
              fontWeight: FontWeight.bold,
            ),
            textAlign: TextAlign.center,
          ),
        ),
      ],
    );
  }

  Widget _buildConnectionGrid(bool isDesktop) {
    // Defines our connection portals
    final connections = [
      _ConnectionData(
        index: 0,
        icon: Icons.code,
        label: 'GITHUB',
        subLabel: 'Source Code / Projects',
        url: 'https://github.com/drakehuang81',
        color: const Color(0xFFC9D1D9), // GitHub Grey/White
      ),
      _ConnectionData(
        index: 1,
        icon: Icons.work_outline,
        label: 'LINKEDIN',
        subLabel: 'Professional Network',
        url: 'https://www.linkedin.com/in/drake-huang-b26028179',
        color: const Color(0xFF0A66C2), // LinkedIn Blue
      ),
      _ConnectionData(
        index: 2,
        icon: Icons.alternate_email,
        label: 'X / TWITTER',
        subLabel: 'Thoughts & Updates',
        url: 'https://x.com/drake812860',
        color: const Color(0xFFE7E9EA), // X White
      ),
    ];

    return Wrap(
      spacing: 24,
      runSpacing: 24,
      alignment: WrapAlignment.center,
      children: connections
          .map((data) => _buildConnectionCard(data, isDesktop))
          .toList(),
    );
  }

  Widget _buildConnectionCard(_ConnectionData data, bool isDesktop) {
    final isHovered = _hoveredIndex == data.index;

    return MouseRegion(
      onEnter: (_) => setState(() => _hoveredIndex = data.index),
      onExit: (_) => setState(() => _hoveredIndex = null),
      cursor: SystemMouseCursors.click,
      child: GestureDetector(
        onTap: () => _launchUrl(data.url),
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 200),
          width: isDesktop ? 260 : 300,
          height: 160,
          padding: const EdgeInsets.all(24),
          decoration: BoxDecoration(
            color: TerminalTheme.backgroundDark,
            borderRadius: BorderRadius.circular(12),
            border: Border.all(
              color: isHovered ? data.color : TerminalTheme.borderColor,
              width: isHovered ? 2 : 1,
            ),
            boxShadow: [
              if (isHovered)
                BoxShadow(
                  color: data.color.withOpacity(0.2),
                  blurRadius: 16,
                  spreadRadius: 2,
                ),
            ],
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Icon(
                    data.icon,
                    size: 32,
                    color: isHovered ? data.color : TerminalTheme.gitHubGrey,
                  ),
                  Icon(
                    Icons.arrow_outward,
                    size: 16,
                    color: isHovered ? data.color : TerminalTheme.gitHubGrey,
                  ),
                ],
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    data.label,
                    style: TerminalTheme.bodyLarge.copyWith(
                      fontWeight: FontWeight.bold,
                      color: isHovered
                          ? Colors.white
                          : TerminalTheme.gitHubText,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    data.subLabel,
                    style: TerminalTheme.bodySmall.copyWith(
                      color: TerminalTheme.gitHubGrey,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildFooter() {
    return Column(
      children: [
        Text(
          '< SYSTEM STATUS: ONLINE >',
          style: TerminalTheme.bodySmall.copyWith(
            color: TerminalTheme.terminalGreenBright,
            letterSpacing: 2,
          ),
        ),
        const SizedBox(height: 16),
        Text(
          'WELCOME TO MY DIGITAL SPACE.\nEXPLORE MY WORK & CONNECT.\n<CODE IS POETRY>',
          style: TerminalTheme.bodySmall.copyWith(
            color: TerminalTheme.gitHubGrey,
            height: 1.6,
          ),
          textAlign: TextAlign.center,
        ),
      ],
    );
  }

  Future<void> _launchUrl(String urlString) async {
    final Uri url = Uri.parse(urlString);
    if (!await launchUrl(url)) {
      debugPrint('Could not launch $url');
    }
  }
}

class _ConnectionData {
  final int index;
  final IconData icon;
  final String label;
  final String subLabel;
  final String url;
  final Color color;

  _ConnectionData({
    required this.index,
    required this.icon,
    required this.label,
    required this.subLabel,
    required this.url,
    required this.color,
  });
}
