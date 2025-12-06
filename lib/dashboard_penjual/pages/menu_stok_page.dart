import 'dart:typed_data';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:food_delivery/common/menu_upload_helper.dart';

class MenuStokPage extends StatelessWidget {
  const MenuStokPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'Daftar Menu & Stok',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.w700,
              ),
            ),
            Text(
              'Sabtu, 29 November 2025',
              style: TextStyle(
                fontSize: 12,
                color: Color(0xff6b7280),
              ),
            ),
          ],
        ),
        const SizedBox(height: 18),
        Row(
          children: [
            const Expanded(
              child: Text(
                'Atur Menu',
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
            ElevatedButton.icon(
              onPressed: () {
                _showTambahMenuDialog(context);
              },
              icon: const Icon(Icons.add, size: 18),
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xff16a34a),
                foregroundColor: Colors.white,
                elevation: 0,
                padding:
                    const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(999),
                ),
              ),
              label: const Text(
                'Tambah Menu Baru',
                style: TextStyle(fontSize: 13),
              ),
            ),
          ],
        ),
        const SizedBox(height: 16),
        Expanded(
          child: StreamBuilder<QuerySnapshot>(
            stream: FirebaseFirestore.instance
                .collection('menus')
                .orderBy('createdAt', descending: true)
                .snapshots(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(child: CircularProgressIndicator());
              }

              if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
                return const Center(
                  child: Text('Belum ada menu, coba tambah dulu 😄'),
                );
              }

              final docs = snapshot.data!.docs;

              return GridView.builder(
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 3,
                  mainAxisSpacing: 16,
                  crossAxisSpacing: 16,
                  childAspectRatio: 4 / 3.2,
                ),
                itemCount: docs.length,
                itemBuilder: (context, index) {
                  final doc = docs[index];
                  final data = doc.data() as Map<String, dynamic>;

                  final String name = data['name'] ?? '';
                  final String category = data['category'] ?? '';
                  final int price = (data['price'] ?? 0) as int;
                  final bool available = data['available'] ?? true;
                  final String imageUrl =
                      (data['image'] as String?) ??
                          'https://picsum.photos/seed/${doc.id}/400/250';

                  return Opacity(
                    opacity: available ? 1 : 0.4,
                    child: Card(
                      elevation: 3,
                      shadowColor: Colors.black.withOpacity(0.08),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(18),
                      ),
                      clipBehavior: Clip.antiAlias,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Expanded(
                            child: Stack(
                              fit: StackFit.expand,
                              children: [
                                Image.network(
                                  imageUrl,
                                  fit: BoxFit.cover,
                                  errorBuilder: (context, error, stackTrace) {
                                    return Container(
                                      color: const Color(0xfff3f4f6),
                                      child: const Center(
                                        child: Icon(
                                          Icons.broken_image_outlined,
                                          color: Color(0xff9ca3af),
                                        ),
                                      ),
                                    );
                                  },
                                ),
                                if (!available)
                                  Container(
                                    color: Colors.black.withOpacity(0.4),
                                  ),
                                Positioned(
                                  left: 10,
                                  top: 10,
                                  child: Container(
                                    padding: const EdgeInsets.symmetric(
                                      horizontal: 8,
                                      vertical: 4,
                                    ),
                                    decoration: BoxDecoration(
                                      color: Colors.black.withOpacity(0.55),
                                      borderRadius: BorderRadius.circular(999),
                                    ),
                                    child: Row(
                                      children: [
                                        const Icon(
                                          Icons.visibility,
                                          size: 14,
                                          color: Colors.white,
                                        ),
                                        const SizedBox(width: 4),
                                        Text(
                                          available ? 'Aktif' : 'Nonaktif',
                                          style: const TextStyle(
                                            fontSize: 11,
                                            color: Colors.white,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                                Positioned(
                                  right: 0,
                                  top: 0,
                                  child: PopupMenuButton<String>(
                                    icon: const Icon(
                                      Icons.more_vert,
                                      color: Colors.white,
                                    ),
                                    onSelected: (value) {
                                      if (value == 'edit') {
                                        _showEditMenuDialog(
                                          context,
                                          doc.id,
                                          data,
                                        );
                                      } else if (value == 'delete') {
                                        _confirmDelete(context, doc.id);
                                      }
                                    },
                                    itemBuilder: (context) => const [
                                      PopupMenuItem(
                                        value: 'edit',
                                        child: Text('Edit'),
                                      ),
                                      PopupMenuItem(
                                        value: 'delete',
                                        child: Text('Hapus'),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(12),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  name,
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                  style: const TextStyle(
                                    fontSize: 14,
                                    fontWeight: FontWeight.w700,
                                  ),
                                ),
                                const SizedBox(height: 4),
                                Row(
                                  children: [
                                    Container(
                                      padding: const EdgeInsets.symmetric(
                                        horizontal: 8,
                                        vertical: 3,
                                      ),
                                      decoration: BoxDecoration(
                                        color: const Color(0xffeff6ff),
                                        borderRadius: BorderRadius.circular(999),
                                      ),
                                      child: Text(
                                        category,
                                        style: const TextStyle(
                                          fontSize: 10,
                                          color: Color(0xff1d4ed8),
                                          fontWeight: FontWeight.w500,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                                const SizedBox(height: 6),
                                Row(
                                  children: [
                                    Expanded(
                                      child: Text(
                                        'Rp $price',
                                        style: const TextStyle(
                                          fontSize: 13,
                                          fontWeight: FontWeight.w700,
                                        ),
                                      ),
                                    ),
                                    Switch(
                                      value: available,
                                      onChanged: (value) async {
                                        await FirebaseFirestore.instance
                                            .collection('menus')
                                            .doc(doc.id)
                                            .update({'available': value});
                                      },
                                      activeColor: const Color(0xff16a34a),
                                      materialTapTargetSize:
                                          MaterialTapTargetSize.shrinkWrap,
                                    ),
                                  ],
                                ),
                                const SizedBox(height: 2),
                                Text(
                                  available ? 'Tersedia' : 'Stok Habis',
                                  style: TextStyle(
                                    fontSize: 11,
                                    fontWeight: FontWeight.w500,
                                    color: available
                                        ? const Color(0xff16a34a)
                                        : const Color(0xffb91c1c),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              );
            },
          ),
        ),
      ],
    );
  }
}

/// ========= DIALOG TAMBAH MENU BARU =========

void _showTambahMenuDialog(BuildContext context) {
  final nameController = TextEditingController();
  final categoryController = TextEditingController();
  final priceController = TextEditingController();
  final imageUrlController = TextEditingController();

  bool isSaving = false;
  bool isUploading = false;

  showDialog(
    context: context,
    barrierDismissible: false,
    builder: (context) {
      return StatefulBuilder(
        builder: (context, setState) {
          return Dialog(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(24),
            ),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 18),
              child: SingleChildScrollView(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Container(
                          padding: const EdgeInsets.all(8),
                          decoration: BoxDecoration(
                            color: const Color(0xffecfdf3),
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: const Icon(
                            Icons.restaurant_menu,
                            size: 22,
                            color: Color(0xff16a34a),
                          ),
                        ),
                        const SizedBox(width: 10),
                        const Text(
                          'Tambah Menu Baru',
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 16),

                    const Text(
                      'Nama Menu',
                      style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    const SizedBox(height: 4),
                    TextField(
                      controller: nameController,
                      decoration:
                          _inputDecoration('Contoh: Nasi Goreng Spesial'),
                    ),
                    const SizedBox(height: 12),

                    const Text(
                      'Kategori',
                      style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    const SizedBox(height: 4),
                    TextField(
                      controller: categoryController,
                      decoration: _inputDecoration('Contoh: Aneka Nasi'),
                    ),
                    const SizedBox(height: 12),

                    const Text(
                      'Harga (angka saja)',
                      style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    const SizedBox(height: 4),
                    TextField(
                      controller: priceController,
                      keyboardType: TextInputType.number,
                      decoration: _inputDecoration('25000'),
                    ),
                    const SizedBox(height: 12),

                    const Text(
                      'URL Gambar (optional)',
                      style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    const SizedBox(height: 4),
                    TextField(
                      controller: imageUrlController,
                      decoration: _inputDecoration(
                        'Tempel URL gambar (misal dari Imgur / Cloudinary)',
                      ),
                    ),
                    const SizedBox(height: 8),

                    // Tombol upload ke Supabase
                    Align(
                      alignment: Alignment.centerLeft,
                      child: ElevatedButton.icon(
                        onPressed: isUploading
                            ? null
                            : () async {
                                try {
                                  setState(() {
                                    isUploading = true;
                                  });

                                  final result =
                                      await FilePicker.platform.pickFiles(
                                    type: FileType.image,
                                    withData: true,
                                  );

                                  if (result == null ||
                                      result.files.single.bytes == null) {
                                    setState(() {
                                      isUploading = false;
                                    });
                                    return;
                                  }

                                  final Uint8List bytes =
                                      result.files.single.bytes!;
                                  final String fileName =
                                      result.files.single.name;

                                  await _uploadImageToSupabase(
                                    context,
                                    bytes,
                                    fileName,
                                    imageUrlController,
                                  );
                                } finally {
                                  setState(() {
                                    isUploading = false;
                                  });
                                }
                              },
                        icon: isUploading
                            ? const SizedBox(
                                height: 16,
                                width: 16,
                                child: CircularProgressIndicator(
                                  strokeWidth: 2,
                                  valueColor:
                                      AlwaysStoppedAnimation(Colors.white),
                                ),
                              )
                            : const Icon(Icons.cloud_upload_outlined, size: 18),
                        label: const Text(
                          'Upload gambar ke Supabase',
                          style: TextStyle(fontSize: 12),
                        ),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color(0xffe5f2ff),
                          foregroundColor: const Color(0xff1d4ed8),
                          elevation: 0,
                          padding: const EdgeInsets.symmetric(
                            horizontal: 12,
                            vertical: 8,
                          ),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(999),
                          ),
                        ),
                      ),
                    ),

                    const SizedBox(height: 16),

                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        TextButton(
                          onPressed: isSaving
                              ? null
                              : () {
                                  Navigator.pop(context);
                                },
                          child: const Text('Batal'),
                        ),
                        const SizedBox(width: 6),
                        ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: const Color(0xff16a34a),
                            foregroundColor: Colors.white,
                            elevation: 0,
                            padding: const EdgeInsets.symmetric(
                                horizontal: 20, vertical: 10),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(999),
                            ),
                          ),
                          onPressed: isSaving
                              ? null
                              : () async {
                                  final name = nameController.text.trim();
                                  final category =
                                      categoryController.text.trim();
                                  final price = int.tryParse(
                                          priceController.text.trim()) ??
                                      0;
                                  final imageUrl =
                                      imageUrlController.text.trim();

                                  if (name.isEmpty || category.isEmpty) {
                                    ScaffoldMessenger.of(context).showSnackBar(
                                      const SnackBar(
                                        content: Text(
                                            'Nama & kategori tidak boleh kosong'),
                                      ),
                                    );
                                    return;
                                  }

                                  try {
                                    setState(() {
                                      isSaving = true;
                                    });

                                    await FirebaseFirestore.instance
                                        .collection('menus')
                                        .add({
                                      'name': name,
                                      'category': category,
                                      'price': price,
                                      'available': true,
                                      'image': imageUrl.isEmpty
                                          ? null
                                          : imageUrl,
                                      'createdAt':
                                          FieldValue.serverTimestamp(),
                                    });

                                    if (Navigator.canPop(context)) {
                                      Navigator.pop(context);
                                    }
                                  } catch (e) {
                                    setState(() {
                                      isSaving = false;
                                    });
                                    ScaffoldMessenger.of(context).showSnackBar(
                                      SnackBar(
                                        content: Text(
                                            'Gagal menyimpan menu: $e'),
                                      ),
                                    );
                                  }
                                },
                          child: isSaving
                              ? const SizedBox(
                                  height: 18,
                                  width: 18,
                                  child: CircularProgressIndicator(
                                    strokeWidth: 2,
                                    valueColor:
                                        AlwaysStoppedAnimation(Colors.white),
                                  ),
                                )
                              : const Text('Simpan'),
                        ),
                      ],
                    )
                  ],
                ),
              ),
            ),
          );
        },
      );
    },
  );
}

/// ========= DIALOG EDIT MENU =========

void _showEditMenuDialog(
    BuildContext context, String docId, Map<String, dynamic> data) {
  final nameController = TextEditingController(text: data['name'] ?? '');
  final categoryController =
      TextEditingController(text: data['category'] ?? '');
  final priceController =
      TextEditingController(text: (data['price'] ?? 0).toString());
  final imageController = TextEditingController(text: data['image'] ?? '');

  bool isSaving = false;

  showDialog(
    context: context,
    barrierDismissible: false,
    builder: (context) {
      return StatefulBuilder(
        builder: (context, setState) {
          return Dialog(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(24),
            ),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 18),
              child: SingleChildScrollView(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Container(
                          padding: const EdgeInsets.all(8),
                          decoration: BoxDecoration(
                            color: const Color(0xfffffbeb),
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: const Icon(
                            Icons.edit,
                            size: 22,
                            color: Color(0xfff97316),
                          ),
                        ),
                        const SizedBox(width: 10),
                        const Text(
                          'Edit Menu',
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 16),

                    const Text(
                      'Nama Menu',
                      style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    const SizedBox(height: 4),
                    TextField(
                      controller: nameController,
                      decoration: _inputDecoration('Nama menu'),
                    ),
                    const SizedBox(height: 12),

                    const Text(
                      'Kategori',
                      style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    const SizedBox(height: 4),
                    TextField(
                      controller: categoryController,
                      decoration: _inputDecoration('Kategori'),
                    ),
                    const SizedBox(height: 12),

                    const Text(
                      'Harga (angka saja)',
                      style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    const SizedBox(height: 4),
                    TextField(
                      controller: priceController,
                      keyboardType: TextInputType.number,
                      decoration: _inputDecoration('25000'),
                    ),
                    const SizedBox(height: 12),

                    const Text(
                      'URL Gambar (optional)',
                      style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    const SizedBox(height: 4),
                    TextField(
                      controller: imageController,
                      decoration: _inputDecoration(
                          'Tempel URL gambar kalau mau ganti'),
                    ),
                    const SizedBox(height: 16),

                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        TextButton(
                          onPressed: isSaving
                              ? null
                              : () {
                                  Navigator.pop(context);
                                },
                          child: const Text('Batal'),
                        ),
                        const SizedBox(width: 6),
                        ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: const Color(0xff2563eb),
                            foregroundColor: Colors.white,
                            elevation: 0,
                            padding: const EdgeInsets.symmetric(
                                horizontal: 20, vertical: 10),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(999),
                            ),
                          ),
                          onPressed: isSaving
                              ? null
                              : () async {
                                  final name = nameController.text.trim();
                                  final category =
                                      categoryController.text.trim();
                                  final price = int.tryParse(
                                          priceController.text.trim()) ??
                                      0;
                                  final imageUrl = imageController.text.trim();

                                  if (name.isEmpty || category.isEmpty) {
                                    ScaffoldMessenger.of(context).showSnackBar(
                                      const SnackBar(
                                        content: Text(
                                            'Nama & kategori tidak boleh kosong'),
                                      ),
                                    );
                                    return;
                                  }

                                  isSaving = true;
                                  setState(() {});

                                  await FirebaseFirestore.instance
                                      .collection('menus')
                                      .doc(docId)
                                      .update({
                                    'name': name,
                                    'category': category,
                                    'price': price,
                                    'image': imageUrl.isEmpty
                                        ? null
                                        : imageUrl,
                                  });

                                  if (Navigator.canPop(context)) {
                                    Navigator.pop(context);
                                  }
                                },
                          child: isSaving
                              ? const SizedBox(
                                  height: 18,
                                  width: 18,
                                  child: CircularProgressIndicator(
                                    strokeWidth: 2,
                                    valueColor:
                                        AlwaysStoppedAnimation(Colors.white),
                                  ),
                                )
                              : const Text('Update'),
                        ),
                      ],
                    )
                  ],
                ),
              ),
            ),
          );
        },
      );
    },
  );
}

/// ========= KONFIRMASI HAPUS =========

void _confirmDelete(BuildContext context, String docId) {
  showDialog(
    context: context,
    builder: (context) {
      return AlertDialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
        ),
        title: const Text('Hapus Menu'),
        content: const Text(
          'Yakin mau hapus menu ini? Tindakan ini tidak bisa dibatalkan.',
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Batal'),
          ),
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xffb91c1c),
              foregroundColor: Colors.white,
              elevation: 0,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(999),
              ),
            ),
            onPressed: () async {
              await FirebaseFirestore.instance
                  .collection('menus')
                  .doc(docId)
                  .delete();

              if (Navigator.canPop(context)) {
                Navigator.pop(context);
              }
            },
            child: const Text('Hapus'),
          ),
        ],
      );
    },
  );
}

