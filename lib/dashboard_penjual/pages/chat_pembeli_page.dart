import 'package:flutter/material.dart';

class ChatPembeliPage extends StatelessWidget {
  const ChatPembeliPage({super.key});

  @override
  Widget build(BuildContext context) {
    final chats = [
      {'name': 'Budi Santoso', 'preview': 'Mas, pesanan saya dikasih sambal banyak ya', 'time': '10:32'},
      {'name': 'Siti Aminah', 'preview': 'Terima kasih kak!', 'time': '09:15'},
    ];


    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'Chat Pelanggan',
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
            child: Row(
              children: [
                // list chat
                SizedBox(
                  width: 260,
                  child: Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(12),
                        child: TextField(
                          decoration: InputDecoration(
                            hintText: 'Cari chat...',
                            prefixIcon: const Icon(Icons.search, size: 18),
                            contentPadding:
                                const EdgeInsets.symmetric(vertical: 0),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(8),
                            ),
                          ),
                        ),
                      ),
                      const Divider(height: 1),
                      Expanded(
                        child: ListView.builder(
                          itemCount: chats.length,
                          itemBuilder: (context, index) {
                            final c = chats[index];
                            final selected = index == 0;
                            return Container(
                              color: selected
                                  ? const Color(0xfff3f4ff)
                                  : Colors.transparent,
                              child: ListTile(
                                title: Text(
                                  c['name']!,
                                  style: const TextStyle(fontSize: 13),
                                ),
                                subtitle: Text(
                                  c['preview']!,
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                  style: const TextStyle(
                                      fontSize: 11, color: Color(0xff6b7280)),
                                ),
                                trailing: Text(
                                  c['time']!,
                                  style: const TextStyle(
                                      fontSize: 10, color: Color(0xff9ca3af)),
                                ),
                              ),
                            );
                          },
                        ),
                      ),
                    ],
                  ),
                ),
                const VerticalDivider(width: 1),
                // chat box
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Padding(
                        padding:
                            EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                        child: Text(
                          'Budi Santoso · Online',
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                      const Divider(height: 1),
                      Expanded(
                        child: Padding(
                          padding: const EdgeInsets.all(16),
                          child: ListView(
                            children: const [
                              Align(
                                alignment: Alignment.centerLeft,
                                child: _ChatBubble(
                                  message: 'Halo min, mau tanya',
                                  isMe: false,
                                  time: '10:30',
                                ),
                              ),
                              SizedBox(height: 8),
                              Align(
                                alignment: Alignment.centerRight,
                                child: _ChatBubble(
                                  message: 'Halo kak, ada yang bisa dibantu?',
                                  isMe: true,
                                  time: '10:31',
                                ),
                              ),
                              SizedBox(height: 8),
                              Align(
                                alignment: Alignment.centerLeft,
                                child: _ChatBubble(
                                  message:
                                      'Mas, pesanan saya dikasih sambal banyak ya',
                                  isMe: false,
                                  time: '10:32',
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      const Divider(height: 1),
                      Padding(
                        padding: const EdgeInsets.all(12),
                        child: Row(
                          children: [
                            Expanded(
                              child: TextField(
                                decoration: InputDecoration(
                                  hintText: 'Tulis pesan...',
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
                            )
                          ],
                        ),
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

class _ChatBubble extends StatelessWidget {
  final String message;
  final bool isMe;
  final String time;

  const _ChatBubble({
    required this.message,
    required this.isMe,
    required this.time,
  });

  @override
  Widget build(BuildContext context) {
    final bg = isMe ? const Color(0xff16a34a) : const Color(0xffe5e7eb);
    final textColor = isMe ? Colors.white : const Color(0xff111827);

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      decoration: BoxDecoration(
        color: bg,
        borderRadius: BorderRadius.only(
          topLeft: const Radius.circular(12),
          topRight: const Radius.circular(12),
          bottomLeft: Radius.circular(isMe ? 12 : 0),
          bottomRight: Radius.circular(isMe ? 0 : 12),
        ),
      ),
      child: Column(
        crossAxisAlignment:
            isMe ? CrossAxisAlignment.end : CrossAxisAlignment.start,
        children: [
          Text(
            message,
            style: TextStyle(color: textColor, fontSize: 13),
          ),
          const SizedBox(height: 2),
          Text(
            time,
            style: TextStyle(
              fontSize: 10,
              color: textColor.withOpacity(0.8),
            ),
          ),
        ],
      ),
    );
  }
}
