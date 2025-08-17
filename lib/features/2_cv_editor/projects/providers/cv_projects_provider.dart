// lib/features/cv_projects/providers/cv_projects_provider.dart
import 'dart:async';
import 'package:cv_pro/core/di/injector.dart';
import 'package:cv_pro/core/services/storage_service.dart';
import 'package:cv_pro/features/2_cv_editor/form/data/models/cv_data.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:isar/isar.dart';

class CvProjectsNotifier extends AsyncNotifier<List<CVData>> {
  StorageService get _storageService => ref.read(storageServiceProvider);
  Isar get _isar => ref.read(isarProvider);
  CVData? _lastDeleted;
  Timer? _deletionTimer;

  @override
  Future<List<CVData>> build() async {
    _lastDeleted = null;
    _deletionTimer?.cancel();
    return _storageService.getAllCVs();
  }

  Future<void> _confirmDeletion(int id) async {
    try {
      await _storageService.deleteCV(id);
    } catch (e) {
      debugPrint("Failed to confirm deletion for CV ID $id: $e");
    }
    _lastDeleted = null;
  }

  void markProjectForDeletion(int id) {
    if (_lastDeleted != null) {
      _confirmDeletion(_lastDeleted!.id);
    }
    _deletionTimer?.cancel();

    final currentProjects = state.valueOrNull ?? [];
    final projectToDelete = currentProjects.firstWhere((p) => p.id == id,
        orElse: () => CVData.initial(''));

    if (projectToDelete.projectName.isEmpty) return; // Not found

    _lastDeleted = projectToDelete;
    final updatedList = currentProjects.where((p) => p.id != id).toList();
    state = AsyncData(updatedList);

    _deletionTimer = Timer(const Duration(seconds: 5), () {
      if (_lastDeleted != null && _lastDeleted!.id == id) {
        _confirmDeletion(id);
      }
    });
  }

  void undoDeletion() {
    _deletionTimer?.cancel();
    if (_lastDeleted != null) {
      final currentProjects = state.valueOrNull ?? [];
      state = AsyncData([...currentProjects, _lastDeleted!])
        ..value.sort((a, b) => b.lastModified.compareTo(a.lastModified));
      _lastDeleted = null;
    }
  }

  Future<int> createNewProject(String projectName) async {
    state = const AsyncValue.loading();
    try {
      final newCv = CVData.initial(projectName);
      final newId = await _storageService.saveCV(newCv);
      ref.invalidateSelf();
      await future;
      return newId;
    } catch (e, s) {
      state = AsyncValue.error(e, s);
      rethrow;
    }
  }

  Future<void> deleteAllProjects() async {
    state = const AsyncValue.loading();
    try {
      await _isar.writeTxn(() => _isar.cVDatas.clear());
      ref.invalidateSelf();
      await future;
    } catch (e, s) {
      state = AsyncValue.error(e, s);
    }
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
