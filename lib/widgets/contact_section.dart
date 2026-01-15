import 'package:flutter/material.dart';
import '../l10n/app_localizations.dart';
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

class _ContactSectionState extends State<ContactSection> {
  final _formKey = GlobalKey<FormState>();
  final _firstNameController = TextEditingController();
  final _lastNameController = TextEditingController();
  final _emailController = TextEditingController();
  final _subjectController = TextEditingController();
  final _messageController = TextEditingController();

  @override
  void dispose() {
    _firstNameController.dispose();
    _lastNameController.dispose();
    _emailController.dispose();
    _subjectController.dispose();
    _messageController.dispose();
    super.dispose();
  }

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
          child: isDesktop
              ? _buildDesktopLayout(context, l10n)
              : _buildMobileLayout(context, l10n),
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
              Text(
                l10n.contactTitle,
                style: const TextStyle(
                  fontSize: 32,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 16),
              Text(
                l10n.contactSubtitle,
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w400,
                  color: Colors.grey[800],
                ),
              ),
              const SizedBox(height: 48),
              _buildSocialButton(
                assetPath: 'assets/images/github-sign.png',
                label: 'GitHub',
                url: 'https://github.com/drakehuang81',
              ),
              _buildSocialButton(
                assetPath: 'assets/images/linkedin.png',
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
        Text(
          l10n.contactTitle,
          style: const TextStyle(fontSize: 32, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 16),
        Text(
          l10n.contactSubtitle,
          style: TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w400,
            color: Colors.grey[800],
          ),
        ),
        const SizedBox(height: 32),
        _buildSocialButton(
          assetPath: 'assets/images/github-sign.png',
          label: 'GitHub',
          url: 'https://github.com/drakehuang81',
        ),
        _buildSocialButton(
          assetPath: 'assets/images/linkedin.png',
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
          Row(
            children: [
              Expanded(
                child: _buildTextField(
                  l10n.firstName,
                  _firstNameController,
                  required: true,
                ),
              ),
              const SizedBox(width: 24),
              Expanded(
                child: _buildTextField(
                  l10n.lastName,
                  _lastNameController,
                  required: true,
                ),
              ),
            ],
          ),
          const SizedBox(height: 24),
          Row(
            children: [
              Expanded(
                child: _buildTextField(
                  l10n.email,
                  _emailController,
                  required: true,
                ),
              ),
              const SizedBox(width: 24),
              Expanded(
                child: _buildTextField(l10n.subject, _subjectController),
              ),
            ],
          ),
          const SizedBox(height: 24),
          _buildTextField(l10n.message, _messageController, maxLines: 4),
          const SizedBox(height: 32),
          // Submit Button
          SizedBox(
            width: 200, // or double.infinity for full width
            height: 48,
            child: ElevatedButton(
              onPressed: _isSending ? null : _handleSubmit,
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFFE5A013), // Yellow
                disabledBackgroundColor: const Color(0xFFE5A013).withAlpha(128),
                foregroundColor: Colors.black,
                elevation: 0,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(24),
                ),
              ),
              child: _isSending
                  ? const SizedBox(
                      width: 24,
                      height: 24,
                      child: CircularProgressIndicator(
                        strokeWidth: 2,
                        valueColor: AlwaysStoppedAnimation<Color>(Colors.black),
                      ),
                    )
                  : Text(
                      l10n.submit,
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTextField(
    String label,
    TextEditingController controller, {
    bool required = false,
    int maxLines = 1,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        RichText(
          text: TextSpan(
            text: label,
            style: TextStyle(
              fontSize: 13,
              color: Colors.grey[700],
              fontWeight: FontWeight.w500,
            ),
            children: required
                ? const [
                    TextSpan(
                      text: ' *',
                      style: TextStyle(color: Colors.black),
                    ),
                  ]
                : null,
          ),
        ),
        const SizedBox(height: 8),
        TextFormField(
          controller: controller,
          maxLines: maxLines,
          decoration: InputDecoration(
            filled: true,
            fillColor: Colors
                .transparent, // Transparent as per image look? Or very light grey? Image looks like thin border.
            // Let's go with a very light background + border to match the clean look
            contentPadding: const EdgeInsets.symmetric(
              horizontal: 12,
              vertical: 12,
            ),
            enabledBorder: OutlineInputBorder(
              borderSide: BorderSide(color: Colors.grey[400]!, width: 0.5),
              borderRadius: BorderRadius.circular(0), // Rectangular look
            ),
            focusedBorder: OutlineInputBorder(
              borderSide: const BorderSide(color: Colors.black, width: 1),
              borderRadius: BorderRadius.circular(0),
            ),
            errorBorder: OutlineInputBorder(
              borderSide: const BorderSide(color: Colors.red, width: 0.5),
              borderRadius: BorderRadius.circular(0),
            ),
            focusedErrorBorder: OutlineInputBorder(
              borderSide: const BorderSide(color: Colors.red, width: 1),
              borderRadius: BorderRadius.circular(0),
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
      ],
    );
  }

  bool _isSending = false;
  DateTime? _lastSendTime;

  // JS Interop for reCAPTCHA
  @override
  void initState() {
    super.initState();
    _loadRecaptchaScript();
  }

  void _loadRecaptchaScript() {
    const siteKey = String.fromEnvironment('RECAPTCHA_SITE_KEY');
    if (siteKey.isNotEmpty) {
      // Check if script is already loaded to avoid duplicates
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

  // Real implementation below using a mix of JS and dart:html/web
  // Since we are on Flutter 3.10+, we might be in a transition phase.
  // Let's safe-guard this.

  Future<void> _handleSubmit() async {
    if (_formKey.currentState!.validate()) {
      // 1. Throttling
      if (_lastSendTime != null &&
          DateTime.now().difference(_lastSendTime!) <
              const Duration(seconds: 60)) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text(
              'Please wait a minute before sending another message.',
            ),
            backgroundColor: Colors.orange,
          ),
        );
        return;
      }

      setState(() {
        _isSending = true;
      });

      // 2. Get keys
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
        // 3. Get reCAPTCHA Token
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
              'from_name': _firstNameController.text,
              'last_name': _lastNameController.text,
              'from_email': _emailController.text,
              'subject': _subjectController.text,
              'message': _messageController.text,
              'g-recaptcha-response': recaptchaToken, // Add token here
            },
          }),
        );
        // ...

        if (response.body == 'OK') {
          _lastSendTime = DateTime.now(); // Update last send time
          if (mounted) {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                content: Text('Message sent successfully!'),
                backgroundColor: Colors.green,
              ),
            );
            // Clear form
            _firstNameController.clear();
            _lastNameController.clear();
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
    required String assetPath,
    required String label,
    required String url,
  }) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16),
      child: InkWell(
        onTap: () => _launchUrl(url),
        borderRadius: BorderRadius.circular(8),
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 0),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Image.asset(assetPath, width: 24, height: 24),
              const SizedBox(width: 12),
              Text(
                label,
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                  color: Colors.black,
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
