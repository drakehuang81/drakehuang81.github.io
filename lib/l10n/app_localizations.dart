import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/intl.dart' as intl;

import 'app_localizations_en.dart';
import 'app_localizations_zh.dart';

// ignore_for_file: type=lint

/// Callers can lookup localized strings with an instance of AppLocalizations
/// returned by `AppLocalizations.of(context)`.
///
/// Applications need to include `AppLocalizations.delegate()` in their app's
/// `localizationDelegates` list, and the locales they support in the app's
/// `supportedLocales` list. For example:
///
/// ```dart
/// import 'l10n/app_localizations.dart';
///
/// return MaterialApp(
///   localizationsDelegates: AppLocalizations.localizationsDelegates,
///   supportedLocales: AppLocalizations.supportedLocales,
///   home: MyApplicationHome(),
/// );
/// ```
///
/// ## Update pubspec.yaml
///
/// Please make sure to update your pubspec.yaml to include the following
/// packages:
///
/// ```yaml
/// dependencies:
///   # Internationalization support.
///   flutter_localizations:
///     sdk: flutter
///   intl: any # Use the pinned version from flutter_localizations
///
///   # Rest of dependencies
/// ```
///
/// ## iOS Applications
///
/// iOS applications define key application metadata, including supported
/// locales, in an Info.plist file that is built into the application bundle.
/// To configure the locales supported by your app, you’ll need to edit this
/// file.
///
/// First, open your project’s ios/Runner.xcworkspace Xcode workspace file.
/// Then, in the Project Navigator, open the Info.plist file under the Runner
/// project’s Runner folder.
///
/// Next, select the Information Property List item, select Add Item from the
/// Editor menu, then select Localizations from the pop-up menu.
///
/// Select and expand the newly-created Localizations item then, for each
/// locale your application supports, add a new item and select the locale
/// you wish to add from the pop-up menu in the Value field. This list should
/// be consistent with the languages listed in the AppLocalizations.supportedLocales
/// property.
abstract class AppLocalizations {
  AppLocalizations(String locale)
    : localeName = intl.Intl.canonicalizedLocale(locale.toString());

  final String localeName;

  static AppLocalizations? of(BuildContext context) {
    return Localizations.of<AppLocalizations>(context, AppLocalizations);
  }

  static const LocalizationsDelegate<AppLocalizations> delegate =
      _AppLocalizationsDelegate();

  /// A list of this localizations delegate along with the default localizations
  /// delegates.
  ///
  /// Returns a list of localizations delegates containing this delegate along with
  /// GlobalMaterialLocalizations.delegate, GlobalCupertinoLocalizations.delegate,
  /// and GlobalWidgetsLocalizations.delegate.
  ///
  /// Additional delegates can be added by appending to this list in
  /// MaterialApp. This list does not have to be used at all if a custom list
  /// of delegates is preferred or required.
  static const List<LocalizationsDelegate<dynamic>> localizationsDelegates =
      <LocalizationsDelegate<dynamic>>[
        delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
      ];

  /// A list of this localizations delegate's supported locales.
  static const List<Locale> supportedLocales = <Locale>[
    Locale('en'),
    Locale('zh'),
  ];

  /// No description provided for @appTitle.
  ///
  /// In en, this message translates to:
  /// **'Resume - Drake Huang'**
  String get appTitle;

  /// No description provided for @name.
  ///
  /// In en, this message translates to:
  /// **'Drake Huang'**
  String get name;

  /// No description provided for @jobTitle.
  ///
  /// In en, this message translates to:
  /// **'Senior iOS Developer'**
  String get jobTitle;

  /// No description provided for @summary.
  ///
  /// In en, this message translates to:
  /// **'6+ years of experience in iOS development'**
  String get summary;

  /// No description provided for @switchLanguage.
  ///
  /// In en, this message translates to:
  /// **'中文'**
  String get switchLanguage;

  /// No description provided for @navAboutMe.
  ///
  /// In en, this message translates to:
  /// **'ABOUT ME'**
  String get navAboutMe;

