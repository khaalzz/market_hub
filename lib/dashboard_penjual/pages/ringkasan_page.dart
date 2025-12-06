import 'package:flutter/material.dart';

import '../widgets/summary_widgets.dart';
import '../widgets/chart_painter.dart';

class RingkasanPage extends StatelessWidget {
  const RingkasanPage({super.key});

  @override
  Widget build(BuildContext context) {
    // dummy data pesanan terbaru
    final orders = [
      ['#ORD-2899', 'Pelanggan Baru', 'Rp 25.000', 'Baru'],
      ['#ORD-381', 'Pelanggan Baru', 'Rp 25.000', 'Baru'],
      ['#ORD-4453', 'Pelanggan Baru', 'Rp 25.000', 'Baru'],
      ['#ORD-001', 'Budi Santoso', 'Rp 50.000', 'Baru'],
      ['#ORD-002', 'Siti Aminah', 'Rp 48.000', 'Diproses'],
    ];

    return SingleChildScrollView(
      padding: const EdgeInsets.only(bottom: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // judul + tanggal
          const Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Ringkasan Bisnis',
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

          // kartu-kartu ringkasan (stack vertikal, biar mirip UI mobile)
          const SummaryCard(
            icon: Icons.attach_money,
            title: 'Total Penjualan Hari ini',
            value: 'Rp 3.250.000',
            growth: '+12,5%',
          ),
          const SizedBox(height: 12),
          const SummaryCard(
            icon: Icons.shopping_bag_outlined,
            title: 'Total Pesanan',
            value: '64',
            growth: '+5',
          ),
          const SizedBox(height: 12),
          const SummaryCard(
            icon: Icons.show_chart,
            title: 'Rata-rata Order',
            value: 'Rp 59.375',
            growth: '+2,1%',
          ),
          const SizedBox(height: 12),
          const SummaryCard(
            icon: Icons.menu_book_outlined,
            title: 'Menu Aktif',
            value: '4',
          ),
          const SizedBox(height: 20),

          // kartu tren pendapatan
          _revenueChartCard(),
          const SizedBox(height: 16),

          // kartu menu terlaris
          _bestMenuCard(),
          const SizedBox(height: 16),

          // kartu pesanan terbaru
          _latestOrdersCard(orders),
        ],
      ),
    );
  }

  // ====== KARTU: Tren Pendapatan ======
  static Widget _revenueChartCard() {
    return Card(
      elevation: 0,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Tren Pendapatan (7 Hari Terakhir)',
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w600,
              ),
            ),
            const SizedBox(height: 16),
            SizedBox(
              height: 180,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(10),
                child: Container(
                  decoration: const BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      colors: [
                        Color(0xffe3f2fd),
                        Color(0xffffffff),
                      ],
                    ),
                  ),
                  child: CustomPaint(
                    painter: SimpleLineChartPainter(),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 8),
            const Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('Si', style: TextStyle(fontSize: 11)),
                Text('Rb', style: TextStyle(fontSize: 11)),
                Text('Km', style: TextStyle(fontSize: 11)),
                Text('Jm', style: TextStyle(fontSize: 11)),
                Text('Sb', style: TextStyle(fontSize: 11)),
                Text('Mg', style: TextStyle(fontSize: 11)),
              ],
            ),
          ],
        ),
      ),
    );
  }

  // ====== KARTU: Menu Terlaris ======
  static Widget _bestMenuCard() {
    Widget menuBar(String label, double percent) {
      return Padding(
        padding: const EdgeInsets.only(bottom: 12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(label, style: const TextStyle(fontSize: 12)),
            const SizedBox(height: 4),
            LayoutBuilder(
              builder: (context, constraints) {
                final width = constraints.maxWidth;
                return Stack(
                  children: [
                    Container(
                      height: 10,
                      width: width,
                      decoration: BoxDecoration(
                        color: const Color(0xffe5e7eb),
                        borderRadius: BorderRadius.circular(20),
                      ),
                    ),
                    AnimatedContainer(
                      duration: const Duration(milliseconds: 300),
                      height: 10,
                      width: width * percent,
                      decoration: BoxDecoration(
                        color: const Color(0xff1d4ed8),
                        borderRadius: BorderRadius.circular(20),
                      ),
                    ),
                  ],
                );
              },
            ),
          ],
        ),
      );
    }

    return Card(
      elevation: 0,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Menu Terlaris',
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w600,
              ),
            ),
            const SizedBox(height: 16),
            menuBar('Nasi Goreng Spesial', 0.8),
            menuBar('Es Teh Manis Jumbo', 0.9),
            menuBar('Ayam Bakar Madu', 0.6),
            menuBar('Sate Ayam (10 Tusuk)', 0.4),
            menuBar('Tahu Goreng Crispy', 0.3),
          ],
        ),
      ),
    );
  }

  // ====== KARTU: Pesanan Masuk Terbaru ======
  static Widget _latestOrdersCard(List<List<String>> orders) {
    return Card(
      elevation: 0,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Padding(
        padding: const EdgeInsets.fromLTRB(16, 14, 16, 12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // header
            Row(
              children: [
                const Expanded(
                  child: Text(
                    'Pesanan Masuk Terbaru',
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
                TextButton(
                  onPressed: () {},
                  child: const Text(
                    'Lihat Semua',
                    style: TextStyle(fontSize: 12),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 8),

            // header kolom
            Container(
              padding:
                  const EdgeInsets.symmetric(horizontal: 4, vertical: 6),
              decoration: const BoxDecoration(
                border: Border(
                  bottom: BorderSide(color: Color(0xffe5e7eb)),
                ),
              ),
              child: const Row(
                children: [
                  Expanded(
                    flex: 2,
                    child: Text(
                      'Order ID',
                      style: TextStyle(
                        fontSize: 11,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                  Expanded(
                    flex: 3,
                    child: Text(
                      'Pelanggan',
                      style: TextStyle(
                        fontSize: 11,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                  Expanded(
                    flex: 2,
                    child: Text(
                      'Total',
                      style: TextStyle(
                        fontSize: 11,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                  Expanded(
                    flex: 2,
                    child: Text(
                      'Status',
                      style: TextStyle(
                        fontSize: 11,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 4),

            // list pesanan (pakai Column biasa, bukan ListView biar aman di scroll)
            Column(
              children: orders.map((o) {
                final isNew = o[3] == 'Baru';
                return Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 4, vertical: 8),
                      child: Row(
                        children: [
                          Expanded(
                            flex: 2,
                            child: Text(
                              o[0],
                              style: const TextStyle(fontSize: 12),
                            ),
                          ),
                          Expanded(
                            flex: 3,
                            child: Text(
                              o[1],
                              style: const TextStyle(fontSize: 12),
                            ),
                          ),
                          Expanded(
                            flex: 2,
                            child: Text(
                              o[2],
                              style: const TextStyle(fontSize: 12),
                            ),
                          ),
                          Expanded(
                            flex: 2,
                            child: Align(
                              alignment: Alignment.centerLeft,
                              child: Container(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 10,
                                  vertical: 4,
                                ),
                                decoration: BoxDecoration(
                                  color: isNew
                                      ? const Color(0xfffff7e6)
                                      : const Color(0xffe0f2fe),
                                  borderRadius: BorderRadius.circular(20),
                                ),
                                child: Text(
                                  o[3],
                                  style: TextStyle(
                                    fontSize: 11,
                                    color: isNew
                                        ? const Color(0xffb45309)
                                        : const Color(0xff0369a1),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    if (o != orders.last)
                      const Divider(
                        height: 1,
                        color: Color(0xfff3f4f6),
                      ),
                  ],
                );
              }).toList(),
            )
          ],
        ),
      ),
    );
  }
}
