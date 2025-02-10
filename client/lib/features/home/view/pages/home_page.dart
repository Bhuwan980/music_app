import 'package:client/core/theme/app_pallet.dart';
import 'package:client/features/home/view/pages/add_song.dart';
import 'package:client/features/home/view/pages/landing_page.dart';
import 'package:client/features/home/view/pages/library_page.dart';
import 'package:client/features/home/view/pages/search_page.dart';
import 'package:client/features/home/view/widgets/sliding_drawer.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class HomePage extends ConsumerStatefulWidget {
  const HomePage({super.key});

  @override
  ConsumerState<HomePage> createState() => _HomePageState();
}

class _HomePageState extends ConsumerState<HomePage> {
  int _selectedIndex = 0;
  bool _isDrawerOpen = false;

  final List<Widget> _pages = [
    LandingPage(),
    SearchPage(),
    AddSong(),
    LibraryPage(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  void _toggleDrawer() {
    setState(() {
      _isDrawerOpen = !_isDrawerOpen;
    });
  }

  // Future<void> _logout() async {
  //   IconButton(
  //     icon: const Icon(Icons.logout),
  //     onPressed: () {
  //       final authViewModel = ref.read(authViewModelProvider.notifier);
  //       authViewModel.logout(context);
  //     },
  //   );
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Scaffold(
            appBar: AppBar(
              leading: GestureDetector(
                onTap: _toggleDrawer,
                child: Padding(
                  padding: const EdgeInsets.only(left: 10),
                  child: const CircleAvatar(
                    radius: 18,
                    backgroundImage: AssetImage('assets/images/image.png'),
                  ),
                ),
              ),
            ),
            body: _pages[_selectedIndex],
            bottomNavigationBar: BottomNavigationBar(
              type: BottomNavigationBarType.fixed,
              showSelectedLabels: false,
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
                  icon: Icon(Icons.list_outlined),
                  activeIcon: Icon(Icons.list),
                  label: 'Playlist',
                ),
              ],
            ),
          ),

          // Sliding Drawer
          if (_isDrawerOpen)
            GestureDetector(
              onTap: _toggleDrawer, // Tap outside to close
              child: SizedBox(
                width: double.infinity,
                height: double.infinity,
              ),
            ),

          SlidingDrawer(isOpen: _isDrawerOpen, onClose: _toggleDrawer),
        ],
      ),
    );
  }
}
