import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class HireMeDialog extends StatefulWidget {
  const HireMeDialog({super.key});

  @override
  State<HireMeDialog> createState() => _HireMeDialogState();
}

class _HireMeDialogState extends State<HireMeDialog> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _descController = TextEditingController();

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _descController.dispose();
    super.dispose();
  }

  Future<void> _submitForm() async {
    if (_formKey.currentState!.validate()) {

      final String name = _nameController.text.trim();
      final String email = _emailController.text.trim();
      final String description = _descController.text.trim();

      // Your receiving email address
      const String myEmail = 'jadoonsufyan3@gmail.com';

      // 1. Encode the subject and body properly for URLs
      final String subject = Uri.encodeComponent('New Portfolio Inquiry from $name');
      final String body = Uri.encodeComponent(
          'Name: $name\n'
              'Return Email: $email\n\n'
              'Project Details:\n$description'
      );

      // 2. The Direct Gmail Web URL (Best for Web Portfolios)
      final Uri gmailUri = Uri.parse(
          'https://mail.google.com/mail/?view=cm&fs=1&to=$myEmail&su=$subject&body=$body'
      );

      // 3. The Standard Mailto Fallback (Best for Mobile Devices)
      final Uri mailtoUri = Uri.parse('mailto:$myEmail?subject=$subject&body=$body');

      // Close the dialog first
      Navigator.pop(context);

      // Try to open Gmail in the browser first
      try {
        if (await canLaunchUrl(gmailUri)) {
          await launchUrl(
            gmailUri,
            // Forces it to act as an external link, preventing web-routing issues
            mode: LaunchMode.externalApplication,
          );
        } else if (await canLaunchUrl(mailtoUri)) {
          // Fallback to native mail client if Gmail web fails
          await launchUrl(
            mailtoUri,
            mode: LaunchMode.externalApplication,
          );
        } else {
          _showErrorSnackBar();
        }
      } catch (e) {
        _showErrorSnackBar();
      }
    }
  }

  // Helper method to keep the error handling clean
  void _showErrorSnackBar() {
    if (mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: const Text("Could not open email client. Please email me directly at jadoonsufyan3@gmail.com"),
          backgroundColor: Theme.of(context).colorScheme.error,
          duration: const Duration(seconds: 5),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    return AlertDialog(
      backgroundColor: colorScheme.surface,
      surfaceTintColor: Colors.transparent, // Prevents a weird tint on some Material 3 themes
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(24)),
      title: Text(
        "Let's Work Together",
        style: theme.textTheme.headlineSmall?.copyWith(fontWeight: FontWeight.bold),
      ),
      content: SizedBox(
        width: 450, // Prevents the dialog from stretching too wide on desktop screens
        child: Form(
          key: _formKey,
          child: Column(
            mainAxisSize: MainAxisSize.min, // Hugs the content tightly
            children: [
              Text(
                "Fill out the form below and I'll get back to you as soon as possible.",
                style: TextStyle(color: colorScheme.onSurface.withValues(alpha: 0.6)),
              ),
              const SizedBox(height: 24),

              // 1. Name Field (Optional)
              TextFormField(
                controller: _nameController,
                decoration: _buildInputDecoration("Name (Optional)", Icons.person_outline, colorScheme),
              ),
              const SizedBox(height: 16),

              // 2. Email Field (Required)
              TextFormField(
                controller: _emailController,
                decoration: _buildInputDecoration("Email *", Icons.email_outlined, colorScheme),
                validator: (value) {
                  if (value == null || value.trim().isEmpty) {
                    return 'Email is required';
                  }
                  // Basic Regex to ensure it looks like an email
                  if (!RegExp(r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+").hasMatch(value)) {
                    return 'Enter a valid email address';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16),

              // 3. Description Field (Required)
              TextFormField(
                controller: _descController,
                maxLines: 4,
                decoration: _buildInputDecoration("Project Details *", null, colorScheme).copyWith(
                  alignLabelWithHint: true, // Aligns the label to the top-left for multiline text areas
                ),
                validator: (value) {
                  if (value == null || value.trim().isEmpty) {
                    return 'Please describe your project or inquiry';
                  }
                  return null;
                },
              ),
            ],
          ),
        ),
      ),
      actionsPadding: const EdgeInsets.only(right: 24, bottom: 24),
      actions: [
        // Cancel Button uses Secondary Color
        TextButton(
          onPressed: () => Navigator.pop(context),
          style: TextButton.styleFrom(foregroundColor: colorScheme.secondary),
          child: const Text("Cancel"),
        ),
        // Submit Button uses Primary Color
        ElevatedButton(
          onPressed: _submitForm,
          style: ElevatedButton.styleFrom(
            backgroundColor: colorScheme.primary,
            foregroundColor: colorScheme.onPrimary,
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
          ),
          child: const Text("Send Message", style: TextStyle(fontWeight: FontWeight.bold)),
        ),
      ],
    );
  }

  // Helper method to keep the text fields looking consistent and clean
  InputDecoration _buildInputDecoration(String label, IconData? icon, ColorScheme colorScheme) {
    return InputDecoration(
      labelText: label,
      prefixIcon: icon != null ? Icon(icon, color: colorScheme.onSurface.withValues(alpha: 0.5)) : null,
      border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: BorderSide(color: colorScheme.onSurface.withValues(alpha: 0.2)),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: BorderSide(color: colorScheme.primary, width: 2),
      ),
      errorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: BorderSide(color: colorScheme.error, width: 2),
      ),
    );
  }
}