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
        horizontal: isDesktop ? 64 : 24,
        vertical: 24,
      ),
      color: const Color(0xFFF4F4F4),
      child: Row(
        children: [
          // Logo/Name area
          InkWell(
            onTap: onAboutMeTap,
            child: Row(
              children: [
                Container(
                  width: 20,
                  height: 20,
                  decoration: const BoxDecoration(
                    color: Color(0xFFE5A013), // Yellow dot
                    shape: BoxShape.circle,
                  ),
                ),
                const SizedBox(width: 12),
                Text(
                  l10n.name,
                  style: const TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w900,
                    letterSpacing: -0.5,
                    color: Colors.black,
                  ),
                ),
                const SizedBox(width: 8),
                Text(
                  l10n.jobTitle,
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w300,
                    color: Colors.grey[800],
                  ),
                ),
              ],
            ),
          ),
          const Spacer(),
          // Navigation items
          if (isDesktop) ...[
            _buildNavItem(l10n.navResume, 1, onResumeTap),
            _buildSeparator(),
            _buildNavItem(l10n.navContact, 2, onContactTap),
            const SizedBox(width: 24),
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
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: Text(
          label,
          style: TextStyle(
            fontSize: 14,
            fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
            color: Colors.black,
          ),
        ),
      ),
    );
  }

  Widget _buildSeparator() {
    return Container(width: 1, height: 14, color: Colors.grey[400]);
  }

  Widget _buildLanguageToggle(AppLocalizations l10n) {
    return InkWell(
      onTap: () => localeProvider.toggleLocale(),
      borderRadius: BorderRadius.circular(4),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
        child: Text(
          l10n.switchLanguage,
          style: TextStyle(
            fontSize: 13,
            color: Colors.grey[600],
            fontWeight: FontWeight.w500,
          ),
        ),
      ),
    );
  }
}
