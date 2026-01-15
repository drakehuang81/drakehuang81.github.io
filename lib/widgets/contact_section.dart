import 'package:flutter/material.dart';
import '../l10n/app_localizations.dart';
import '../core/terminal_theme.dart';
import 'package:url_launcher/url_launcher.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:web/web.dart' as web;
import 'dart:js_interop';

@JS('grecaptcha')
external GreCaptcha get grecaptcha;

@JS()
extension type GreCaptcha._(JSObject _) implements JSObject {
  external JSPromise<JSString> execute(String siteKey, JSObject? options);
}

class ContactSection extends StatefulWidget {
  const ContactSection({super.key});

  @override
  State<ContactSection> createState() => _ContactSectionState();
}

class _ContactSectionState extends State<ContactSection>
    with SingleTickerProviderStateMixin {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _subjectController = TextEditingController();
  final _messageController = TextEditingController();

  late AnimationController _cursorController;

  @override
  void initState() {
    super.initState();
    _cursorController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 530),
    )..repeat(reverse: true);
    _loadRecaptchaScript();
  }

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _subjectController.dispose();
    _messageController.dispose();
    _cursorController.dispose();
    super.dispose();
  }

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
              if (isDesktop)
                _buildDesktopLayout(context, l10n)
              else
                _buildMobileLayout(context, l10n),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildDesktopLayout(BuildContext context, AppLocalizations l10n) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Left Info Column
        Expanded(
          flex: 2,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(l10n.contactTitle, style: TerminalTheme.titleLarge),
              const SizedBox(height: 16),
              Text(l10n.contactSubtitle, style: TerminalTheme.bodyMedium),
              const SizedBox(height: 48),
              _buildSocialButton(
                icon: Icons.code,
                label: 'GitHub',
                url: 'https://github.com/drakehuang81',
              ),
              _buildSocialButton(
                icon: Icons.work_outline,
                label: 'LinkedIn',
                url: 'https://www.linkedin.com/in/drake-huang-b26028179',
              ),
            ],
          ),
        ),
        const SizedBox(width: 64),
        // Right Form Column
        Expanded(flex: 3, child: _buildForm(context, l10n)),
      ],
    );
  }

  Widget _buildMobileLayout(BuildContext context, AppLocalizations l10n) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(l10n.contactTitle, style: TerminalTheme.titleLarge),
        const SizedBox(height: 16),
        Text(l10n.contactSubtitle, style: TerminalTheme.bodyMedium),
        const SizedBox(height: 32),
        _buildSocialButton(
          icon: Icons.code,
          label: 'GitHub',
          url: 'https://github.com/drakehuang81',
        ),
        _buildSocialButton(
          icon: Icons.work_outline,
          label: 'LinkedIn',
          url: 'https://www.linkedin.com/in/drake-huang-b26028179',
        ),
        const SizedBox(height: 48),
        _buildForm(context, l10n),
      ],
    );
  }

  Widget _buildForm(BuildContext context, AppLocalizations l10n) {
    return Form(
      key: _formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildTerminalInput(
            label: 'Name',
            controller: _nameController,
            required: true,
          ),
          const SizedBox(height: 20),
          _buildTerminalInput(
            label: 'Email',
            controller: _emailController,
            required: true,
          ),
          const SizedBox(height: 20),
          _buildTerminalInput(label: 'Subject', controller: _subjectController),
          const SizedBox(height: 20),
          _buildTerminalInput(
            label: 'Message',
            controller: _messageController,
            maxLines: 4,
          ),
          const SizedBox(height: 32),
          // Terminal Submit Button
          InkWell(
            onTap: _isSending ? null : _handleSubmit,
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text('SUBMIT > ', style: TerminalTheme.buttonText),
                if (_isSending)
                  SizedBox(
                    width: 16,
                    height: 16,
                    child: CircularProgressIndicator(
                      strokeWidth: 2,
                      valueColor: AlwaysStoppedAnimation<Color>(
                        TerminalTheme.terminalGreen,
                      ),
                    ),
                  )
                else
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 12,
                      vertical: 6,
                    ),
                    decoration: BoxDecoration(
                      border: Border.all(
                        color: TerminalTheme.terminalGreen,
                        width: 1,
                      ),
                      borderRadius: BorderRadius.circular(2),
                    ),
                    child: Text('[ENTER]', style: TerminalTheme.buttonText),
                  ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTerminalInput({
    required String label,
    required TextEditingController controller,
    bool required = false,
    int maxLines = 1,
  }) {
    return Row(
      crossAxisAlignment: maxLines > 1
          ? CrossAxisAlignment.start
          : CrossAxisAlignment.center,
      children: [
        SizedBox(
          width: 80,
          child: Text('$label >', style: TerminalTheme.inputLabel),
        ),
        Expanded(
          child: TextFormField(
            controller: controller,
            maxLines: maxLines,
            style: TerminalTheme.bodyMedium,
            cursorColor: TerminalTheme.cursorColor,
            cursorWidth: 10,
            decoration: InputDecoration(
              filled: true,
              fillColor: TerminalTheme.inputBackground,
              contentPadding: const EdgeInsets.symmetric(
                horizontal: 12,
                vertical: 12,
              ),
              border: InputBorder.none,
              enabledBorder: UnderlineInputBorder(
                borderSide: BorderSide(
                  color: TerminalTheme.borderColor,
                  width: 1,
                ),
              ),
              focusedBorder: UnderlineInputBorder(
                borderSide: BorderSide(
                  color: TerminalTheme.terminalGreen,
                  width: 2,
                ),
              ),
              errorBorder: const UnderlineInputBorder(
                borderSide: BorderSide(color: Colors.red, width: 1),
              ),
              focusedErrorBorder: const UnderlineInputBorder(
                borderSide: BorderSide(color: Colors.red, width: 2),
              ),
            ),
            validator: required
                ? (value) {
                    if (value == null || value.isEmpty) {
                      return 'Required';
                    }
                    return null;
                  }
                : null,
          ),
        ),
        // Blinking cursor indicator
        AnimatedBuilder(
          animation: _cursorController,
          builder: (context, child) {
            return Opacity(
              opacity: _cursorController.value * 0.3,
              child: Container(
                width: 10,
                height: 20,
                margin: const EdgeInsets.only(left: 4),
                color: TerminalTheme.cursorColor,
              ),
            );
          },
        ),
      ],
    );
  }

  bool _isSending = false;
  DateTime? _lastSendTime;

  void _loadRecaptchaScript() {
    const siteKey = String.fromEnvironment('RECAPTCHA_SITE_KEY');
    if (siteKey.isNotEmpty) {
      final existingScript = web.document.querySelector(
        'script[src*="recaptcha/api.js"]',
      );
      if (existingScript != null) return;

      final script =
          web.document.createElement('script') as web.HTMLScriptElement;
      script.src = 'https://www.google.com/recaptcha/api.js?render=$siteKey';
      script.async = true;
      web.document.head!.append(script);
    }
  }

  Future<String?> _executeRecaptcha(String siteKey) async {
    try {
      final promise = grecaptcha.execute(siteKey, null);
      final result = await promise.toDart;
      return result.toDart;
    } catch (e) {
      debugPrint('reCAPTCHA execution failed: $e');
      return null;
    }
  }

  Future<void> _handleSubmit() async {
    if (_formKey.currentState!.validate()) {
      if (_lastSendTime != null &&
          DateTime.now().difference(_lastSendTime!) <
              const Duration(seconds: 60)) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(
              'Please wait a minute before sending another message.',
              style: TerminalTheme.bodySmall.copyWith(color: Colors.black),
            ),
            backgroundColor: TerminalTheme.terminalGreen,
          ),
        );
        return;
      }

      setState(() {
        _isSending = true;
      });

      const serviceId = String.fromEnvironment('EMAILJS_SERVICE_ID');
      const templateId = String.fromEnvironment('EMAILJS_TEMPLATE_ID');
      const publicKey = String.fromEnvironment('EMAILJS_PUBLIC_KEY');
      const siteKey = String.fromEnvironment('RECAPTCHA_SITE_KEY');

      if (serviceId.isEmpty || templateId.isEmpty || publicKey.isEmpty) {
        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text('EmailJS configuration missing.'),
              backgroundColor: Colors.red,
            ),
          );
          setState(() => _isSending = false);
        }
        return;
      }

      try {
        String? recaptchaToken;
        if (siteKey.isNotEmpty) {
          recaptchaToken = await _executeRecaptcha(siteKey);
          if (recaptchaToken == null) {
            throw Exception('Failed to get reCAPTCHA token');
          }
        }

        final url = Uri.parse('https://api.emailjs.com/api/v1.0/email/send');
        final response = await http.post(
          url,
          headers: {
            'origin': 'http://localhost',
            'Content-Type': 'application/json',
          },
          body: json.encode({
            'service_id': serviceId,
            'template_id': templateId,
            'user_id': publicKey,
            'template_params': {
              'from_name': _nameController.text,
              'from_email': _emailController.text,
              'subject': _subjectController.text,
              'message': _messageController.text,
              'g-recaptcha-response': recaptchaToken,
            },
          }),
        );

        if (response.body == 'OK') {
          _lastSendTime = DateTime.now();
          if (mounted) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(
                  'Message sent successfully!',
                  style: TerminalTheme.bodySmall.copyWith(color: Colors.black),
                ),
                backgroundColor: TerminalTheme.terminalGreen,
              ),
            );
            _nameController.clear();
            _emailController.clear();
            _subjectController.clear();
            _messageController.clear();
          }
        } else {
          debugPrint('EmailJS Error: ${response.body}');
          if (mounted) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text('Failed to send message: ${response.body}'),
                backgroundColor: Colors.red,
              ),
            );
          }
        }
      } catch (e) {
        debugPrint('Error sending email: $e');
        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text('An error occurred: $e'),
              backgroundColor: Colors.red,
            ),
          );
        }
      } finally {
        if (mounted) {
          setState(() {
            _isSending = false;
          });
        }
      }
    }
  }

  Widget _buildSocialButton({
    required IconData icon,
    required String label,
    required String url,
  }) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16),
      child: InkWell(
        onTap: () => _launchUrl(url),
        borderRadius: BorderRadius.circular(4),
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 8),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(icon, size: 20, color: TerminalTheme.terminalGreenBright),
              const SizedBox(width: 12),
              Text(
                label,
                style: TerminalTheme.bodyMedium.copyWith(
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> _launchUrl(String urlString) async {
    final Uri url = Uri.parse(urlString);
    if (!await launchUrl(url)) {
      debugPrint('Could not launch $url');
    }
  }
}
