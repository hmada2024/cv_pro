// lib/features/cv_projects/providers/cv_projects_provider.dart
import 'package:cv_pro/core/di/injector.dart';
import 'package:cv_pro/core/services/storage_service.dart';
import 'package:cv_pro/features/cv_form/data/models/cv_data.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:isar/isar.dart';

class CvProjectsNotifier extends AsyncNotifier<List<CVData>> {
  StorageService get _storageService => ref.read(storageServiceProvider);
  Isar get _isar => ref.read(isarProvider);

  @override
  Future<List<CVData>> build() async {
    return _storageService.getAllCVs();
  }

  Future<int> createNewProject(String projectName) async {
    state = const AsyncValue.loading();
    final newCv = CVData.initial(projectName);
    final newId = await _storageService.saveCV(newCv);
    ref.invalidateSelf();
    await future;
    return newId;
  }

  Future<void> deleteProject(int id) async {
    state = const AsyncValue.loading();
    await _storageService.deleteCV(id);
    ref.invalidateSelf();
    await future;
  }

  // New function to delete ALL projects from the database.
  Future<void> deleteAllProjects() async {
    state = const AsyncValue.loading();
    await _isar.writeTxn(() => _isar.cVDatas.clear());
    ref.invalidateSelf();
    await future;
  }

  Future<CVData?> getProjectById(int id) async {
    return _storageService.loadCV(id);
  }

  Future<bool> isProjectNameTaken(String name) async {
    final existing =
        await _isar.cVDatas.where().projectNameEqualTo(name).findFirst();
    return existing != null;
  }
}

final cvProjectsProvider =
    AsyncNotifierProvider<CvProjectsNotifier, List<CVData>>(
  CvProjectsNotifier.new,
);
