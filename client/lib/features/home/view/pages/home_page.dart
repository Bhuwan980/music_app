import 'package:client/core/theme/app_pallet.dart';
import 'package:client/features/home/view/pages/add_song.dart';
import 'package:client/features/home/view/pages/landing_page.dart';
import 'package:client/features/home/view/pages/playlist_page.dart';
import 'package:client/features/home/view/pages/profile_page.dart';
import 'package:client/features/home/view/pages/search_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:client/features/auth/repositories/auth_local_repositories.dart';
import 'package:client/features/auth/view/pages/login_page.dart';

class HomePage extends ConsumerStatefulWidget {
  const HomePage({super.key});

  @override
  ConsumerState<HomePage> createState() => _HomePageState();
}

class _HomePageState extends ConsumerState<HomePage> {
  int _selectedIndex = 0;
  final List<Widget> _pages = [
    LandingPage(),
    SearchPage(),
    AddSong(),
    PlaylistPage(),
    ProfilePage(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  Future<void> _logout() async {
    final authRepo = ref.read(authLocalRepositoriesProvider);
    await authRepo.removeToken();
    if (mounted) {
      Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(builder: (context) => const LoginPage()),
        (route) => false,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: _selectedIndex == 4
            ? IconButton(
                // Bell icon on the left (Profile Page)
                icon: const Icon(Icons.notifications),
                onPressed: () => print("🔔 Notification Clicked"),
              )
            : null, // No leading icon for other pages

        actions: _selectedIndex == 4
            ? [
                // Show Settings icon on the right (Profile Page)
                IconButton(
                  icon: const Icon(Icons.settings),
                  onPressed: () => print("⚙️ Settings Clicked"),
                ),
              ]
            : [
                // Show Logout button for other pages
                IconButton(
                  icon: const Icon(Icons.logout),
                  onPressed: _logout,
                ),
              ],
        //[
        //   // IconButton(
        //   //   icon: Icon(Icons.logout),
        //   //   onPressed: _logout,
        //   // ),
        // ],
      ),
      body: _pages[_selectedIndex],
      bottomNavigationBar: BottomNavigationBar(
          type: BottomNavigationBarType.fixed,
          showSelectedLabels: false,
          //backgroundColor: Pallete.transparentColor,
          selectedItemColor: Pallete.gradient1,
          showUnselectedLabels: false,
          currentIndex: _selectedIndex,
          onTap: _onItemTapped,
          items: const [
            BottomNavigationBarItem(
              icon: Icon(Icons.home_outlined),
              activeIcon: Icon(Icons.home),
              label: 'Home',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.search_outlined),
              activeIcon: Icon(Icons.search),
              label: 'Search',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.add_outlined),
              activeIcon: Icon(Icons.add),
              label: 'Add Song',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.library_music_outlined),
              activeIcon: Icon(Icons.library_music),
              label: 'Playlist',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.person_outlined),
              activeIcon: Icon(Icons.person),
              label: 'Profile',
            ),
          ]),
    );
  }
}
