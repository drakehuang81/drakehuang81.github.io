import 'package:flutter/material.dart';
import '../l10n/app_localizations.dart';

class ResumeSection extends StatelessWidget {
  const ResumeSection({super.key});

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final isDesktop = MediaQuery.of(context).size.width >= 800;

    return Container(
      color: const Color(0xFFF4F4F4),
      padding: const EdgeInsets.symmetric(vertical: 64),
      child: Center(
        child: Container(
          constraints: const BoxConstraints(maxWidth: 1000),
          padding: EdgeInsets.symmetric(horizontal: isDesktop ? 48 : 24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Page Title
              Text(
                l10n.resumeTitle,
                style: const TextStyle(
                  fontSize: 48,
                  fontWeight: FontWeight.w900,
                  letterSpacing: -1,
                ),
              ),
              const SizedBox(height: 80),

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

              const Divider(height: 80, thickness: 1, color: Color(0xFFE0E0E0)),

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

              const Divider(height: 80, thickness: 1, color: Color(0xFFE0E0E0)),

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

              /*
              // Download Button at bottom
              Align(
                alignment: Alignment.centerRight,
                child: TextButton.icon(
                  onPressed: () {},
                  icon: const Icon(Icons.download, size: 18),
                  label: Text(l10n.downloadCV),
                  style: TextButton.styleFrom(
                    foregroundColor: Colors.black,
                    textStyle: const TextStyle(fontWeight: FontWeight.bold),
                  ),
                ),
              ),
              */
            ],
          ),
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
          Text(
            title,
            style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 32),
          content,
        ],
      );
    }
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Section Title Column
        Expanded(
          flex: 1,
          child: Text(
            title,
            style: const TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
              letterSpacing: -0.5,
            ),
          ),
        ),
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
      padding: const EdgeInsets.only(bottom: 48),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Period
          SizedBox(
            width: 120,
            child: Text(
              period,
              style: const TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w500,
                color: Colors.black,
              ),
            ),
          ),
          const SizedBox(width: 24),
          // Details
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                if (subtitle.isNotEmpty) ...[
                  const SizedBox(height: 4),
                  Text(
                    subtitle,
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                      color: Colors.grey[800],
                    ),
                  ),
                ],
                if (description.isNotEmpty) ...[
                  const SizedBox(height: 12),
                  Text(
                    description,
                    style: TextStyle(
                      fontSize: 14,
                      color: Colors.grey[600],
                      height: 1.6,
                    ),
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
