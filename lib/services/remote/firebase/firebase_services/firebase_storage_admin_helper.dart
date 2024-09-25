import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';

class FirebaseStorageAdminHelper {
  final FirebaseStorage _storage;

  FirebaseStorageAdminHelper({FirebaseStorage? storage})
      : _storage = storage ?? FirebaseStorage.instance;

  Future<String> uploadFile(
    String folderName,
    String folderId,
    String subFolderName,
    String subFolderId,
    File filePath,
  ) async {
    Reference storageReference =
        _storage.ref('$folderName/$folderId/$subFolderName/$subFolderId');
    UploadTask uploadTask = storageReference.putFile(filePath);
    TaskSnapshot taskSnapshot = await uploadTask.whenComplete(() => null);
    return await taskSnapshot.ref.getDownloadURL();
  }

  Future<void> deleteFile(
    String folderName,
    String folderId,
    String subFolderName,
    String subFolderId,
  ) async {
    Reference storageReference =
        _storage.ref('$folderName/$folderId/$subFolderName/$subFolderId');
    await storageReference.delete();
  }

  Future<String> getFileUrl(
    String folderName,
    String folderId,
    String subFolderName,
    String subFolderId,
  ) async {
    Reference storageReference =
        _storage.ref('$folderName/$folderId/$subFolderName/$subFolderId');
    return await storageReference.getDownloadURL();
  }
}
