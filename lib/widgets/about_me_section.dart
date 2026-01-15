import 'package:flutter/material.dart';
import '../l10n/app_localizations.dart';

class AboutMeSection extends StatelessWidget {
  final VoidCallback onViewResume;
  final VoidCallback onViewContact;

  const AboutMeSection({
    super.key,
    required this.onViewResume,
    required this.onViewContact,
  });

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
    return Center(
      child: Container(
        constraints: const BoxConstraints(maxWidth: 1000),
        padding: const EdgeInsets.symmetric(horizontal: 48, vertical: 64),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            // Left: Photo
            _buildPhoto(),
            const SizedBox(width: 80),
            // Right: Content
            Expanded(child: _buildContent(context, l10n, isDesktop: true)),
          ],
        ),
      ),
    );
  }

  Widget _buildMobileLayout(BuildContext context, AppLocalizations l10n) {
    return Center(
      child: Container(
        constraints: const BoxConstraints(maxWidth: 600),
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 32),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            _buildPhoto(),
            const SizedBox(height: 48),
            _buildContent(context, l10n, isDesktop: false),
          ],
        ),
      ),
    );
  }

  Widget _buildPhoto() {
    return Container(
      width: 300,
      height: 300,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: Colors.grey[300],
        image: const DecorationImage(
          image: AssetImage('assets/images/profile_photo.png'),
          fit: BoxFit.cover,
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withAlpha(20),
            blurRadius: 20,
            offset: const Offset(0, 10),
          ),
        ],
      ),
    );
  }

  Widget _buildContent(
    BuildContext context,
    AppLocalizations l10n, {
    required bool isDesktop,
  }) {
    return Column(
      crossAxisAlignment: isDesktop
          ? CrossAxisAlignment.start
          : CrossAxisAlignment.center,
      children: [
        // Hello
        Text(
          l10n.hello,
          style: const TextStyle(
            fontSize: 80,
            fontWeight: FontWeight.w900,
            height: 1,
            letterSpacing: -2,
            color: Colors.black,
          ),
        ),
        const SizedBox(height: 24),
        // Subtitle
        Text(
          "A Bit About Me",
          style: const TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: Colors.black,
          ),
        ),
        const SizedBox(height: 16),
        // Description
        Text(
          l10n.aboutMeIntro,
          style: TextStyle(fontSize: 16, color: Colors.grey[700], height: 1.6),
          textAlign: isDesktop ? TextAlign.start : TextAlign.center,
        ),
        const SizedBox(height: 8),
        Text(
          l10n.aboutMeIntro2,
          style: TextStyle(fontSize: 16, color: Colors.grey[700], height: 1.6),
          textAlign: isDesktop ? TextAlign.start : TextAlign.center,
        ),
        const SizedBox(height: 48),
        // Buttons
        Row(
          mainAxisAlignment: isDesktop
              ? MainAxisAlignment.start
              : MainAxisAlignment.center,
          children: [
            _buildCircleButton(
              l10n.viewResume,
              const Color(0xFFE5A013), // Yellow
              onViewResume,
            ),
            const SizedBox(width: 24),
            _buildCircleButton(
              l10n.navContact,
              const Color(0xFF7DD1D3), // Teal
              onViewContact,
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildCircleButton(String label, Color color, VoidCallback onTap) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(100),
      child: Container(
        width: 100,
        height: 100,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: color,
          boxShadow: [
            BoxShadow(
              color: Colors.black.withAlpha(25),
              blurRadius: 10,
              offset: const Offset(0, 5),
            ),
          ],
        ),
        child: Center(
          child: Text(
            label,
            style: const TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.bold,
              color: Colors.black,
            ),
            textAlign: TextAlign.center,
          ),
        ),
      ),
    );
  }
}
