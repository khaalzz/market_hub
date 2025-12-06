import 'package:flutter/material.dart';

class PesananPage extends StatelessWidget {
  const PesananPage({super.key});

  @override
  Widget build(BuildContext context) {
    final orders = [
      {
        'id': '#ORD-1229',
        'time': '20.08',
        'customer': 'Pelanggan Baru',
        'item': '1x Nasi Goreng Spesial',
        'price': 'Rp 25.000',
        'status': 'Baru',
      },
      {
        'id': '#ORD-6425',
        'time': '19.54',
        'customer': 'Pelanggan Baru',
        'item': '1x Nasi Goreng Spesial',
        'price': 'Rp 25.000',
        'status': 'Baru',
      },
      {
        'id': '#ORD-381',
        'time': '19.00',
        'customer': 'Pelanggan Baru',
        'item': '1x Nasi Goreng Spesial',
        'price': 'Rp 25.000',
        'status': 'Baru',
      },
      {
        'id': '#ORD-4453',
        'time': '18.59',
        'customer': 'Pelanggan Baru',
        'item': '1x Nasi Goreng Spesial',
        'price': 'Rp 25.000',
        'status': 'Baru',
      },
      {
        'id': '#ORD-001',
        'time': '10.30',
        'customer': 'Budi Santoso',
        'item': '2x Nasi Goreng Spesial',
        'price': 'Rp 50.000',
        'status': 'Baru',
      },
    ];

    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.only(bottom: 16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // header judul + tanggal
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: const [
                Text(
                  'Manajemen Pesanan',
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
            const SizedBox(height: 16),

            const Text(
              'Daftar Pesanan',
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w600,
              ),
            ),
            const SizedBox(height: 12),

            // TAB STATUS
            const _StatusTabs(),
            const SizedBox(height: 12),

            // LIST PESANAN: pakai Column aja
            ...orders.map(
              (o) => Padding(
                padding: const EdgeInsets.only(bottom: 10),
                child: _OrderCard(
                  id: o['id']!,
                  time: o['time']!,
                  customer: o['customer']!,
                  item: o['item']!,
                  price: o['price']!,
                  status: o['status']!,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// ================== TAB STATUS ==================

class _StatusTabs extends StatefulWidget {
  const _StatusTabs();

  @override
  State<_StatusTabs> createState() => _StatusTabsState();
}

class _StatusTabsState extends State<_StatusTabs> {
  int _index = 0;

  final _labels = const ['Semua', 'Baru', 'Diproses', 'Siap', 'Selesai'];

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        children: List.generate(_labels.length, (i) {
          final selected = i == _index;
          return Padding(
            padding: EdgeInsets.only(right: i == _labels.length - 1 ? 0 : 8),
            child: GestureDetector(
              onTap: () {
                setState(() {
                  _index = i;
                });
              },
              child: Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 14, vertical: 6),
                decoration: BoxDecoration(
                  color: selected ? const Color(0xff16a34a) : Colors.white,
                  borderRadius: BorderRadius.circular(20),
                  border: Border.all(
                    color: selected
                        ? const Color(0xff16a34a)
                        : const Color(0xffe5e7eb),
                  ),
                ),
                child: Text(
                  _labels[i],
                  style: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w500,
                    color:
                        selected ? Colors.white : const Color(0xff374151),
                  ),
                ),
              ),
            ),
          );
        }),
      ),
    );
  }
}

// ================== KARTU PESANAN ==================

class _OrderCard extends StatelessWidget {
  final String id;
  final String time;
  final String customer;
  final String item;
  final String price;
  final String status;

  const _OrderCard({
    required this.id,
    required this.time,
    required this.customer,
    required this.item,
    required this.price,
    required this.status,
  });

  @override
  Widget build(BuildContext context) {
    final isNew = status == 'Baru';

    return Card(
      margin: EdgeInsets.zero,
      elevation: 0,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Padding(
        padding: const EdgeInsets.fromLTRB(14, 12, 14, 12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // baris atas
            Row(
              children: [
                Expanded(
                  child: Row(
                    children: [
                      Text(
                        id,
                        style: const TextStyle(
                          fontSize: 13,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      const SizedBox(width: 6),
                      Text(
                        '• $time',
                        style: const TextStyle(
                          fontSize: 11,
                          color: Color(0xff9ca3af),
                        ),
                      ),
                    ],
                  ),
                ),
                Text(
                  price,
                  style: const TextStyle(
                    fontSize: 13,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const SizedBox(width: 8),
                Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                  decoration: BoxDecoration(
                    color: isNew
                        ? const Color(0xfffff7e6)
                        : const Color(0xffe0f2fe),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Text(
                    status,
                    style: TextStyle(
                      fontSize: 11,
                      color: isNew
                          ? const Color(0xffb45309)
                          : const Color(0xff0369a1),
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 4),
            Text(
              customer,
              style: const TextStyle(
                fontSize: 12,
                color: Color(0xff6b7280),
              ),
            ),
            const SizedBox(height: 4),
            Text(
              item,
              style: const TextStyle(
                fontSize: 12,
              ),
            ),
            const SizedBox(height: 10),
            Row(
              children: [
                Expanded(
                  child: OutlinedButton(
                    onPressed: () {},
                    style: OutlinedButton.styleFrom(
                      side: const BorderSide(
                        color: Color(0xfffecaca),
                      ),
                      padding: const EdgeInsets.symmetric(vertical: 10),
                    ),
                    child: const Text(
                      'Tolak',
                      style: TextStyle(
                        fontSize: 13,
                        color: Color(0xffb91c1c),
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: ElevatedButton(
                    onPressed: () {},
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xff16a34a),
                      padding: const EdgeInsets.symmetric(vertical: 10),
                    ),
                    child: const Text(
                      'Terima Pesanan',
                      style: TextStyle(fontSize: 13),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
