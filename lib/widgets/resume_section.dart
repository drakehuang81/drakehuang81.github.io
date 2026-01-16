import 'package:flutter/material.dart';
// ignore_for_file: deprecated_member_use

import '../l10n/app_localizations.dart';
import '../core/terminal_theme.dart';

class ResumeSection extends StatelessWidget {
  const ResumeSection({super.key});

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final isDesktop = MediaQuery.of(context).size.width >= 800;

    return Container(
      color: TerminalTheme.background,
      padding: const EdgeInsets.symmetric(vertical: 64),
      child: Center(
        child: Container(
          constraints: const BoxConstraints(maxWidth: 1000),
          padding: EdgeInsets.symmetric(horizontal: isDesktop ? 48 : 24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Page Title - Terminal style
              Text(l10n.resumeTitle, style: TerminalTheme.titleLarge),
              const SizedBox(height: 64),

              // Work Experience Section
              _buildSection(
                context,
                title: l10n.workExperience,
                content: Column(
                  children: [
                    _buildResumeItem(
                      period: l10n.job1Period,
                      title: l10n.job1Title,
                      subtitle: l10n.confidential,
                      description:
                          "• ${l10n.job1Desc1}\n• ${l10n.job1Desc2}\n• ${l10n.job1Desc3}\n• ${l10n.job1Desc4}\n• ${l10n.job1Desc5}\n• ${l10n.job1Desc6}",
                    ),
                    _buildResumeItem(
                      period: l10n.job2Period,
                      title: l10n.job2Title,
                      subtitle: l10n.job2Company,
                      description:
                          "• ${l10n.job2Desc1}\n• ${l10n.job2Desc2}\n• ${l10n.job2Desc3}\n• ${l10n.job2Desc4}\n• ${l10n.job2Desc5}\n• ${l10n.job2Desc6}",
                    ),
                    _buildResumeItem(
                      period: l10n.job3Period,
                      title: l10n.job3Title,
                      subtitle: l10n.job3Company,
                      description:
                          "• ${l10n.job3Desc1}\n• ${l10n.job3Desc2}\n• ${l10n.job3Desc3}\n• ${l10n.job3Desc4}\n• ${l10n.job3Desc5}\n• ${l10n.job3Desc6}\n• ${l10n.job3Desc7}",
                    ),
                    _buildResumeItem(
                      period: l10n.job4Period,
                      title: l10n.job4Title,
                      subtitle: l10n.job4Company,
                      description:
                          "• ${l10n.job4Desc1}\n• ${l10n.job4Desc2}\n• ${l10n.job4Desc3}\n• ${l10n.job4Desc4}\n• ${l10n.job4Desc5}\n• ${l10n.job4Desc6}\n• ${l10n.job4Desc7}\n• ${l10n.job4Desc8}",
                    ),
                    _buildResumeItem(
                      period: l10n.job5Period,
                      title: l10n.job5Title,
                      subtitle: l10n.job5Company,
                      description:
                          "• ${l10n.job5Desc1}\n• ${l10n.job5Desc2}\n• ${l10n.job5Desc3}\n• ${l10n.job5Desc4}",
                    ),
                    _buildResumeItem(
                      period: l10n.job6Period,
                      title: l10n.job6Title,
                      subtitle: l10n.job6Company,
                      description:
                          "• ${l10n.job6Desc1}\n• ${l10n.job6Desc2}\n• ${l10n.job6Desc3}",
                    ),
                  ],
                ),
                isDesktop: isDesktop,
              ),

              _buildDivider(),

              // Skills Section
              _buildSection(
                context,
                title: l10n.skillsSection,
                content: Column(
                  children: [
                    _buildResumeItem(
                      period: "Languages",
                      title: "Swift, Objective-C, Dart (Flutter)",
                      subtitle: "",
                      description: "",
                    ),
                    _buildResumeItem(
                      period: "Mobile Frameworks",
                      title:
                          "SwiftUI, UIKit, RxSwift, RxCocoa, Combine, GCD, Auto Layout, Swift Concurrency",
                      subtitle: "",
                      description: "",
                    ),
                    _buildResumeItem(
                      period: "Architecture",
                      title: "MVVM, Clean Architecture",
                      subtitle: "",
                      description: "",
                    ),
                    _buildResumeItem(
                      period: "Tools & CI/CD",
                      title:
                          "Xcode, Git, Jenkins, Fastlane, CocoaPods, SPM, Instruments",
                      subtitle: "",
                      description: "",
                    ),
                  ],
                ),
                isDesktop: isDesktop,
              ),

              _buildDivider(),

              // Education Section
              _buildSection(
                context,
                title: l10n.educationSection,
                content: _buildResumeItem(
                  period: "2010 - 2014",
                  title: l10n.eduSchool,
                  subtitle: l10n.eduDegree,
                  description: l10n.eduMajor,
                ),
                isDesktop: isDesktop,
              ),

              const SizedBox(height: 80),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildDivider() {
    return Container(
      height: 1,
      margin: const EdgeInsets.symmetric(vertical: 48),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            TerminalTheme.borderColor.withOpacity(0),
            TerminalTheme.borderColor,
            TerminalTheme.borderColor.withOpacity(0),
          ],
        ),
      ),
    );
  }

  Widget _buildSection(
    BuildContext context, {
    required String title,
    required Widget content,
    required bool isDesktop,
  }) {
    if (!isDesktop) {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(title, style: TerminalTheme.titleSmall),
          const SizedBox(height: 32),
          content,
        ],
      );
    }
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Section Title Column
        Expanded(flex: 1, child: Text(title, style: TerminalTheme.titleSmall)),
        // Content Column
        Expanded(flex: 2, child: content),
      ],
    );
  }

  Widget _buildResumeItem({
    required String period,
    required String title,
    required String subtitle,
    required String description,
  }) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 40),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Period - Terminal date style
          SizedBox(
            width: 140,
            child: Text(
              'Date: $period',
              style: TerminalTheme.bodySmall.copyWith(
                color: TerminalTheme.terminalGreenMuted,
              ),
            ),
          ),
          const SizedBox(width: 24),
          // Details
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Title with Role prefix
                RichText(
                  text: TextSpan(
                    children: [
                      TextSpan(
                        text: 'Role: ',
                        style: TerminalTheme.bodySmall.copyWith(
                          color: TerminalTheme.terminalGreenMuted,
                        ),
                      ),
                      TextSpan(
                        text: title,
                        style: TerminalTheme.bodyMedium.copyWith(
                          fontWeight: FontWeight.bold,
                          color: TerminalTheme.terminalGreen,
                        ),
                      ),
                    ],
                  ),
                ),
                if (subtitle.isNotEmpty) ...[
                  const SizedBox(height: 4),
                  RichText(
                    text: TextSpan(
                      children: [
                        TextSpan(
                          text: 'Company: ',
                          style: TerminalTheme.bodySmall.copyWith(
                            color: TerminalTheme.terminalGreenMuted,
                          ),
                        ),
                        TextSpan(
                          text: subtitle,
                          style: TerminalTheme.bodyMedium,
                        ),
                      ],
                    ),
                  ),
                ],
                if (description.isNotEmpty) ...[
                  const SizedBox(height: 12),
                  Text(
                    description,
                    style: TerminalTheme.bodySmall.copyWith(height: 1.8),
                  ),
                ],
              ],
            ),
          ),
        ],
      ),
    );
  }
}