/// ====== HELPER UPLOAD KE SUPABASE (PAKAI HELPER KELAS) ======
Future<String?> _uploadImageToSupabase(
  BuildContext context,
  Uint8List bytes,
  String fileName,
  TextEditingController imageUrlController,
) async {
  try {
    final url = await MenuUploadHelper.uploadImage(bytes, fileName);

    imageUrlController.text = url;

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Berhasil upload ke Supabase!')),
    );

    return url;
  } catch (e) {
    // KALO ERROR MASUK SINI → keliatan pesan asli dari Supabase
    debugPrint('Upload Supabase error di dialog: $e');
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('Gagal upload ke Supabase: $e')),
    );
    return null;
  }
}



InputDecoration _inputDecoration(String hint) {
  return InputDecoration(
    hintText: hint,
    isDense: true,
    filled: true,
    fillColor: const Color(0xfff9fafb),
    contentPadding:
        const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
    border: OutlineInputBorder(
      borderRadius: BorderRadius.circular(14),
      borderSide: const BorderSide(color: Color(0xffe5e7eb)),
    ),
    enabledBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(14),
      borderSide: const BorderSide(color: Color(0xffe5e7eb)),
    ),
    focusedBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(14),
      borderSide: const BorderSide(color: Color(0xff16a34a), width: 1.2),
    ),
  );
}
