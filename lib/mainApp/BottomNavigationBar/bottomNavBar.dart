import 'package:floating_bottom_navigation_bar/floating_bottom_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:price_cruncher_new/mainApp/homeScreen/Store/store.dart';
import 'package:price_cruncher_new/mainApp/homeScreen/barCodeScreen.dart';
import 'package:price_cruncher_new/mainApp/homeScreen/homeScreen.dart';
import 'package:price_cruncher_new/mainApp/homeScreen/shoppingScreen.dart';
import 'package:price_cruncher_new/mainApp/menu/menu_screen.dart';
import 'package:price_cruncher_new/models/items_model.dart';
import 'package:price_cruncher_new/utils/constants.dart';

class ScreenBottomNavBar extends StatefulWidget {
  static String routeName = '/bottom_nav_ar';
  final AddItem? item;
  ScreenBottomNavBar({Key? key, this.item}) : super(key: key);
  @override
  State<ScreenBottomNavBar> createState() => _ScreenBottomNavBarState();
}

class _ScreenBottomNavBarState extends State<ScreenBottomNavBar> {
  int _currentIndex = 0;
  bool _showNavigationBar = true;
  late List<Widget> screens;

  @override
  void initState() {
    super.initState();
    screens = [
      const HomeScreen(),
      const ShoppingScreen(),
      const StoreScreen(),
      const BarCodeScannerScreen(),
      const MenuScreen()
    ];
  }

  @override
  Widget build(BuildContext context) {
    print(_currentIndex);
    final screen = MediaQuery.of(context).size;

    return Scaffold(
      body: Stack(
        children: [
          // Content
          Positioned.fill(
            child: screens[_currentIndex],
          ),

          // FloatingNavbar at the bottom
          Positioned(
            left: 0,
            right: 0,
            bottom: 0,
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(30),
              ),
              child: FloatingNavbar(
                borderRadius: 0.5,
                margin: EdgeInsets.all(0),
                backgroundColor: const Color.fromRGBO(21, 21, 21, 0.9),
                itemBorderRadius: 0,
                selectedBackgroundColor: Colors.transparent,
                onTap: (int val) {
                  setState(() {
                    _currentIndex = val;
                  });
                },
                currentIndex: _currentIndex,
                items: [
                  FloatingNavbarItem(
                    customWidget: Column(
                      children: [
                        Image.asset(
                          'assets/images/1.png',
                          height: 20,
                          color:
                              _currentIndex == 0 ? Colors.green : Colors.white,
                        ),
                        sizedBox01,
                        Text(
                          'Items',
                          maxLines: 1,
                          style: bottomNavBarTextStyle(
                              selected: _currentIndex == 0),
                        )
                      ],
                    ),
                  ),
                  FloatingNavbarItem(
                    customWidget: Column(
                      children: [
                        Image.asset(
                          'assets/images/2.png',
                          height: 20,
                          color:
                              _currentIndex == 1 ? Colors.green : Colors.white,
                        ),
                        sizedBox01,
                        Text(
                          'Shopping',
                          maxLines: 1,
                          style: bottomNavBarTextStyle(
                              selected: _currentIndex == 1),
                        )
                      ],
                    ),
                  ),
                  FloatingNavbarItem(
                    customWidget: Column(
                      children: [
                        Image.asset(
                          'assets/images/3.png',
                          height: 20,
                          color:
                              _currentIndex == 2 ? Colors.green : Colors.white,
                        ),
                        sizedBox01,
                        Text(
                          'Store',
                          maxLines: 1,
                          style: bottomNavBarTextStyle(
                              selected: _currentIndex == 2),
                        )
                      ],
                    ),
                  ),
                  FloatingNavbarItem(
                    customWidget: Column(
                      children: [
                        Image.asset(
                          'assets/images/4.png',
                          height: 20,
                          color:
                              _currentIndex == 3 ? Colors.green : Colors.white,
                        ),
                        sizedBox01,
                        Text(
                          'Barcode',
                          maxLines: 1,
                          style: bottomNavBarTextStyle(
                              selected: _currentIndex == 3),
                        )
                      ],
                    ),
                  ),
                  FloatingNavbarItem(
                    customWidget: Column(
                      children: [
                        Image.asset(
                          'assets/images/5.png',
                          height: 20,
                          color:
                              _currentIndex == 4 ? Colors.green : Colors.white,
                        ),
                        sizedBox01,
                        Text(
                          'Menu',
                          maxLines: 1,
                          style: bottomNavBarTextStyle(
                              selected: _currentIndex == 4),
                        )
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
