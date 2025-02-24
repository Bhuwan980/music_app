import 'package:client/features/auth/modelview/auth_viewmodel.dart';
import 'package:client/features/home/view/pages/profile_page.dart';
import 'package:client/features/home/view/pages/settings_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class SlidingDrawer extends ConsumerStatefulWidget {
  final bool isOpen;
  final VoidCallback onClose;

  const SlidingDrawer({
    super.key,
    required this.isOpen,
    required this.onClose,
  });

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _SlidingDrawerState();
}

class _SlidingDrawerState extends ConsumerState<SlidingDrawer> {
  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;

    return Stack(
      children: [
        // ✅ Tap outside the drawer to close
        if (widget.isOpen)
          GestureDetector(
            onTap: widget.onClose, // Close when tapping outside
            child: Container(
              color: Colors.black.withOpacity(0.5), // Dark overlay effect
              width: double.infinity,
              height: double.infinity,
            ),
          ),

        // ✅ Sliding Drawer Animation
        AnimatedPositioned(
          duration: const Duration(milliseconds: 300),
          left: widget.isOpen ? 0 : -screenWidth * 0.8, // Slide in/out
          top: 0,
          bottom: 0,
          width: screenWidth * 0.8, // Drawer width (80% of screen)
          child: GestureDetector(
            onHorizontalDragUpdate: (details) {
              if (details.primaryDelta! < -10) {
                widget.onClose(); // Swipe left to close
              }
            },
            child: Container(
              color: Colors.black, // Drawer background
              padding: const EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(top: 20),
                    child: Align(
                      alignment: Alignment.topRight,
                      child: IconButton(
                        icon: const Icon(Icons.close, color: Colors.white),
                        onPressed: widget.onClose, // Close drawer
                      ),
                    ),
                  ),
                  const CircleAvatar(
                    radius: 40,
                    backgroundImage: AssetImage('assets/images/13.png'),
                  ),
                  const SizedBox(height: 10),
                  const Text(
                    "Bhuwan Bahadur Neupane",
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 18,
                        fontWeight: FontWeight.bold),
                  ),
                  ListTile(
                    leading: const Icon(Icons.person, color: Colors.white),
                    title: const Text("Profile",
                        style: TextStyle(color: Colors.white)),
                    onTap: () {
                      widget.onClose(); // Close the drawer first
                      Future.delayed(Duration(milliseconds: 300), () {
                        Navigator.push(context,
                            MaterialPageRoute(builder: (context) {
                          return ProfilePage();
                        }));
                      });
                    },
                  ),
                  ListTile(
                    leading: const Icon(Icons.settings, color: Colors.white),
                    title: const Text("Settings",
                        style: TextStyle(color: Colors.white)),
                    onTap: () {
                      widget.onClose();
                      Navigator.push(context,
                          MaterialPageRoute(builder: (context) {
                        return SettingsPage();
                      }));
                    },
                  ),
                  ListTile(
                    leading: const Icon(Icons.logout, color: Colors.red),
                    title: const Text("Logout",
                        style: TextStyle(color: Colors.red)),
                    onTap: () {
                      final authViewModel =
                          ref.read(authViewModelProvider.notifier);
                      authViewModel.logout(context);
                    },
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}