  /// No description provided for @navResume.
  ///
  /// In en, this message translates to:
  /// **'RESUME'**
  String get navResume;

  /// No description provided for @navContact.
  ///
  /// In en, this message translates to:
  /// **'CONTACT'**
  String get navContact;

  /// No description provided for @hello.
  ///
  /// In en, this message translates to:
  /// **'Hello'**
  String get hello;

  /// No description provided for @hereIsWhoIAm.
  ///
  /// In en, this message translates to:
  /// **'Here\'s who I am & what I do'**
  String get hereIsWhoIAm;

  /// No description provided for @aboutMeIntro.
  ///
  /// In en, this message translates to:
  /// **'I am an iOS Developer with 6.5 years of experience. My expertise is deeply rooted in Swift, with a consistent focus on building high-performance and well-architected native applications. Throughout my career, I have also gained experience maintaining and iterating on Objective-C projects, allowing me to effectively navigate and solve complex problems within mixed-language environments.'**
  String get aboutMeIntro;

  /// No description provided for @aboutMeIntro2.
  ///
  /// In en, this message translates to:
  /// **'Recently, I have expanded my technical skillset to include Flutter, utilizing it to build this personal website and explore cross-platform solutions through various side projects. I am passionate about mastering new technologies while striving to deliver the best user experience by balancing stability with innovation.'**
  String get aboutMeIntro2;

  /// No description provided for @viewResume.
  ///
  /// In en, this message translates to:
  /// **'RESUME'**
  String get viewResume;

  /// No description provided for @resumeTitle.
  ///
  /// In en, this message translates to:
  /// **'Resume'**
  String get resumeTitle;

  /// No description provided for @workExperience.
  ///
  /// In en, this message translates to:
  /// **'Work Experience'**
  String get workExperience;

  /// No description provided for @experienceSection.
  ///
  /// In en, this message translates to:
  /// **'Experience'**
  String get experienceSection;

  /// No description provided for @skillsSection.
  ///
  /// In en, this message translates to:
  /// **'Skills'**
  String get skillsSection;

  /// No description provided for @educationSection.
  ///
  /// In en, this message translates to:
  /// **'Education'**
  String get educationSection;

  /// No description provided for @downloadCV.
  ///
  /// In en, this message translates to:
  /// **'DOWNLOAD CV'**
  String get downloadCV;

  /// No description provided for @confidential.
  ///
  /// In en, this message translates to:
  /// **'Confidential'**
  String get confidential;

  /// No description provided for @job0Title.
  ///
  /// In en, this message translates to:
  /// **'Independent Developer'**
  String get job0Title;

  /// No description provided for @job0Company.
  ///
  /// In en, this message translates to:
  /// **'Self-Employed'**
  String get job0Company;

  /// No description provided for @job0Period.
  ///
  /// In en, this message translates to:
  /// **'2025.11 - Present'**
  String get job0Period;

  /// No description provided for @job0Desc1.
  ///
  /// In en, this message translates to:
  /// **'Pioneered AI-Augmented Development: Leveraged cutting-edge AI CLI agents (including Claude Code, Gemini CLI, OpenCode, and Antigravity) to orchestrate complex coding tasks. Established a high-velocity workflow focused on automated refactoring and intelligent debugging.'**
  String get job0Desc1;

  /// No description provided for @job0Desc2.
  ///
  /// In en, this message translates to:
  /// **'End-to-End Flutter Development: Architected and engineered a cross-platform mobile application from scratch using Flutter. Managed the full product lifecycle, translating conceptual requirements into a functional MVP with clean architecture.'**
  String get job0Desc2;

  /// No description provided for @job0Desc3.
  ///
  /// In en, this message translates to:
  /// **'Flutter Web Implementation: Designed and deployed a responsive personal portfolio website using Flutter Web. Demonstrated proficiency in single-codebase multi-platform development and optimized web performance.'**
  String get job0Desc3;

  /// No description provided for @job1Title.
  ///
  /// In en, this message translates to:
  /// **'Senior iOS Developer'**
  String get job1Title;

