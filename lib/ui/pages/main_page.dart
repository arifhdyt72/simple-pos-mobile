import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:simple_pos/providers/page_provider.dart';
import 'package:simple_pos/shared/theme.dart';
import 'package:simple_pos/ui/pages/home_page.dart';
import 'package:simple_pos/ui/pages/item_page.dart';
import 'package:simple_pos/ui/pages/penjualan_page.dart';
import 'package:simple_pos/ui/pages/profile_page.dart';

class MainPage extends StatefulWidget {
  const MainPage({super.key});

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  Widget body(currentIndex) {
    switch (currentIndex) {
      case 0:
        return const HomePage();
      case 1:
        return const ItemPage();
      case 2:
        return const PenjualanPage();
      case 3:
        return const ProfilePage();
      default:
        return const HomePage();
    }
  }

  @override
  Widget build(BuildContext context) {
    int currentIndex = Provider.of<PageProvider>(context).currentIndex;
    return Scaffold(
      bottomNavigationBar: BottomAppBar(
        color: whiteColor,
        shape: const CircularNotchedRectangle(),
        clipBehavior: Clip.antiAlias,
        notchMargin: 6,
        elevation: 0,
        child: BottomNavigationBar(
          currentIndex: currentIndex,
          onTap: (value) {
            Provider.of<PageProvider>(context, listen: false)
                .setCurrentIndex(value);
          },
          type: BottomNavigationBarType.fixed,
          backgroundColor: whiteColor,
          elevation: 0,
          selectedItemColor: blueColor,
          unselectedItemColor: blackColor,
          showSelectedLabels: true,
          showUnselectedLabels: true,
          selectedLabelStyle: blueTextStyle.copyWith(
            fontSize: 10,
            fontWeight: medium,
          ),
          unselectedLabelStyle: blackTextStyle.copyWith(
            fontSize: 10,
            fontWeight: medium,
          ),
          items: [
            BottomNavigationBarItem(
              icon: Image.asset(
                'assets/ic_overview.png',
                width: 20,
                color: currentIndex == 0 ? blueColor : blackColor,
              ),
              label: 'Home',
            ),
            BottomNavigationBarItem(
              icon: Image.asset(
                'assets/ic_food.png',
                width: 20,
                color: currentIndex == 1 ? blueColor : blackColor,
              ),
              label: 'Item',
            ),
            BottomNavigationBarItem(
              icon: Image.asset(
                'assets/ic_statistic.png',
                width: 20,
                color: currentIndex == 2 ? blueColor : blackColor,
              ),
              label: 'Penjualan',
            ),
            BottomNavigationBarItem(
              icon: Image.asset(
                'assets/ic_edit_profile.png',
                width: 20,
                color: currentIndex == 3 ? blueColor : blackColor,
              ),
              label: 'Profil',
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.pushNamed(
            context,
            '/cart',
          );
        },
        backgroundColor: purpleColor,
        child: Image.asset(
          'assets/icon_cart.png',
          width: 20,
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      body: body(currentIndex),
    );
  }
}
