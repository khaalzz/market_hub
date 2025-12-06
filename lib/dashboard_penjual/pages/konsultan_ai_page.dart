import 'package:flutter/material.dart';

class KonsultanAiPage extends StatelessWidget {
  const KonsultanAiPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'Konsultasi Bisnis',
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
        Expanded(
          child: Card(
            elevation: 0,
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
            child: Column(
              children: [
                Container(
                  width: double.infinity,
                  padding:
                      const EdgeInsets.symmetric(horizontal: 18, vertical: 16),
                  decoration: const BoxDecoration(
                    color: Color(0xff16a34a),
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(10),
                      topRight: Radius.circular(10),
                    ),
                  ),
                  child: Row(
                    children: const [
                      Icon(Icons.smart_toy, color: Colors.white),
                      SizedBox(width: 8),
                      Text(
                        'MARKETHUB AI Consultant',
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      SizedBox(width: 6),
                      Text(
                        '· Powered by AI',
                        style: TextStyle(
                          color: Color(0xffd1fae5),
                          fontSize: 11,
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 16),
                Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 18, vertical: 4),
                  child: Container(
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color: const Color(0xfff3f4ff),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: const Text(
                      'Halo! Saya asisten bisnis restoran Anda. '
                      'Ada yang bisa saya bantu analisa hari ini? '
                      'Coba tanyakan “Apa menu paling laku hari ini?” atau '
                      '“Berikan ide promo untuk besok”.',
                      style: TextStyle(
                        fontSize: 13,
                        color: Color(0xff111827),
                      ),
                    ),
                  ),
                ),
                const Spacer(),
                Padding(
                  padding: const EdgeInsets.all(16),
                  child: Row(
                    children: [
                      Expanded(
                        child: TextField(
                          maxLines: 3,
                          decoration: InputDecoration(
                            hintText: 'Tulis pertanyaan bisnis Anda...',
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(8),
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(width: 8),
                      IconButton(
                        onPressed: () {},
                        icon: const Icon(Icons.send),
                        color: const Color(0xff16a34a),
                        iconSize: 26,
                      )
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
      ],
    );
  }
}
