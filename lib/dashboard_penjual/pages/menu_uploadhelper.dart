import 'dart:typed_data';
import 'package:file_picker/file_picker.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

final supabase = Supabase.instance.client;

Future<String?> pickAndUploadToSupabase() async {
  // 1. pilih file gambar
  final result = await FilePicker.platform.pickFiles(
    type: FileType.image,
    withData: true,
  );

  if (result == null) return null; // user batal

  final file = result.files.single;
  final Uint8List? bytes = file.bytes;
  if (bytes == null) return null;

  final fileName =
      '${DateTime.now().millisecondsSinceEpoch}_${file.name}'; // nama unik

  // 2. upload ke bucket 'menus'
  final uploadRes = await supabase.storage.from('menus').uploadBinary(
        fileName,
        bytes,
        fileOptions: const FileOptions(
          cacheControl: '3600',
          upsert: false,
          contentType: 'image/jpeg', // aman buat kebanyakan gambar
        ),
      );

  // kalau error, Supabase bakal lempar exception
  // uploadRes isinya path, tapi kita lebih butuh URL publiK

  // 3. ambil public URL
  final publicUrl =
      supabase.storage.from('menus').getPublicUrl(fileName);

  return publicUrl; // ini yang nanti disimpan ke Firestore
}
