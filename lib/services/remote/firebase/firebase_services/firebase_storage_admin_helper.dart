import 'dart:io';
import 'package:firebase_storage/firebase_storage.dart';

class FirebaseStorageAdminHelper {
  final FirebaseStorage _storage;

  FirebaseStorageAdminHelper({FirebaseStorage? storage})
      : _storage = storage ?? FirebaseStorage.instance;

  // Upload file with auto-generated subFolderId
  Future<String> uploadFile(
    String folderName,
    String folderId,
    String subFolderName,
    String subFolderId,
    File filePath,
  ) async {
    // String subFolderId = DateTime.now().millisecondsSinceEpoch.toString();
    Reference storageReference =
        _storage.ref('$folderName/$subFolderId');
    UploadTask uploadTask = storageReference.putFile(filePath);
    TaskSnapshot taskSnapshot = await uploadTask.whenComplete(() => null);
    return await taskSnapshot.ref.getDownloadURL();
  }

  // Delete file
  Future<void> deleteFile(
    String folderName,
    String folderId,
    String subFolderName,
    String subFolderId,
  ) async {
    Reference storageReference =
        _storage.ref('$folderName/$subFolderId');
    await storageReference.delete();
  }

  // Get file URL
  Future<String> getFileUrl(
    String folderName,
    String folderId,
    String subFolderName,
    String subFolderId,
  ) async {
    Reference storageReference =
        _storage.ref('$folderName');
    return await storageReference.getDownloadURL();
  }

  // Upload multiple files
  Future<List<String>> uploadMultipleFiles(
    String folderName,
    String folderId,
    String subFolderName,
    List<File> filePaths,
  ) async {
    List<String> downloadUrls = [];
    for (File filePath in filePaths) {
      String subFolderId = DateTime.now().millisecondsSinceEpoch.toString();
      Reference storageReference =
          _storage.ref('$folderName');
      UploadTask uploadTask = storageReference.putFile(filePath);
      TaskSnapshot taskSnapshot = await uploadTask.whenComplete(() => null);
      String downloadUrl = await taskSnapshot.ref.getDownloadURL();
      downloadUrls.add(downloadUrl);
    }
    return downloadUrls;
  }
}
