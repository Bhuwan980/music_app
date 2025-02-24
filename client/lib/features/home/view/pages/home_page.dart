import 'package:client/core/theme/app_pallet.dart';
// import 'package:client/features/home/view/pages/add_song.dart';
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

  void _showNotificationSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      //backgroundColor: Pallete.backgroundColor, // Adjust to match your theme
      builder: (context) {
        return Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisSize: MainAxisSize.min, // Only take necessary height
            children: [
              // Title
              const Text(
                "Notifications",
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 10),

              // Sample Notifications
              _buildNotificationItem("New Song Added!", "assets/images/1.png"),
              _buildNotificationItem(
                  "Your playlist got 10 likes!", "assets/images/2.png"),
              _buildNotificationItem(
                  "A new album is out!", "assets/images/3.png"),

              const SizedBox(height: 10),
            ],
          ),
        );
      },
    );
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
  String getAppBarTitle() {
    switch (_selectedIndex) {
      case 0:
        return "Welcome,Bhuwan";
      case 1:
        return "Search";
      case 2:
        return "Your Library";
      // case 4:
      //   return "Profile";
      default:
        return "Music App";
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Pallete.backgroundColor,
      body: Stack(
        children: [
          Scaffold(
            appBar: AppBar(
              backgroundColor: Pallete.backgroundColor,
              //shadowColor: Pallete.backgroundColor,
              //foregroundColor: Pallete.backgroundColor,
              surfaceTintColor: Pallete.backgroundColor,
              leading: GestureDetector(
                onTap: _toggleDrawer,
                child: Padding(
                  padding: const EdgeInsets.only(left: 10),
                  child: const CircleAvatar(
                    radius: 18,
                    backgroundImage: AssetImage('assets/images/13.png'),
                  ),
                ),
              ),
              centerTitle: false,
              title: Text(
                getAppBarTitle(),
                style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              actions: [
                IconButton(
                  onPressed: () {
                    _showNotificationSheet(context); // Show bottom
                  },
                  icon: Icon(Icons.notifications),
                )
              ],
            ),
            body: _pages[_selectedIndex],
            bottomNavigationBar: Container(
              decoration: BoxDecoration(
                color: Colors.transparent, // Transparent background
                borderRadius: BorderRadius.circular(30), // Rounded edges
              ),
              padding: const EdgeInsets.symmetric(
                  horizontal: 30, vertical: 15), // Adds space around
              child: ClipRRect(
                borderRadius: BorderRadius.circular(30), // Rounded edges
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.transparent, // Transparent background
                    borderRadius: BorderRadius.circular(30), // Rounded edges
                  ),
                  child: BottomNavigationBar(
                    elevation: 10, // Elevation for shadow effect
                    type: BottomNavigationBarType.fixed,
                    backgroundColor:
                        Pallete.transparentColor, // Background color
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
                        icon: Icon(Icons.my_library_music_outlined),
                        activeIcon: Icon(Icons.library_music),
                        label: 'Playlist',
                      ),
                    ],
                  ),
                ),
              ),
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

Widget _buildNotificationItem(String text, String imagePath) {
  return Padding(
    padding: const EdgeInsets.symmetric(vertical: 8.0),
    child: Row(
      children: [
        // Notification Image
        ClipRRect(
          borderRadius: BorderRadius.circular(8),
          child:
              Image.asset(imagePath, width: 40, height: 40, fit: BoxFit.cover),
        ),
        const SizedBox(width: 10),

        // Notification Text
        Expanded(
          child: Text(
            text,
            style: TextStyle(fontSize: 14, color: Colors.white),
          ),
        ),
      ],
    ),
  );
}