  /// No description provided for @job1Period.
  ///
  /// In en, this message translates to:
  /// **'2024.12 - 2025.10'**
  String get job1Period;

  /// No description provided for @job1Desc1.
  ///
  /// In en, this message translates to:
  /// **'Maintained and optimized legacy iOS projects written primarily in Objective-C (70%) and some Swift (30%).'**
  String get job1Desc1;

  /// No description provided for @job1Desc2.
  ///
  /// In en, this message translates to:
  /// **'Developed new features using SwiftUI, while maintaining and updating existing UIKit-based features.'**
  String get job1Desc2;

  /// No description provided for @job1Desc3.
  ///
  /// In en, this message translates to:
  /// **'Implemented and maintained CI/CD pipelines to improve testing and deployment efficiency.'**
  String get job1Desc3;

  /// No description provided for @job1Desc4.
  ///
  /// In en, this message translates to:
  /// **'Collaborated closely with backend engineers and product managers to define requirements and deliver features on time.'**
  String get job1Desc4;

  /// No description provided for @job1Desc5.
  ///
  /// In en, this message translates to:
  /// **'Participated in code reviews and technical discussions to ensure code quality and maintainability.'**
  String get job1Desc5;

  /// No description provided for @job1Desc6.
  ///
  /// In en, this message translates to:
  /// **'Refactored legacy code and incrementally migrated core components to modern Swift practices.'**
  String get job1Desc6;

  /// No description provided for @job2Company.
  ///
  /// In en, this message translates to:
  /// **'Masterwork Aoitek Tech Corp Ltd'**
  String get job2Company;

  /// No description provided for @job2Title.
  ///
  /// In en, this message translates to:
  /// **'Sr. iOS Developer'**
  String get job2Title;

  /// No description provided for @job2Period.
  ///
  /// In en, this message translates to:
  /// **'2023.03 - 2024.10'**
  String get job2Period;

  /// No description provided for @job2Desc1.
  ///
  /// In en, this message translates to:
  /// **'Developed the iOS application for Lollipop Baby Camera (IoT baby monitoring product).'**
  String get job2Desc1;

  /// No description provided for @job2Desc2.
  ///
  /// In en, this message translates to:
  /// **'Collaborated with UI/UX designers and backend engineers to evaluate and implement new features.'**
  String get job2Desc2;

  /// No description provided for @job2Desc3.
  ///
  /// In en, this message translates to:
  /// **'Responsible for feature development, testing, and App Store deployment.'**
  String get job2Desc3;

  /// No description provided for @job2Desc4.
  ///
  /// In en, this message translates to:
  /// **'Adopted RxSwift and introduced MVVM-C architecture to enhance code structure and scalability.'**
  String get job2Desc4;

  /// No description provided for @job2Desc5.
  ///
  /// In en, this message translates to:
  /// **'Assisted the team in implementing unit tests, increasing test coverage and stability during development.'**
  String get job2Desc5;

  /// No description provided for @job2Desc6.
  ///
  /// In en, this message translates to:
  /// **'Established a CI/CD pipeline based on GitLab and Xcode command-line tools, significantly accelerating app deployment and release.'**
  String get job2Desc6;

  /// No description provided for @job3Company.
  ///
  /// In en, this message translates to:
  /// **'Connect Mobile LTD'**
  String get job3Company;

  /// No description provided for @job3Title.
  ///
  /// In en, this message translates to:
  /// **'Sr. iOS Developer'**
  String get job3Title;

  /// No description provided for @job3Period.
  ///
  /// In en, this message translates to:
  /// **'2022.07 - 2022.12'**
  String get job3Period;

  /// No description provided for @job3Desc1.
  ///
  /// In en, this message translates to:
  /// **'Developed a map-based social platform iOS application.'**
  String get job3Desc1;

  /// No description provided for @job3Desc2.
  ///
  /// In en, this message translates to:
  /// **'Coordinated with cross-functional teams to evaluate and assess feature requirements.'**
  String get job3Desc2;

