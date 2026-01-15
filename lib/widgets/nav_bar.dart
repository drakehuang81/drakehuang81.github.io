import 'package:flutter/material.dart';
import '../l10n/app_localizations.dart';
import '../core/locale_provider.dart';

class NavBar extends StatelessWidget {
  final LocaleProvider localeProvider;
  final VoidCallback onAboutMeTap;
  final VoidCallback onResumeTap;
  final VoidCallback onContactTap;
  final int selectedIndex;

  const NavBar({
    super.key,
    required this.localeProvider,
    required this.onAboutMeTap,
    required this.onResumeTap,
    required this.onContactTap,
    this.selectedIndex = 0,
  });

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final isDesktop = MediaQuery.of(context).size.width >= 800;

    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: isDesktop ? 48 : 16,
        vertical: 16,
      ),
      color: Colors.white,
      child: Row(
        children: [
          // Logo and name
          Row(
            children: [
              Container(width: 16, height: 16, color: const Color(0xFF2563EB)),
              const SizedBox(width: 12),
              Text(
                l10n.name,
                style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(width: 8),
              Text(
                '/ ${l10n.jobTitle}',
                style: TextStyle(
                  fontSize: 14,
                  color: Colors.grey[600],
                  letterSpacing: 1,
                ),
              ),
            ],
          ),
          const Spacer(),
          // Navigation items
          if (isDesktop) ...[
            _buildNavItem(l10n.navAboutMe, 0, onAboutMeTap),
            const SizedBox(width: 32),
            _buildNavItem(l10n.navResume, 1, onResumeTap),
            const SizedBox(width: 32),
            _buildNavItem(l10n.navContact, 2, onContactTap),
            const SizedBox(width: 32),
          ],
          // Language toggle
          _buildLanguageToggle(l10n),
        ],
      ),
    );
  }

  Widget _buildNavItem(String label, int index, VoidCallback onTap) {
    final isSelected = selectedIndex == index;
    return InkWell(
      onTap: onTap,
      child: Text(
        label,
        style: TextStyle(
          fontSize: 13,
          fontWeight: FontWeight.w500,
          color: isSelected ? const Color(0xFF2563EB) : Colors.grey[700],
          letterSpacing: 0.5,
        ),
      ),
    );
  }

  Widget _buildLanguageToggle(AppLocalizations l10n) {
    return InkWell(
      onTap: () => localeProvider.toggleLocale(),
      borderRadius: BorderRadius.circular(4),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Icon(Icons.language, size: 18, color: Colors.grey),
            const SizedBox(width: 4),
            Text(
              l10n.switchLanguage,
              style: TextStyle(fontSize: 13, color: Colors.grey[700]),
            ),
          ],
        ),
      ),
    );
  }
}
