import 'package:flutter/material.dart';
import '../l10n/app_localizations.dart';

class AboutMeSection extends StatelessWidget {
  final VoidCallback onViewResume;

  const AboutMeSection({super.key, required this.onViewResume});

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final isDesktop = MediaQuery.of(context).size.width >= 800;

    if (isDesktop) {
      return _buildDesktopLayout(context, l10n);
    }
    return _buildMobileLayout(context, l10n);
  }

  Widget _buildDesktopLayout(BuildContext context, AppLocalizations l10n) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 48, vertical: 64),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          // Profile Card
          _buildProfileCard(context, l10n),
          const SizedBox(width: 64),
          // Intro Content
          Expanded(child: _buildIntroContent(context, l10n)),
        ],
      ),
    );
  }

  Widget _buildMobileLayout(BuildContext context, AppLocalizations l10n) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 32),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          _buildProfileCard(context, l10n),
          const SizedBox(height: 32),
          _buildIntroContent(context, l10n),
        ],
      ),
    );
  }

  Widget _buildProfileCard(BuildContext context, AppLocalizations l10n) {
    return Container(
      width: 280,
      padding: const EdgeInsets.all(32),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(4),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withAlpha(25),
            blurRadius: 20,
            offset: const Offset(0, 10),
          ),
        ],
      ),
      child: Column(
        children: [
          // Avatar placeholder
          Container(
            width: 140,
            height: 140,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: Colors.grey[300],
              border: Border.all(color: Colors.grey[400]!, width: 2),
            ),
            child: Icon(Icons.person, size: 60, color: Colors.grey[500]),
          ),
          const SizedBox(height: 24),
          // Name
          Text(
            l10n.name,
            style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 8),
          // Divider
          Container(width: 40, height: 3, color: const Color(0xFF2563EB)),
          const SizedBox(height: 16),
          // Job title
          Text(
            l10n.jobTitle.toUpperCase(),
            style: TextStyle(
              fontSize: 12,
              color: Colors.grey[600],
              letterSpacing: 2,
            ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 24),
          // Social icons
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              _buildSocialIcon(Icons.link),
              const SizedBox(width: 16),
              _buildSocialIcon(Icons.code),
              const SizedBox(width: 16),
              _buildSocialIcon(Icons.email_outlined),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildSocialIcon(IconData icon) {
    return Container(
      padding: const EdgeInsets.all(8),
      child: Icon(icon, size: 20, color: Colors.grey[700]),
    );
  }

  Widget _buildIntroContent(BuildContext context, AppLocalizations l10n) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Hello
        Text(
          l10n.hello,
          style: const TextStyle(
            fontSize: 56,
            fontWeight: FontWeight.bold,
            fontStyle: FontStyle.italic,
          ),
        ),
        const SizedBox(height: 8),
        // Subtitle
        Text(
          l10n.hereIsWhoIAm,
          style: TextStyle(fontSize: 18, color: Colors.grey[800]),
        ),
        const SizedBox(height: 24),
        // Resume button
        ElevatedButton(
          onPressed: onViewResume,
          style: ElevatedButton.styleFrom(
            backgroundColor: const Color(0xFF2563EB),
            foregroundColor: Colors.white,
            padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 16),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(24),
            ),
          ),
          child: Text(
            l10n.viewResume,
            style: const TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w600,
              letterSpacing: 0.5,
            ),
          ),
        ),
        const SizedBox(height: 32),
        // Intro paragraphs
        Text(
          l10n.aboutMeIntro,
          style: TextStyle(fontSize: 15, color: Colors.grey[700], height: 1.6),
        ),
        const SizedBox(height: 16),
        Text(
          l10n.aboutMeIntro2,
          style: TextStyle(
            fontSize: 15,
            color: Colors.grey[500],
            fontStyle: FontStyle.italic,
            height: 1.6,
          ),
        ),
      ],
    );
  }
}
