import 'package:flutter/material.dart';

class ProfilTokoPage extends StatelessWidget {
  const ProfilTokoPage({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
        const Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'Profil Toko',
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
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(child: _fotoProfilCard()),
            const SizedBox(width: 16),
            Expanded(child: _infoDasarCard()),
          ],
        ),
        const SizedBox(height: 16),
        _lokasiCard(),
        const SizedBox(height: 16),
        Align(
          alignment: Alignment.centerRight,
          child: ElevatedButton.icon(
            onPressed: () {},
            icon: const Icon(Icons.save, size: 18),
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xff16a34a),
              foregroundColor: Colors.white,
              elevation: 0,
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
            ),
            label: const Text('Simpan Perubahan'),
          ),
        ),
      ],
    );
  }

  static Widget _containerCard({required Widget child}) {
    return Card(
      elevation: 0,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: child,
      ),
    );
  }

  static Widget _fotoProfilCard() {
    return _containerCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Foto Profil Toko',
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w600,
            ),
          ),
          const SizedBox(height: 12),
          Row(
            children: [
              const CircleAvatar(
                radius: 40,
                backgroundImage: NetworkImage(
                  'https://picsum.photos/seed/markethub_store/200/200',
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'URL Gambar',
                      style: TextStyle(fontSize: 12),
                    ),
                    const SizedBox(height: 6),
                    TextField(
                      decoration: InputDecoration(
                        isDense: true,
                        hintText: 'https://picsum.photos/seed/resto1/200/200',
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(6),
                        ),
                      ),
                    ),
                    const SizedBox(height: 6),
                    const Text(
                      'Gunakan URL gambar yang valid untuk foto atau banner toko.',
                      style:
                          TextStyle(fontSize: 11, color: Color(0xff6b7280)),
                    ),
                  ],
                ),
              ),
            ],
          )
        ],
      ),
    );
  }

  static Widget _infoDasarCard() {
    return _containerCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Informasi Dasar',
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w600,
            ),
          ),
          const SizedBox(height: 12),
          const Text('Nama Toko', style: TextStyle(fontSize: 12)),
          const SizedBox(height: 4),
          TextField(
            controller: TextEditingController(text: 'Ayam Bakar Pak Jogo'),
            decoration: _inputDecoration(),
          ),
          const SizedBox(height: 12),
          const Text('Kategori Masakan', style: TextStyle(fontSize: 12)),
          const SizedBox(height: 4),
          DropdownButtonFormField<String>(
            value: 'Ayam & Bebek',
            items: const [
              DropdownMenuItem(value: 'Ayam & Bebek', child: Text('Ayam & Bebek')),
              DropdownMenuItem(value: 'Aneka Nasi', child: Text('Aneka Nasi')),
              DropdownMenuItem(value: 'Minuman', child: Text('Minuman')),
            ],
            onChanged: (_) {},
            decoration: _inputDecoration(),
          ),
          const SizedBox(height: 12),
          const Text('Deskripsi Singkat', style: TextStyle(fontSize: 12)),
          const SizedBox(height: 4),
          TextField(
            maxLines: 3,
            controller: TextEditingController(
              text: 'Spesialis ayam bakar madu dengan sambal khas yang pedas nikmat.',
            ),
            decoration: _inputDecoration(),
          ),
        ],
      ),
    );
  }

  static Widget _lokasiCard() {
    return _containerCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Lokasi & Operasional',
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w600,
            ),
          ),
          const SizedBox(height: 12),
          const Text('Alamat Lengkap', style: TextStyle(fontSize: 12)),
          const SizedBox(height: 4),
          TextField(
            controller: TextEditingController(
                text: 'Jl. Merdeka No. 45, Jakarta Selatan'),
            decoration: _inputDecoration(),
          ),
          const SizedBox(height: 12),
          Row(
            children: [
              const Icon(
                Icons.circle,
                size: 10,
                color: Color(0xff22c55e),
              ),
              const SizedBox(width: 6),
              const Text(
                'Status Toko',
                style: TextStyle(fontSize: 12),
              ),
              const Spacer(),
              Switch(
                value: true,
                onChanged: (_) {},
                activeColor: const Color(0xff16a34a),
              ),
              const SizedBox(width: 4),
              const Text(
                'Sedang Buka (Menerima Pesanan)',
                style: TextStyle(
                  fontSize: 11,
                  color: Color(0xff16a34a),
                ),
              ),
            ],
          )
        ],
      ),
    );
  }

  static InputDecoration _inputDecoration() {
    return InputDecoration(
      isDense: true,
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(6),
      ),
    );
  }
}
