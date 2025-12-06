import 'dart:typed_data';
import 'package:path/path.dart' as p;
import 'package:supabase_flutter/supabase_flutter.dart';

class MenuUploadHelper {
  // ✅ JANGAN pake static final yg langsung akses instance
  //    Bikin getter biar di-evaluasi setelah Supabase.initialize dipanggil.
  static SupabaseClient get _client => Supabase.instance.client;

  static const String _bucketName = 'menus'; // bucket kamu

  /// Upload gambar ke Supabase Storage
  /// return: public URL
  static Future<String> uploadImage(
    Uint8List bytes,
    String originalName,
  ) async {
    // ambil ekstensi file
    final ext = p.extension(originalName).toLowerCase();
    // nama file unik
    final fileName =
        '${DateTime.now().millisecondsSinceEpoch}${ext.isEmpty ? ".jpg" : ext}';

    final filePath = 'uploads/$fileName';

    // upload
    await _client.storage.from(_bucketName).uploadBinary(
          filePath,
          bytes,
          fileOptions: const FileOptions(
            cacheControl: '3600',
            upsert: false,
            contentType: 'image/*',
          ),
        );

    // public URL
    final publicUrl = _client.storage.from(_bucketName).getPublicUrl(filePath);

    return publicUrl;
  }
}
