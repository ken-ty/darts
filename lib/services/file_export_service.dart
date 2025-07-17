import 'dart:io';
import 'dart:typed_data';

import 'package:file_picker/file_picker.dart';

class FileExportService {
  /// ファイルを保存する（UI操作）
  Future<String?> saveFile({
    required String fileName,
    required Uint8List bytes,
    required String dialogTitle,
    String errorMessage = 'Failed to save file',
  }) async {
    try {
      return await FilePicker.platform.saveFile(
        dialogTitle: dialogTitle,
        fileName: fileName,
        type: FileType.custom,
        allowedExtensions: ['json'],
        bytes: bytes,
      );
    } catch (e) {
      throw Exception('$errorMessage: $e');
    }
  }

  /// ファイルを選択して読み込む（UI操作）
  Future<Uint8List?> pickFile({
    required String dialogTitle,
    String errorMessage = 'Failed to pick file',
  }) async {
    try {
      final result = await FilePicker.platform.pickFiles(
        dialogTitle: dialogTitle,
        type: FileType.custom,
        allowedExtensions: ['json'],
      );

      if (result?.files.isNotEmpty == true) {
        final file = File(result!.files.first.path!);
        return await file.readAsBytes();
      }
      return null;
    } catch (e) {
      throw Exception('$errorMessage: $e');
    }
  }
}
