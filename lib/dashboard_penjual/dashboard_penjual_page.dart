import 'package:flutter/material.dart';
import 'package:food_delivery/view/main_tabview/main_tabview.dart';
import 'package:food_delivery/view/more/more_view.dart';

import 'pages/ringkasan_page.dart';
import 'pages/pesanan_page.dart';
import 'pages/menu_stok_page.dart';
import 'pages/chat_pembeli_page.dart';
import 'pages/konsultan_ai_page.dart';
import 'pages/profil_toko_page.dart';

class DashboardPenjualPage extends StatefulWidget {
  const DashboardPenjualPage({super.key});

  @override
  State<DashboardPenjualPage> createState() => _DashboardPenjualPageState();
}

class _DashboardPenjualPageState extends State<DashboardPenjualPage> {
  int _selectedIndex = 0;

  final List<String> _menus = const [
    'Ringkasan',
    'Pesanan',
    'Menu & Stok',
    'Chat Pembeli',
    'Kembali Ke Home',
    'Pengaturan Toko',
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xfff5f7fb),

      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        centerTitle: false,
        titleSpacing: 0,
        leadingWidth: 56,
        leading: IconButton(
          icon: const Icon(
            Icons.menu,
            color: Colors.black87,
          ),
          onPressed: () {
            debugPrint('MENU DIKLIK !!!'); // cek di console
            _openSideMenu(context);
          },
        ),
        title: Row(
          children: [
            Container(
              width: 32,
              height: 32,
              decoration: const BoxDecoration(
                color: Color(0xff00b894),
                shape: BoxShape.circle,
              ),
              child: const Icon(
                Icons.storefront,
                color: Colors.white,
                size: 18,
              ),
            ),
            const SizedBox(width: 10),
            const Text(
              'MARKETHUB',
              style: TextStyle(
                color: Colors.black87,
                fontSize: 16,
                fontWeight: FontWeight.w700,
              ),
            ),
          ],
        ),
      ),

      body: Container(
        color: const Color(0xfff5f7fb),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: _buildPage(),
        ),
      ),
    );
  }

  void _openSideMenu(BuildContext context) {
    showGeneralDialog(
      context: context,
      barrierDismissible: true,
      barrierLabel: 'Menu',
      pageBuilder: (_, __, ___) {
        return Align(
          alignment: Alignment.centerLeft,
          child: Material(
            color: Colors.transparent,
            child: SizedBox(
              width: 260,
              height: MediaQuery.of(context).size.height,
              child: _SideMenu(
                menus: _menus,
                selectedIndex: _selectedIndex,
                onMenuSelected: (index) {
                  setState(() {
                    _selectedIndex = index;
                  });
                  Navigator.of(context).pop();
                },
              ),
            ),
          ),
        );
      },
      transitionDuration: const Duration(milliseconds: 200),
      transitionBuilder: (context, animation, secondaryAnimation, child) {
        final offsetAnimation = Tween<Offset>(
          begin: const Offset(-1.0, 0.0),
          end: Offset.zero,
        ).animate(animation);
        return SlideTransition(
          position: offsetAnimation,
          child: child,
        );
      },
    );
  }

  Widget _buildPage() {
    switch (_selectedIndex) {
      case 0:
        return const RingkasanPage();
      case 1:
        return const PesananPage();
      case 2:
        return const MenuStokPage();
      case 3:
        return const ChatPembeliPage();
      case 4:
        return const MainTabView();
      case 5:
      default:
        return const ProfilTokoPage();
    }
  }
}

class _SideMenu extends StatelessWidget {
  final List<String> menus;
  final int selectedIndex;
  final ValueChanged<int> onMenuSelected;

  const _SideMenu({
    required this.menus,
    required this.selectedIndex,
    required this.onMenuSelected,
  });

  @override
  Widget build(BuildContext context) {
    IconData _getIcon(int index) {
      switch (index) {
        case 0:
          return Icons.dashboard_outlined;
        case 1:
          return Icons.receipt_long_outlined;
        case 2:
          return Icons.restaurant_menu_outlined;
        case 3:
          return Icons.chat_bubble_outline;
        case 4:
          return Icons.analytics_outlined;
        case 5:
        default:
          return Icons.settings_outlined;
      }
    }

    return Container(
      decoration: const BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            blurRadius: 12,
            color: Color(0x33000000),
            offset: Offset(2, 0),
          ),
        ],
      ),
      child: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
              child: Row(
                children: [
                  Container(
                    width: 32,
                    height: 32,
                    decoration: const BoxDecoration(
                      color: Color(0xff00b894),
                      shape: BoxShape.circle,
                    ),
                    child: const Icon(
                      Icons.storefront,
                      color: Colors.white,
                      size: 18,
                    ),
                  ),
                  const SizedBox(width: 10),
                  const Text(
                    'MARKETHUB',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ],
              ),
            ),
            const Divider(height: 1),
            Expanded(
              child: ListView.builder(
                itemCount: menus.length,
                itemBuilder: (context, index) {
                  final selected = index == selectedIndex;
                  return ListTile(
                    leading: Icon(
                      _getIcon(index),
                      size: 20,
                      color: selected
                          ? const Color(0xff16a34a)
                          : const Color(0xff6b7280),
                    ),
                    title: Text(
                      menus[index],
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight:
                            selected ? FontWeight.w600 : FontWeight.w400,
                        color: selected
                            ? const Color(0xff16a34a)
                            : const Color(0xff111827),
                      ),
                    ),
                    onTap: () => onMenuSelected(index),
                  );
                },
              ),
            ),
            Container(
              margin:
                  const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: const Color(0xff111827),
                borderRadius: BorderRadius.circular(10),
              ),
              child: Row(
                children: const [
                  CircleAvatar(
                    radius: 18,
                    backgroundImage: NetworkImage(
                      'https://picsum.photos/seed/markethub_store/200/200',
                    ),
                  ),
                  SizedBox(width: 10),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Ayam Bakar Pak Jogo',
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                            fontSize: 12,
                            color: Colors.white,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        SizedBox(height: 2),
                        Text(
                          'Buka · Rating 4,8',
                          style: TextStyle(
                            fontSize: 10,
                            color: Color(0xffe5e7eb),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 8),
          ],
        ),
      ),
    );
  }
}
