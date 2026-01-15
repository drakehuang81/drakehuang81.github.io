import 'package:flutter/material.dart';
import '../l10n/app_localizations.dart';
import 'experience_card.dart';

class ResumeSection extends StatelessWidget {
  const ResumeSection({super.key});

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final isDesktop = MediaQuery.of(context).size.width >= 800;

    return Container(
      color: const Color(0xFFE8DDD4),
      padding: EdgeInsets.symmetric(
        horizontal: isDesktop ? 120 : 24,
        vertical: 64,
      ),
      child: Column(
        children: [
          // Section title
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(width: 16, height: 16, color: const Color(0xFF2563EB)),
              const SizedBox(width: 12),
              Text(
                l10n.resumeTitle,
                style: const TextStyle(
                  fontSize: 32,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
          const SizedBox(height: 48),
          // Experience section
          _buildExperienceSection(context, l10n, isDesktop),
          const SizedBox(height: 48),
          // Education section
          _buildEducationSection(context, l10n, isDesktop),
        ],
      ),
    );
  }

  Widget _buildExperienceSection(
    BuildContext context,
    AppLocalizations l10n,
    bool isDesktop,
  ) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Header with download button
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              l10n.experienceSection,
              style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            ElevatedButton(
              onPressed: () {},
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF2563EB),
                foregroundColor: Colors.white,
                padding: const EdgeInsets.symmetric(
                  horizontal: 20,
                  vertical: 12,
                ),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(4),
                ),
              ),
              child: Text(
                l10n.downloadCV,
                style: const TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.w600,
                  letterSpacing: 0.5,
                ),
              ),
            ),
          ],
        ),
        const SizedBox(height: 24),
        // Job cards
        ExperienceCard(
          period: l10n.job1Period,
          title: l10n.job1Title,
          company: l10n.confidential,
          location: '',
          descriptions: [l10n.job1Desc1, l10n.job1Desc2, l10n.job1Desc3],
          isConfidential: true,
        ),
        const SizedBox(height: 16),
        ExperienceCard(
          period: l10n.job2Period,
          title: l10n.job2Title,
          company: l10n.job2Company,
          location: 'Taiwan',
          descriptions: [l10n.job2Desc1, l10n.job2Desc2, l10n.job2Desc3],
        ),
        const SizedBox(height: 16),
        ExperienceCard(
          period: l10n.job3Period,
          title: l10n.job3Title,
          company: l10n.job3Company,
          location: 'Taiwan',
          descriptions: [l10n.job3Desc1, l10n.job3Desc2],
        ),
        const SizedBox(height: 16),
        ExperienceCard(
          period: l10n.job4Period,
          title: l10n.job4Title,
          company: l10n.job4Company,
          location: 'Taiwan',
          descriptions: [l10n.job4Desc1, l10n.job4Desc2, l10n.job4Desc3],
        ),
      ],
    );
  }

  Widget _buildEducationSection(
    BuildContext context,
    AppLocalizations l10n,
    bool isDesktop,
  ) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          l10n.educationSection,
          style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 24),
        Container(
          width: double.infinity,
          padding: const EdgeInsets.all(24),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(4),
          ),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                flex: 2,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      '2010 - 2014',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: Color(0xFF2563EB),
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      l10n.eduSchool.toUpperCase(),
                      style: const TextStyle(
                        fontSize: 13,
                        fontWeight: FontWeight.w600,
                        letterSpacing: 0.5,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      l10n.eduDegree,
                      style: TextStyle(fontSize: 13, color: Colors.grey[600]),
                    ),
                  ],
                ),
              ),
              const SizedBox(width: 32),
              Expanded(
                flex: 3,
                child: Text(
                  l10n.eduMajor,
                  style: TextStyle(
                    fontSize: 14,
                    color: Colors.grey[700],
                    height: 1.5,
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
