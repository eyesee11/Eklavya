import 'dart:io';
import 'dart:typed_data';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart' as path;
import '../errors/exceptions.dart';
import '../constants/app_constants.dart';

/// Utility class for file operations
class FileUtils {
  /// Get application documents directory
  static Future<Directory> getAppDocumentsDirectory() async {
    try {
      return await getApplicationDocumentsDirectory();
    } catch (e) {
      throw FileException(
        message: 'Failed to get documents directory: $e',
        code: 'DOCS_DIR_ERROR',
      );
    }
  }

  /// Get temporary directory
  static Future<Directory> getTempDirectory() async {
    try {
      return await getTemporaryDirectory();
    } catch (e) {
      throw FileException(
        message: 'Failed to get temporary directory: $e',
        code: 'TEMP_DIR_ERROR',
      );
    }
  }

  /// Create videos directory
  static Future<Directory> createVideosDirectory() async {
    try {
      final appDir = await getAppDocumentsDirectory();
      final videosDir = Directory(path.join(appDir.path, AppConstants.videosDirectory));
      
      if (!await videosDir.exists()) {
        await videosDir.create(recursive: true);
      }
      
      return videosDir;
    } catch (e) {
      throw FileException(
        message: 'Failed to create videos directory: $e',
        code: 'CREATE_DIR_ERROR',
      );
    }
  }

  /// Create models directory
  static Future<Directory> createModelsDirectory() async {
    try {
      final appDir = await getAppDocumentsDirectory();
      final modelsDir = Directory(path.join(appDir.path, AppConstants.modelsDirectory));
      
      if (!await modelsDir.exists()) {
        await modelsDir.create(recursive: true);
      }
      
      return modelsDir;
    } catch (e) {
      throw FileException(
        message: 'Failed to create models directory: $e',
        code: 'CREATE_DIR_ERROR',
      );
    }
  }

  /// Generate unique filename for video
  static String generateVideoFileName({String? prefix, String? suffix}) {
    final timestamp = DateTime.now().millisecondsSinceEpoch;
    final baseFilename = 'video_$timestamp';
    
    String filename = baseFilename;
    if (prefix != null) filename = '${prefix}_$filename';
    if (suffix != null) filename = '${filename}_$suffix';
    
    return '$filename.${AppConstants.videoFormat}';
  }

  /// Get file size in bytes
  static Future<int> getFileSize(String filePath) async {
    try {
      final file = File(filePath);
      if (!await file.exists()) {
        throw FileException(
          message: 'File does not exist',
          code: 'FILE_NOT_FOUND',
          filePath: filePath,
        );
      }
      return await file.length();
    } catch (e) {
      throw FileException(
        message: 'Failed to get file size: $e',
        code: 'FILE_SIZE_ERROR',
        filePath: filePath,
      );
    }
  }

  /// Get file size in human readable format
  static String getFileSizeFormatted(int bytes) {
    if (bytes < 1024) return '$bytes B';
    if (bytes < 1024 * 1024) return '${(bytes / 1024).toStringAsFixed(1)} KB';
    if (bytes < 1024 * 1024 * 1024) return '${(bytes / (1024 * 1024)).toStringAsFixed(1)} MB';
    return '${(bytes / (1024 * 1024 * 1024)).toStringAsFixed(1)} GB';
  }

  /// Check if file exists
  static Future<bool> fileExists(String filePath) async {
    try {
      final file = File(filePath);
      return await file.exists();
    } catch (e) {
      return false;
    }
  }

  /// Delete file
  static Future<bool> deleteFile(String filePath) async {
    try {
      final file = File(filePath);
      if (await file.exists()) {
        await file.delete();
        return true;
      }
      return false;
    } catch (e) {
      throw FileException(
        message: 'Failed to delete file: $e',
        code: 'DELETE_ERROR',
        filePath: filePath,
      );
    }
  }

  /// Copy file
  static Future<String> copyFile(String sourcePath, String destinationPath) async {
    try {
      final sourceFile = File(sourcePath);
      if (!await sourceFile.exists()) {
        throw FileException(
          message: 'Source file does not exist',
          code: 'SOURCE_NOT_FOUND',
          filePath: sourcePath,
        );
      }

      final destinationFile = await sourceFile.copy(destinationPath);
      return destinationFile.path;
    } catch (e) {
      throw FileException(
        message: 'Failed to copy file: $e',
        code: 'COPY_ERROR',
        filePath: sourcePath,
      );
    }
  }

  /// Move file
  static Future<String> moveFile(String sourcePath, String destinationPath) async {
    try {
      final sourceFile = File(sourcePath);
      if (!await sourceFile.exists()) {
        throw FileException(
          message: 'Source file does not exist',
          code: 'SOURCE_NOT_FOUND',
          filePath: sourcePath,
        );
      }

      final destinationFile = await sourceFile.rename(destinationPath);
      return destinationFile.path;
    } catch (e) {
      throw FileException(
        message: 'Failed to move file: $e',
        code: 'MOVE_ERROR',
        filePath: sourcePath,
      );
    }
  }

  /// Write bytes to file
  static Future<String> writeBytesToFile(Uint8List bytes, String fileName) async {
    try {
      final tempDir = await getTempDirectory();
      final filePath = path.join(tempDir.path, fileName);
      final file = File(filePath);
      
      await file.writeAsBytes(bytes);
      return filePath;
    } catch (e) {
      throw FileException(
        message: 'Failed to write bytes to file: $e',
        code: 'WRITE_ERROR',
      );
    }
  }

  /// Read file as bytes
  static Future<Uint8List> readFileAsBytes(String filePath) async {
    try {
      final file = File(filePath);
      if (!await file.exists()) {
        throw FileException(
          message: 'File does not exist',
          code: 'FILE_NOT_FOUND',
          filePath: filePath,
        );
      }
      
      return await file.readAsBytes();
    } catch (e) {
      throw FileException(
        message: 'Failed to read file: $e',
        code: 'READ_ERROR',
        filePath: filePath,
      );
    }
  }

  /// Get file extension
  static String getFileExtension(String filePath) {
    return path.extension(filePath).toLowerCase();
  }

  /// Get filename without extension
  static String getFileNameWithoutExtension(String filePath) {
    return path.basenameWithoutExtension(filePath);
  }

  /// Validate video file
  static bool isValidVideoFile(String filePath) {
    final extension = getFileExtension(filePath);
    const validExtensions = ['.mp4', '.mov', '.avi', '.mkv'];
    return validExtensions.contains(extension);
  }

  /// Clean up temporary files older than specified duration
  static Future<void> cleanupTempFiles({Duration maxAge = const Duration(days: 7)}) async {
    try {
      final tempDir = await getTempDirectory();
      final cutoffTime = DateTime.now().subtract(maxAge);
      
      await for (final entity in tempDir.list()) {
        if (entity is File) {
          final stat = await entity.stat();
          if (stat.modified.isBefore(cutoffTime)) {
            await entity.delete();
          }
        }
      }
    } catch (e) {
      // Silently handle cleanup errors
    }
  }
}
