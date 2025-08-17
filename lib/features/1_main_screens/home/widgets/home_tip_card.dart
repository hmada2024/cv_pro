// lib/features/home/ui/widgets/home_tip_card.dart
import 'package:flutter/material.dart';

class HomeTipCard extends StatelessWidget {
  const HomeTipCard({
    super.key,
    required this.icon,
    required this.title,
    required this.content,
  });

  final IconData icon;
  final String title;
  final String content;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Card(
      child: ListTile(
        leading: Icon(icon, color: theme.colorScheme.secondary),
        title: Text(title, style: theme.textTheme.titleMedium),
        onTap: () {
          showDialog(
            context: context,
            builder: (context) => AlertDialog(
              title: Text(title),
              content: Text(content, style: theme.textTheme.bodyMedium),
              actions: [
                TextButton(
                  onPressed: () => Navigator.of(context).pop(),
                  child: const Text('Got it'),
                )
              ],
            ),
          );
        },
      ),
    );
  }
}
