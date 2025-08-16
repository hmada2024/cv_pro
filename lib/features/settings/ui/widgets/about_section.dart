// lib/features/settings/ui/widgets/about_section.dart
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class AboutSection extends StatelessWidget {
  const AboutSection({super.key});

  void _launchURL(BuildContext context) async {
    // Your Facebook profile URL
    final uri = Uri.parse('https://www.facebook.com/Mohamed.A.Ibrahim1991');

    try {
      // Attempt to launch the URL
      if (await canLaunchUrl(uri)) {
        await launchUrl(uri, mode: LaunchMode.externalApplication);
      } else {
        // Show an error message if it fails
        if (context.mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Could not open the link.')),
          );
        }
      }
    } catch (e) {
      // Catch any potential exceptions
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('An error occurred: $e')),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        leading: const Icon(Icons.facebook),
        title: const Text('Contact Developer'),
        subtitle: const Text('Connect on Facebook'),
        onTap: () => _launchURL(context),
      ),
    );
  }
}
