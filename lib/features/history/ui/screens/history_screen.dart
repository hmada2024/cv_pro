// lib/features/history/ui/screens/history_screen.dart
import 'package:cv_pro/core/constants/app_sizes.dart';
import 'package:cv_pro/core/widgets/empty_state_widget.dart';
import 'package:cv_pro/features/history/data/providers/cv_history_provider.dart';
import 'package:cv_pro/features/history/ui/widgets/history_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class HistoryScreen extends ConsumerWidget {
  const HistoryScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final historyState = ref.watch(cvHistoryProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('CV History'),
      ),
      body: historyState.when(
        data: (historyList) {
          if (historyList.isEmpty) {
            return const Center(
              child: Padding(
                padding: EdgeInsets.all(AppSizes.p24),
                child: EmptyStateWidget(
                  icon: Icons.history_toggle_off,
                  title: 'No History Yet',
                  subtitle:
                      'Preview or export your CV to automatically save a version here.',
                ),
              ),
            );
          }
          return ListView.builder(
            padding: const EdgeInsets.all(AppSizes.p16),
            itemCount: historyList.length,
            itemBuilder: (context, index) {
              final historyEntry = historyList[index];
              return HistoryCard(history: historyEntry);
            },
          );
        },
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (error, stack) => Center(
          child: Text('An error occurred: $error'),
        ),
      ),
    );
  }
}
