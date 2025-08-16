// lib/features/history/data/providers/cv_history_provider.dart
import 'package:cv_pro/core/di/injector.dart';
import 'package:cv_pro/features/cv_form/data/models/cv_data.dart';
import 'package:cv_pro/features/cv_form/data/providers/cv_form_provider.dart';
import 'package:cv_pro/features/history/data/models/cv_history.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:isar/isar.dart';

class CvHistoryNotifier extends AsyncNotifier<List<CVHistory>> {
  @override
  Future<List<CVHistory>> build() async {
    final isar = ref.watch(isarProvider);
    return isar.cVHistorys.where().sortByCreatedAtDesc().findAll();
  }

  Future<void> addHistoryEntry(CVData liveCV) async {
    final isar = ref.read(isarProvider);
    final name = liveCV.personalInfo.name.isNotEmpty
        ? liveCV.personalInfo.name.split(' ').first
        : 'user';
    final job = liveCV.personalInfo.jobTitle.isNotEmpty
        ? liveCV.personalInfo.jobTitle
        : 'CV';

    // تنظيف الاسم من المحارف غير المرغوب فيها
    final cleanJob = job.replaceAll(RegExp(r'[^a-zA-Z0-9\s-]'), '').trim();

    final displayName = 'cv $name - $cleanJob'.toLowerCase();

    final historyEntry = CVHistory.fromCVData(liveCV, displayName);

    await isar.writeTxn(() => isar.cVHistorys.put(historyEntry));
    ref.invalidateSelf();
    await future;
  }

  Future<void> deleteHistoryEntry(int historyId) async {
    final isar = ref.read(isarProvider);
    await isar.writeTxn(() => isar.cVHistorys.delete(historyId));
    ref.invalidateSelf();
    await future;
  }

  Future<void> loadHistoryEntry(int historyId) async {
    final isar = ref.read(isarProvider);
    final historyEntry = await isar.cVHistorys.get(historyId);
    if (historyEntry != null) {
      final cvData = CVData.fromHistory(historyEntry);
      ref.read(cvFormProvider.notifier).loadFromHistory(cvData);
    }
  }

  Future<CVHistory?> getHistoryById(int historyId) async {
    final isar = ref.read(isarProvider);
    return await isar.cVHistorys.get(historyId);
  }
}

final cvHistoryProvider =
    AsyncNotifierProvider<CvHistoryNotifier, List<CVHistory>>(
  CvHistoryNotifier.new,
);
