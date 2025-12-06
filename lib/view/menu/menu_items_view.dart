import 'package:flutter/material.dart';
import 'package:food_delivery/common/color_extension.dart';
import 'package:food_delivery/common_widget/round_textfield.dart';

import '../../common_widget/menu_item_row.dart';
import '../more/my_order_view.dart';
import 'item_details_view.dart';

class MenuItemsView extends StatefulWidget {
  final Map mObj;
  const MenuItemsView({super.key, required this.mObj});

  @override
  State<MenuItemsView> createState() => _MenuItemsViewState();
}

class _MenuItemsViewState extends State<MenuItemsView> {
  TextEditingController txtSearch = TextEditingController();

  List menuItemsArr = [
    {
      "image": "assets/img/dess_1.png",
      "name": "Ayam Geprek",
      "rate": "4.9",
      "rating": "124",
      "type": "",
      "food_type": "Makanan"
    },
    {
      "image": "assets/img/dess_2.png",
      "name": "Ayam Goreng",
      "rate": "4.9",
      "rating": "124",
      "type": "",
      "food_type": "Makanan"
    },
    {
      "image": "assets/img/dess_3.png",
      "name": "Buah Potong",
      "rate": "4.9",
      "rating": "124",
      "type": "",
      "food_type": "Desserts"
    },
    {
      "image": "assets/img/dess_4.png",
      "name": "Nasi Rames",
      "rate": "4.9",
      "rating": "124",
      "type": "",
      "food_type": "Makanan"
    },
    {
      "image": "assets/img/dess_8.png",
      "name": "Mendoan",
      "rate": "4.9",
      "rating": "124",
      "type": "",
      "food_type": "Camilan"
    },
    {
      "image": "assets/img/dess_6.png",
      "name": "Jus Buah",
      "rate": "4.9",
      "rating": "124",
      "type": "",
      "food_type": "Minuman"
    },
    {
      "image": "assets/img/dess_7.png",
      "name": "Mix Platter",
      "rate": "4.9",
      "rating": "124",
      "type": "",
      "food_type": "Camilan"
    },
    {
      "image": "assets/img/dess_5.png",
      "name": "Es Teh",
      "rate": "4.9",
      "rating": "124",
      "type": "",
      "food_type": "Minuman"
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 20),
          child: Column(
            children: [
              const SizedBox(
                height: 46,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Row(
                  children: [
                    IconButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      icon: Image.asset("assets/img/btn_back.png",
                          width: 20, height: 20),
                    ),
                    const SizedBox(
                      width: 8,
                    ),
                    Expanded(
                      child: Text(
                        widget.mObj["name"].toString(),
                        style: TextStyle(
                            color: TColor.primaryText,
                            fontSize: 20,
                            fontWeight: FontWeight.w800),
                      ),
                    ),
                    IconButton(
                      onPressed: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const MyOrderView()));
                      },
                      icon: Image.asset(
                        "assets/img/shopping_cart.png",
                        width: 25,
                        height: 25,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: RoundTextfield(
                  hintText: "Search Food",
                  controller: txtSearch,
                  left: Container(
                    alignment: Alignment.center,
                    width: 30,
                    child: Image.asset(
                      "assets/img/search.png",
                      width: 20,
                      height: 20,
                    ),
                  ),
                ),
              ),
              const SizedBox(
                height: 15,
              ),
              ListView.builder(
                physics: const NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                padding: EdgeInsets.zero,
                itemCount: menuItemsArr.length,
                itemBuilder: ((context, index) {
                  var mObj = menuItemsArr[index] as Map? ?? {};
                  return MenuItemRow(
                    mObj: mObj,
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const ItemDetailsView()),
                      );
                    },
                  );
                }),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
