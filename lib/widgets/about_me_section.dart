import 'package:flutter/material.dart';
import '../l10n/app_localizations.dart';
import '../core/terminal_theme.dart';

class AboutMeSection extends StatefulWidget {
  final VoidCallback onViewResume;
  final VoidCallback onViewContact;

  const AboutMeSection({
    super.key,
    required this.onViewResume,
    required this.onViewContact,
  });

  @override
  State<AboutMeSection> createState() => _AboutMeSectionState();
}

class _AboutMeSectionState extends State<AboutMeSection>
    with SingleTickerProviderStateMixin {
  late AnimationController _cursorController;

  @override
  void initState() {
    super.initState();
    _cursorController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 530),
    )..repeat(reverse: true);
  }

  @override
  void dispose() {
    _cursorController.dispose();
    super.dispose();
  }

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
            // Left: Photo with terminal-style border
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
      width: 280,
      height: 280,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        border: Border.all(color: TerminalTheme.terminalGreen, width: 3),
        boxShadow: [
          BoxShadow(
            color: TerminalTheme.terminalGreen.withAlpha(30),
            blurRadius: 30,
            spreadRadius: 5,
          ),
        ],
      ),
      child: ClipOval(
        child: Image.asset(
          'assets/images/profile_photo.png',
          fit: BoxFit.cover,
        ),
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
        // Hello - Large terminal title
        Text(l10n.hello, style: TerminalTheme.titleLarge),
        const SizedBox(height: 16),
        // Subtitle
        Text(
          'A Bit About Me',
          style: TerminalTheme.titleSmall.copyWith(color: Colors.white),
        ),
        const SizedBox(height: 24),
        // Description with terminal styling
        Text(
          l10n.aboutMeIntro,
          style: TerminalTheme.bodyLarge.copyWith(
            color: const Color(0xFFCCCCCC),
          ),
          textAlign: isDesktop ? TextAlign.start : TextAlign.center,
        ),
        const SizedBox(height: 12),
        // Blinking cursor at end of text
        // Description paragraph 2 with inline cursor
        Text.rich(
          TextSpan(
            children: [
              TextSpan(
                text: l10n.aboutMeIntro2,
                style: TerminalTheme.bodyLarge.copyWith(
                  color: const Color(0xFFCCCCCC),
                ),
              ),
              WidgetSpan(
                alignment: PlaceholderAlignment.middle,
                child: AnimatedBuilder(
                  animation: _cursorController,
                  builder: (context, child) {
                    return Opacity(
                      opacity: _cursorController.value,
                      child: Container(
                        width: 10,
                        height: 20,
                        margin: const EdgeInsets.only(left: 4),
                        color: TerminalTheme.cursorColor,
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
          textAlign: isDesktop ? TextAlign.start : TextAlign.center,
        ),
        const SizedBox(height: 48),
        // Terminal-style buttons
        Row(
          mainAxisAlignment: isDesktop
              ? MainAxisAlignment.start
              : MainAxisAlignment.center,
          children: [
            _buildTerminalButton('[1] ${l10n.viewResume}', widget.onViewResume),
            const SizedBox(width: 24),
            _buildTerminalButton(
              '[2] ${l10n.navContact}',
              widget.onViewContact,
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildTerminalButton(String label, VoidCallback onTap) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(4),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        child: Text(
          label,
          style: TerminalTheme.buttonText.copyWith(color: Colors.white),
        ),
      ),
    );
  }
}