  /// No description provided for @job3Desc3.
  ///
  /// In en, this message translates to:
  /// **'Introduced MVVM architecture and extensively utilized RxSwift & RxCocoa ecosystem to accelerate development efficiency.'**
  String get job3Desc3;

  /// No description provided for @job3Desc4.
  ///
  /// In en, this message translates to:
  /// **'Established Jenkins CI/CD pipelines to achieve automated building and deployment.'**
  String get job3Desc4;

  /// No description provided for @job3Desc5.
  ///
  /// In en, this message translates to:
  /// **'Developed and launched the entire App from scratch.'**
  String get job3Desc5;

  /// No description provided for @job3Desc6.
  ///
  /// In en, this message translates to:
  /// **'Conducted Pair Programming and RxSwift source code walkthroughs to enhance team familiarity with tools.'**
  String get job3Desc6;

  /// No description provided for @job3Desc7.
  ///
  /// In en, this message translates to:
  /// **'Integrated AppLovin and AdMob to build a robust ad mediation network.'**
  String get job3Desc7;

  /// No description provided for @job4Company.
  ///
  /// In en, this message translates to:
  /// **'ET New Media Holding Co., Ltd'**
  String get job4Company;

  /// No description provided for @job4Title.
  ///
  /// In en, this message translates to:
  /// **'iOS Developer'**
  String get job4Title;

  /// No description provided for @job4Period.
  ///
  /// In en, this message translates to:
  /// **'2019.09 - 2022.07'**
  String get job4Period;

  /// No description provided for @job4Desc1.
  ///
  /// In en, this message translates to:
  /// **'Collaborated with a team of 4-5 to develop news-related products and internal enterprise applications.'**
  String get job4Desc1;

  /// No description provided for @job4Desc2.
  ///
  /// In en, this message translates to:
  /// **'Conducted code reviews and discussed implementation strategies.'**
  String get job4Desc2;

  /// No description provided for @job4Desc3.
  ///
  /// In en, this message translates to:
  /// **'Maintained and implemented new features for apps including ETtoday News, Starlight Cloud, ET Pet Store, and ET Pet.'**
  String get job4Desc3;

  /// No description provided for @job4Desc4.
  ///
  /// In en, this message translates to:
  /// **'Wrote unit tests to ensure the quality of product iterations.'**
  String get job4Desc4;

  /// No description provided for @job4Desc5.
  ///
  /// In en, this message translates to:
  /// **'Optimized memory leak issues using Instruments, and utilized Memory Graph to track and resolve off-screen rendering issues.'**
  String get job4Desc5;

  /// No description provided for @job4Desc6.
  ///
  /// In en, this message translates to:
  /// **'Regularly shared new knowledge, including WWDC insights, Swift Evolution proposals, and community event takeaways.'**
  String get job4Desc6;

  /// No description provided for @job4Desc7.
  ///
  /// In en, this message translates to:
  /// **'Later served as the technical lead, mentoring two junior engineers in project development.'**
  String get job4Desc7;

  /// No description provided for @job4Desc8.
  ///
  /// In en, this message translates to:
  /// **'Served as the team\'s RxSwift instructor, assisting members in mastering related tools.'**
  String get job4Desc8;

  /// No description provided for @job5Company.
  ///
  /// In en, this message translates to:
  /// **'ZIMI TECHNOLOGY CO., LTD'**
  String get job5Company;

  /// No description provided for @job5Title.
  ///
  /// In en, this message translates to:
  /// **'iOS Developer'**
  String get job5Title;

  /// No description provided for @job5Period.
  ///
  /// In en, this message translates to:
  /// **'2019.02 - 2019.06'**
  String get job5Period;

  /// No description provided for @job5Desc1.
  ///
  /// In en, this message translates to:
  /// **'Adopted Agile methodologies and used JIRA to assist the PM in project management and progress tracking.'**
  String get job5Desc1;

  /// No description provided for @job5Desc2.
  ///
  /// In en, this message translates to:
  /// **'Implemented payment gateway integration, QR Code scanning, push notifications, custom components, and product flow architecture design.'**
  String get job5Desc2;

