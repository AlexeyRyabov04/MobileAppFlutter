import 'package:flutter/material.dart';
import '../services/AuthService.dart';
import 'account_page.dart';
import 'featured_page.dart';
import 'home_page.dart';

class MainPage extends StatefulWidget {
  const MainPage({super.key});

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  int _currentIndex = 0;

  void logout() async{
    final authService = AuthService();
    authService.signOut();
  }

  final pages = [
    HomePage(),
    FeaturedPage(),
    AccountPage(),
    null,
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Фильмы")),
      body: pages[_currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        type: BottomNavigationBarType.fixed,
        selectedFontSize: 18,
        unselectedFontSize: 16,
        items: [
          BottomNavigationBarItem(
            icon: const Icon(Icons.home),
            label: "Главная",
            backgroundColor: Theme.of(context).colorScheme.primary,

          ),
          BottomNavigationBarItem(
            icon: const Icon(Icons.star),
            label: "Избранное",
            backgroundColor: Theme.of(context).colorScheme.primary,
          ),
          BottomNavigationBarItem(
            icon: const Icon(Icons.person),
            label: "Аккаунт",
            backgroundColor: Theme.of(context).colorScheme.primary,
          ),
          BottomNavigationBarItem(
            icon: const Icon(Icons.logout),
            label: "Выход",
            backgroundColor: Theme.of(context).colorScheme.primary,
          ),
        ],
        onTap: (index){
          if (index == 3){
            final authService = AuthService();
            authService.signOut();
          }
          else {
            setState(() {
              _currentIndex = index;
            });
          }
        },
      ),
    );
  }
}
