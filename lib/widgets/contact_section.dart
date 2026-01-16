import 'package:flutter/material.dart';
// ignore_for_file: deprecated_member_use

import 'package:url_launcher/url_launcher.dart';
import '../l10n/app_localizations.dart';
import '../core/terminal_theme.dart';

class ContactSection extends StatelessWidget {
  const ContactSection({super.key});

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;

    return Container(
      padding: const EdgeInsets.symmetric(vertical: 64),
      // No opaque color here to allow matrix rain to show through
      child: Center(
        child: Container(
          constraints: const BoxConstraints(maxWidth: 600),
          padding: const EdgeInsets.symmetric(horizontal: 24),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisSize: MainAxisSize.min, // Wrap content height
            children: [
              Text(
                l10n.contactTitle,
                style: TerminalTheme.titleLarge,
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 24),
              Text(
                l10n.contactSubtitle,
                style: TerminalTheme.bodyMedium,
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 48),
              Wrap(
                spacing: 24,
                runSpacing: 24,
                alignment: WrapAlignment.center,
                children: [
                  _buildSocialButton(
                    icon: Icons.code,
                    label: 'GitHub',
                    url: 'https://github.com/drakehuang81',
                  ),
                  _buildSocialButton(
                    icon: Icons.work_outline,
                    label: 'LinkedIn',
                    url: 'https://www.linkedin.com/in/drake-huang-b26028179',
                  ),
                ],
              ),
              const SizedBox(height: 64),
              // Footer Text Block
              Text(
                'WELCOME TO MY DIGITAL SPACE.\nEXPLORE MY WORK & CONNECT.\n<CODE IS POETRY>\n<BUILD. CREATE. INNOVATE.>',
                style: TerminalTheme.titleSmall.copyWith(
                  color: TerminalTheme.terminalGreen,
                  fontSize: 14,
                  height: 1.8,
                  shadows: [
                    Shadow(
                      color: TerminalTheme.terminalGreen.withOpacity(0.8),
                      blurRadius: 10,
                    ),
                  ],
                ),
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildSocialButton({
    required IconData icon,
    required String label,
    required String url,
  }) {
    return Material(
      color: Colors.transparent, // Allow background to show through
      child: InkWell(
        onTap: () => _launchUrl(url),
        borderRadius: BorderRadius.circular(4),
        hoverColor: TerminalTheme.terminalGreen.withOpacity(0.1),
        splashColor: TerminalTheme.terminalGreen.withOpacity(0.2),
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 32),
          decoration: BoxDecoration(
            border: Border.all(color: TerminalTheme.terminalGreen, width: 2),
            borderRadius: BorderRadius.circular(8),
            // Darker background for contrast
            color: Colors.black.withOpacity(0.6),
            boxShadow: [
              BoxShadow(
                color: TerminalTheme.terminalGreen.withOpacity(0.3),
                blurRadius: 12,
                spreadRadius: 1,
              ),
            ],
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(icon, size: 24, color: TerminalTheme.terminalGreen),
              const SizedBox(width: 12),
              Text(
                label,
                style: TerminalTheme.bodyLarge.copyWith(
                  fontWeight: FontWeight.w600,
                  color: TerminalTheme.terminalGreen,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> _launchUrl(String urlString) async {
    final Uri url = Uri.parse(urlString);
    if (!await launchUrl(url)) {
      debugPrint('Could not launch $url');
    }
  }
}