  /// No description provided for @job5Desc3.
  ///
  /// In en, this message translates to:
  /// **'Collaborated closely with other iOS developers, UI/UX designers, and backend engineers.'**
  String get job5Desc3;

  /// No description provided for @job5Desc4.
  ///
  /// In en, this message translates to:
  /// **'Coordinated with QA to release beta versions via TestFlight and manage quality testing.'**
  String get job5Desc4;

  /// No description provided for @job6Company.
  ///
  /// In en, this message translates to:
  /// **'JU YAO INFORMATION CONSULTANT LTD.'**
  String get job6Company;

  /// No description provided for @job6Title.
  ///
  /// In en, this message translates to:
  /// **'IT Engineer'**
  String get job6Title;

  /// No description provided for @job6Period.
  ///
  /// In en, this message translates to:
  /// **'2018.04 - 2018.10'**
  String get job6Period;

  /// No description provided for @job6Desc1.
  ///
  /// In en, this message translates to:
  /// **'Participated in project development, production line management, and quality control, covering project management (PM), database management, system setup, and maintenance services.'**
  String get job6Desc1;

  /// No description provided for @job6Desc2.
  ///
  /// In en, this message translates to:
  /// **'Maintained PostgreSQL databases.'**
  String get job6Desc2;

  /// No description provided for @job6Desc3.
  ///
  /// In en, this message translates to:
  /// **'Provided customer support and service.'**
  String get job6Desc3;

  /// No description provided for @eduSchool.
  ///
  /// In en, this message translates to:
  /// **'Tamkang University'**
  String get eduSchool;

  /// No description provided for @eduDegree.
  ///
  /// In en, this message translates to:
  /// **'Bachelor\'s Degree'**
  String get eduDegree;

  /// No description provided for @eduMajor.
  ///
  /// In en, this message translates to:
  /// **'Department of Information and Library Science'**
  String get eduMajor;

  /// No description provided for @contactTitle.
  ///
  /// In en, this message translates to:
  /// **'Contact'**
  String get contactTitle;

  /// No description provided for @contactSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Looking forward to hearing from you'**
  String get contactSubtitle;

  /// No description provided for @phone.
  ///
  /// In en, this message translates to:
  /// **'Phone'**
  String get phone;

  /// No description provided for @submit.
  ///
  /// In en, this message translates to:
  /// **'Submit'**
  String get submit;

  /// No description provided for @firstName.
  ///
  /// In en, this message translates to:
  /// **'First Name'**
  String get firstName;

  /// No description provided for @lastName.
  ///
  /// In en, this message translates to:
  /// **'Last Name'**
  String get lastName;

  /// No description provided for @email.
  ///
  /// In en, this message translates to:
  /// **'Email'**
  String get email;

  /// No description provided for @subject.
  ///
  /// In en, this message translates to:
  /// **'Subject'**
  String get subject;

  /// No description provided for @message.
  ///
  /// In en, this message translates to:
  /// **'Message'**
  String get message;

  /// No description provided for @send.
  ///
  /// In en, this message translates to:
  /// **'Send'**
  String get send;
}

class _AppLocalizationsDelegate
    extends LocalizationsDelegate<AppLocalizations> {
  const _AppLocalizationsDelegate();

  @override
  Future<AppLocalizations> load(Locale locale) {
    return SynchronousFuture<AppLocalizations>(lookupAppLocalizations(locale));
  }

  @override
  bool isSupported(Locale locale) =>
      <String>['en', 'zh'].contains(locale.languageCode);

  @override
  bool shouldReload(_AppLocalizationsDelegate old) => false;
}

AppLocalizations lookupAppLocalizations(Locale locale) {
  // Lookup logic when only language code is specified.
  switch (locale.languageCode) {
    case 'en':
      return AppLocalizationsEn();
    case 'zh':
      return AppLocalizationsZh();
  }

  throw FlutterError(
    'AppLocalizations.delegate failed to load unsupported locale "$locale". This is likely '
    'an issue with the localizations generation tool. Please file an issue '
    'on GitHub with a reproducible sample app and the gen-l10n configuration '
    'that was used.',
  );
}
