import 'dart:typed_data';

import 'package:file_picker/file_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:fusion_app_store/app/store/domain/entities/app_entity.dart';
import 'package:fusion_app_store/app/store/domain/entities/models/supported_platform.dart';
import 'package:fusion_app_store/core/logging/logger.dart';

class Storage {
  Storage._();

  static final storage = FirebaseStorage.instance;
  static final storageRef = storage.ref();

  static final Map<String, Uint8List> _fetchedDataMap = {};

  static Future<void> deleteFolder({required String path}) async {
    List<String> paths = [];
    paths = await _deleteFolder(path, paths);
    for (String path in paths) {
      await storageRef.child(path).delete();
    }
  }

  static Future<List<String>> _deleteFolder(
      String folder, List<String> paths) async {
    ListResult list = await storageRef.child(folder).listAll();
    List<Reference> items = list.items;
    List<Reference> prefixes = list.prefixes;
    for (Reference item in items) {
      paths.add(item.fullPath);
    }
    for (Reference subfolder in prefixes) {
      paths = await _deleteFolder(subfolder.fullPath, paths);
    }
    return paths;
  }

  static Future<void> delete({required String path}) async {
    return await storageRef.child(path).delete();
  }

  static Future<String> getDownloadUrl({required String path}) async {
    return await storageRef.child(path).getDownloadURL();
  }

  static Future<Uint8List?> getData({required String path}) async {
    if (_fetchedDataMap.containsKey(path)) {
      prettyLog(value: 'Providing cached resource: $path', tag: 'Storage');
      return _fetchedDataMap[path];
    }
    final bytes = await storageRef.child(path).getData();
    _fetchedDataMap[path] = bytes!;
    return bytes;
  }

  static Future<void> uploadBytes({
    required Uint8List bytes,
    required StorageInfo storageInfo,
  }) async {
    final ref = storageRef.child(storageInfo.path);
    await ref.putData(bytes, storageInfo.metadata);
  }

  static StorageInfo toIconStorage(AppEntity appEntity) {
    return StorageInfo(
      path: "${appEntity.maintainer}/${appEntity.packageID}/app-icon.png",
      metadata: SettableMetadata(
        contentType: 'image/png',
      ),
    );
  }

  static StorageInfo toImageStorage(AppEntity appEntity, String name) {
    return StorageInfo(
      path: "${appEntity.maintainer}/${appEntity.packageID}/images/$name",
      metadata: SettableMetadata(
        contentType: 'image/png',
      ),
    );
  }

  static StorageInfo toBundleStorage(
      AppEntity appEntity, PlatformType type, String name) {
    return StorageInfo(
      path:
          "${appEntity.maintainer}/${appEntity.packageID}/${type.name}/bundles/$name",
    );
  }

  static Future<void> pickFiles({
    required void Function(List<PlatformFile> files) onDone,
    String? dialogTitle,
    bool allowMultiple = false,
    FileType fileType = FileType.custom,
    List<String>? allowedExtensions,
  }) async {
    final result = await FilePicker.platform.pickFiles(
      allowedExtensions: allowedExtensions,
      allowMultiple: allowMultiple,
      dialogTitle: dialogTitle,
      readSequential: true,
      lockParentWindow: true,
      type: fileType,
    );
    if (result != null && result.files.isNotEmpty) {
      final files = result.files;
      onDone(files);
    } else {
      prettyLog(value: ">> No Selection Made");
    }
    onDone([]);
  }
}

class StorageInfo {
  final String path;
  final SettableMetadata? metadata;

  StorageInfo({
    required this.path,
    this.metadata,
  });
}
