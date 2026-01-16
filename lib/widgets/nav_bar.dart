import 'dart:async';
// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import '../l10n/app_localizations.dart';
import '../core/locale_provider.dart';
import '../core/terminal_theme.dart';

class NavBar extends StatefulWidget {
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
  State<NavBar> createState() => _NavBarState();
}

class _NavBarState extends State<NavBar> with SingleTickerProviderStateMixin {
  late AnimationController _cursorController;
  String _displayedCommand = '';
  bool _isTyping = false;
  Timer? _typingTimer;

  @override
  void initState() {
    super.initState();
    _cursorController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 530),
    )..repeat(reverse: true);

    // Initial typing animation
    _startTypingAnimation(_getCommandForIndex(widget.selectedIndex));
  }

  @override
  void didUpdateWidget(NavBar oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.selectedIndex != widget.selectedIndex) {
      _startTypingAnimation(_getCommandForIndex(widget.selectedIndex));
    }
  }

  void _startTypingAnimation(String targetText) {
    _typingTimer?.cancel();
    setState(() {
      _isTyping = true;
      _displayedCommand = '';
    });

    int currentIndex = 0;
    _typingTimer = Timer.periodic(const Duration(milliseconds: 50), (timer) {
      if (currentIndex < targetText.length) {
        setState(() {
          _displayedCommand += targetText[currentIndex];
        });
        currentIndex++;
      } else {
        timer.cancel();
        setState(() {
          _isTyping = false;
        });
      }
    });
  }

  @override
  void dispose() {
    _cursorController.dispose();
    _typingTimer?.cancel();
    super.dispose();
  }

  String _getCommandForIndex(int index) {
    switch (index) {
      case 0:
        return './about_me.sh';
      case 1:
        return 'cat resume.txt';
      case 2:
        return './contact.sh';
      default:
        return './about_me.sh';
    }
  }

  void _handleNavTap(VoidCallback onTap) {
    if (_isTyping) return;
    onTap();
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final isDesktop = MediaQuery.of(context).size.width >= 800;

    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: isDesktop ? 64 : 24,
        vertical: 16,
      ),
      color: TerminalTheme.background,
      child: Row(
        children: [
          // Terminal prompt with command - Clickable to go Home
          Expanded(
            child: InkWell(
              onTap: () {
                if (widget.selectedIndex != 0) {
                  widget.onAboutMeTap();
                }
              },
              overlayColor: MaterialStateProperty.all(Colors.transparent),
              child: Row(
                children: [
                  Text('user@drakehuang:', style: TerminalTheme.commandPrompt),
                  Text('~', style: TerminalTheme.promptPath),
                  Text(' ➜ ', style: TerminalTheme.promptSymbol),

                  // Command text with truncation
                  Expanded(
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Flexible(
                          child: Text(
                            _displayedCommand,
                            style: TerminalTheme.bodyMedium,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                        // Blinking cursor
                        AnimatedBuilder(
                          animation: _cursorController,
                          builder: (context, child) {
                            return Opacity(
                              opacity: _cursorController.value,
                              child: Container(
                                width: 8,
                                height: 16,
                                margin: const EdgeInsets.only(left: 2),
                                color: TerminalTheme.cursorColor,
                              ),
                            );
                          },
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
          // Navigation items
          if (isDesktop) ...[
            _buildNavItem(
              l10n.navAboutMe.toLowerCase(),
              0,
              widget.onAboutMeTap,
            ),
            _buildSeparator(),
            _buildNavItem(l10n.navResume.toLowerCase(), 1, widget.onResumeTap),
            _buildSeparator(),
            _buildNavItem(
              l10n.navContact.toLowerCase(),
              2,
              widget.onContactTap,
            ),
            _buildSeparator(),
            _buildLanguageToggle(l10n),
          ] else ...[
            // Mobile: Hamburger Menu
            _buildMobileMenu(context, l10n),
          ],
        ],
      ),
    );
  }

  Widget _buildNavItem(String label, int index, VoidCallback onTap) {
    final isSelected = widget.selectedIndex == index;
    return InkWell(
      onTap: () => _handleNavTap(onTap),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 12),
        child: Text(
          label,
          style: isSelected
              ? TerminalTheme.navItemSelected
              : TerminalTheme.navItem,
        ),
      ),
    );
  }

  Widget _buildSeparator() {
    return Text(' | ', style: TerminalTheme.bodySmall);
  }

  Widget _buildLanguageToggle(AppLocalizations l10n) {
    return InkWell(
      onTap: () => widget.localeProvider.toggleLocale(),
      borderRadius: BorderRadius.circular(4),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
        child: Text(
          l10n.switchLanguage.toLowerCase(),
          style: TerminalTheme.navItem,
        ),
      ),
    );
  }

  Widget _buildMobileMenu(BuildContext context, AppLocalizations l10n) {
    return Theme(
      data: Theme.of(context).copyWith(
        popupMenuTheme: PopupMenuThemeData(
          color: TerminalTheme.backgroundDark,
          textStyle: TerminalTheme.bodyMedium,
          shape: RoundedRectangleBorder(
            side: BorderSide(color: TerminalTheme.borderColor),
            borderRadius: BorderRadius.circular(8),
          ),
        ),
        dividerTheme: const DividerThemeData(
          color: TerminalTheme.borderColor,
          thickness: 1,
        ),
      ),
      child: PopupMenuButton<int>(
        icon: const Icon(Icons.menu, color: TerminalTheme.gitHubText),
        tooltip: 'Menu',
        padding: EdgeInsets.zero,
        offset: const Offset(0, 40),
        onSelected: (index) {
          switch (index) {
            case 0:
              _handleNavTap(widget.onAboutMeTap);
              break;
            case 1:
              _handleNavTap(widget.onResumeTap);
              break;
            case 2:
              _handleNavTap(widget.onContactTap);
              break;
            case 3:
              widget.localeProvider.toggleLocale();
              break;
          }
        },
        itemBuilder: (context) => [
          PopupMenuItem(
            value: 0,
            child: _buildMobileMenuItem(
              l10n.navAboutMe.toLowerCase(),
              widget.selectedIndex == 0,
            ),
          ),
          PopupMenuItem(
            value: 1,
            child: _buildMobileMenuItem(
              l10n.navResume.toLowerCase(),
              widget.selectedIndex == 1,
            ),
          ),
          PopupMenuItem(
            value: 2,
            child: _buildMobileMenuItem(
              l10n.navContact.toLowerCase(),
              widget.selectedIndex == 2,
            ),
          ),
          const PopupMenuDivider(),
          PopupMenuItem(
            value: 3,
            child: Text(
              l10n.switchLanguage.toLowerCase(),
              style: TerminalTheme.navItem.copyWith(
                color: TerminalTheme.gitHubBlue,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildMobileMenuItem(String label, bool isSelected) {
    return Text(
      '> $label',
      style: isSelected ? TerminalTheme.navItemSelected : TerminalTheme.navItem,
    );
  }
}
