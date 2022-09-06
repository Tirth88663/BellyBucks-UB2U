import 'package:bellybucks/screens/cart%20screen/cart_screen.dart';
import 'package:bellybucks/screens/home%20screen/home_screen.dart';
import 'package:bellybucks/screens/user%20profile%20screen/user_screen.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class BottomBarNavigation extends StatefulWidget {
  const BottomBarNavigation({Key? key}) : super(key: key);

  @override
  State<BottomBarNavigation> createState() => _BottomBarNavigationState();
}

class _BottomBarNavigationState extends State<BottomBarNavigation> {
  int _page = 0;
  final GlobalKey<CurvedNavigationBarState> _bottomNavigationKey = GlobalKey();

  final screens = [
    const HomeScreen(),
    const CartScreen(),
    const UserScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
          extendBody: true,
          bottomNavigationBar: CurvedNavigationBar(
            key: _bottomNavigationKey,
            index: 0,
            height: 60.0,
            items: const <Widget>[
              Icon(Icons.home_outlined, size: 30, color: Colors.white),
              Icon(Icons.shopping_bag_outlined, size: 30, color: Colors.white),
              Icon(Icons.perm_identity, size: 30, color: Colors.white),
            ],
            color: const Color(0xffE5413F),
            buttonBackgroundColor: const Color(0xffE5413F),
            backgroundColor: Colors.white,
            animationCurve: Curves.easeInOut,
            animationDuration: const Duration(milliseconds: 600),
            onTap: (index) {
              setState(() {
                _page = index;
              });
            },
            letIndexChange: (index) => true,
          ),
          body: screens[_page]),
    );
  }
}
