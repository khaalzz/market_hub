import 'package:flutter/material.dart';
import 'package:food_delivery/common/color_extension.dart';
import 'package:food_delivery/common_widget/round_button.dart';
import 'package:food_delivery/view/main_tabview/main_tabview.dart';

class OnBoardingView extends StatefulWidget {
  const OnBoardingView({super.key});

  @override
  State<OnBoardingView> createState() => _OnBoardingViewState();
}

class _OnBoardingViewState extends State<OnBoardingView> {
  int selectPage = 0;
  final PageController controller = PageController();

  final List<Map<String, String>> pageArr = [
    {
      "title": "Find Food You Love",
      "subtitle":
          "Discover the best foods from over 1,000\nrestaurants and fast delivery to your\ndoorstep",
      "image": "assets/img/on_boarding_1.png",
    },
    {
      "title": "Fast Delivery",
      "subtitle":
          "Fast food delivery to your home, office\nwherever you are",
      "image": "assets/img/on_boarding_2.png",
    },
    {
      "title": "Live Tracking",
      "subtitle":
          "Real time tracking of your food on the app\nonce you placed the order",
      "image": "assets/img/on_boarding_3.png",
    },
  ];

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  void _goNext() {
    if (selectPage >= pageArr.length - 1) {
      // Sudah di halaman terakhir -> masuk ke main app
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => const MainTabView(),
        ),
      );
    } else {
      final nextPage = selectPage + 1;

      controller.animateToPage(
        nextPage,
        duration: const Duration(milliseconds: 400),
        curve: Curves.easeOutCubic, // lebih halus, ga kedut2
      );

      setState(() {
        selectPage = nextPage;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final media = MediaQuery.of(context).size;

    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Column(
          children: [
            // ====== BAGIAN SLIDE (ATAS) ======
            Expanded(
              child: PageView.builder(
                controller: controller,
                physics: const BouncingScrollPhysics(),
                itemCount: pageArr.length,
                onPageChanged: (index) {
                  setState(() {
                    selectPage = index;
                  });
                },
                itemBuilder: (context, index) {
                  final pObj = pageArr[index];

                  return Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 24),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        // Gambar
                        SizedBox(
                          height: media.height * 0.4,
                          child: Center(
                            child: Image.asset(
                              pObj["image"]!,
                              width: media.width * 0.7,
                              fit: BoxFit.contain,
                            ),
                          ),
                        ),
                        const SizedBox(height: 32),

                        // Judul
                        Text(
                          pObj["title"]!,
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color: TColor.primaryText,
                            fontSize: 28,
                            fontWeight: FontWeight.w800,
                          ),
                        ),
                        const SizedBox(height: 12),

                        // Subjudul
                        Text(
                          pObj["subtitle"]!,
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color: TColor.secondaryText,
                            fontSize: 13,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        const SizedBox(height: 24),
                      ],
                    ),
                  );
                },
              ),
            ),

            // ====== DOT INDICATOR ======
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: List.generate(pageArr.length, (index) {
                final isActive = index == selectPage;
                return AnimatedContainer(
                  duration: const Duration(milliseconds: 200),
                  margin: const EdgeInsets.symmetric(horizontal: 4),
                  height: 6,
                  width: isActive ? 16 : 6,
                  decoration: BoxDecoration(
                    color: isActive ? TColor.primary : TColor.placeholder,
                    borderRadius: BorderRadius.circular(4),
                  ),
                );
              }),
            ),
            const SizedBox(height: 24),

            // ====== BUTTON NEXT ======
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 25),
              child: RoundButton(
                title: selectPage == pageArr.length - 1 ? "Get Started" : "Next",
                onPressed: _goNext,
              ),
            ),

            const SizedBox(height: 24),
          ],
        ),
      ),
    );
  }
}
